import std/[strutils, sequtils, pegs]
import shellsophia/[shell, commands/c2nim]
import astutils
import "$nim"/compiler/[renderer, idents, options]

proc remove(content: var string; ranges: varargs[HSlice[string, string]]) =
  for range in ranges:
    while true:
      var s, e: int
      s = content.find(range.a)
      if s >= 0:
        e = content.find(range.b, s.succ)
        if e >= 0:
          content = content[0..<s] & content[e+range.b.len..^1]
      else:
        break

proc camel(snake: string; capitalize = false): string =
  result = snake
  result[0] =
    if capitalize: snake[0].toUpperAscii
    else: snake[0].toLowerAscii
  for i in countdown(snake.high, 1):
    case snake[i.pred]
    of '_': result[i] = snake[i].toUpperAscii
    of 'A'..'Z': result[i] = snake[i].toLowerAscii
    else: discard
  result = result.replace("_", "")

proc replaceAll(str: string; targets: openArray[(Peg, string)]): string =
  result = str
  for target in targets:
    result = result.replace(target[0], target[1])

template expect(ast: PNode; kinds: set[TNodeKind]): untyped =
  if ast.kind notin kinds:
    raise newException(CatchableError, "unexpected node " & $ast.kind & " is given:\n" & $ast)

proc sortByKinds(ast: PNode; kinds: openArray[TNodeKind]): PNode =
  ast.expect {nkStmtList}
  result = newNode nkStmtList
  for kind in kinds.deduplicate:
    for stmt in ast:
      if stmt.kind == kind:
        result.add stmt

  var kindset: set[TNodeKind]
  for kind in kinds:
    kindset.incl kind

  for stmt in ast:
    if stmt.kind notin kindset:
      result.add stmt

proc preprocess(str: string): string =
  result = str
  result.remove("#if !defined (PIXMAN_DONT_DEFINE_STDINT)".."#endif\n\n#endif")
  result.remove("#ifdef PIXMAN_USE_INTERNAL_API".."#endif")
  result.remove("#ifdef  __cplusplus".."#endif")
  result.remove("/*".."*/")
  result = result.replace("_xor", "xor")
  # block:
  #   var startif = result.find("#if PIXMAN_MAX_INDEXED")
  #   var endif = result.find("\n", startif)
  #   var startendif = result.find("#endif", endif)
  #   var endendif = result.find("\n", endif)
  #   result.delete(startendif..endendif)
  #   result.delete(startif..endif)

const typesToCapitalize = [
  "pixman_index_type",
  "pixman_image",
  "pixman_bool_t",
  "pixman_fixed_32_32_t",
  "pixman_fixed_48_16_t",
  "pixman_fixed_1_31_t",
  "pixman_fixed_1_16_t",
  "pixman_fixed_16_16_t",
  "pixman_fixed_t",
  "pixman_color_t",
  "pixman_point_fixed_t",
  "pixman_line_fixed_t",
  "pixman_vector_t",
  "pixman_transform_t",
  "pixman_color",
  "pixman_point_fixed",
  "pixman_line_fixed",
  "pixman_vector",
  "pixman_transform",
  "pixman_image_t",
  "pixman_f_transform_t",
  "pixman_f_vector_t",
  "pixman_f_vector",
  "pixman_f_transform",
  "pixman_repeat_t",
  "pixman_dither_t",
  "pixman_filter_t",
  "pixman_op_t",
  "pixman_region16_data_t",
  "pixman_box16_t",
  "pixman_rectangle16_t",
  "pixman_region16_t",
  "pixman_region16_data",
  "pixman_rectangle16",
  "pixman_box16",
  "pixman_region16",
  "pixman_region_overlap_t",
  "pixman_region32_data_t",
  "pixman_box32_t",
  "pixman_rectangle32_t",
  "pixman_region32_t",
  "pixman_region32_data",
  "pixman_rectangle32",
  "pixman_box32",
  "pixman_region32",
  "pixman_region64f_data_t",
  "pixman_box64f_t",
  "pixman_rectangle64f_t",
  "pixman_region64f_t",
  "pixman_region64f_data",
  "pixman_rectangle64f",
  "pixman_box64f",
  "pixman_region64f",
  "pixman_indexed_t",
  "pixman_gradient_stop_t",
  "pixman_read_memory_func_t",
  "pixman_write_memory_func_t",
  "pixman_image_destroy_func_t",
  "pixman_gradient_stop",
  "pixman_indexed",
  "pixman_format_code_t",
  "pixman_kernel_t",
  "pixman_glyph_cache_t",
  "pixman_glyph_t",
  "pixman_edge_t",
  "pixman_trapezoid_t",
  "pixman_trap_t",
  "pixman_span_fix_t",
  "pixman_triangle_t",
  "pixman_edge",
  "pixman_trapezoid",
  "pixman_triangle",
  "pixman_span_fix",
  "pixman_trap",
]

const rawPegsToReplace = {
  "pixman_transform_!(t$)!(from_pixman_f_transform$)": "",
  "pixman_f_transform_!(t$)!(from_pixman_transform$)": "",
  "pixman_region32_!(t$)!(data$)!(data_t)": "",
  "pixman_region64_!(t$)!(data$)!(data_t)": "",
  "pixman_region64f_!(t$)!(data$)!(data_t)": "",
  "pixman_region_!(overlap_t$)": "",
  "pixman_glyph_cache_create": "create_glyph_cache",
  "pixman_glyph_cache_!(t$)": "",
  "pixman_glyph_!(cache.*)!(t$)": "",
  "pixman_format_!(code_t$)": "",
  "pixman_image_!(t$)!(destroy_func_t$)": "",
  "^ref$": "`ref`",
}


proc postprocess(ast: PNode): Pnode =
  let pegsToReplace = rawPegsToReplace.mapIt((it[0].parsePeg(), it[1]))
  result = newNode(nkStmtList)
  ast.margeSection(nkTypeSection)
  ast.margeSection(nkConstSection)
  var i: int
  while i < ast.sons.len:
    var stmt = ast[i]
    case stmt.kind
    of nkTemplateDef:
      ast.delSon(i)
      continue
    of nkConstSection:
      var i: int
      var sepalated = newNode nkConstSection
      result.add sepalated
      while i < stmt.sons.len:
        let constdef = stmt[i]
        let id = constdef[0][1]
        if id.ident.s == "PIXMAN_MAX_INDEXED" or id.ident.s.startsWith"PIXMAN_TYPE_":
          sepalated.add constdef
          stmt.delSon(i)
        else:
          inc i
    of nkTypeSection:
      var i = 0
      while i < stmt.sons.len:
        var typedef = stmt[i]
        var ident: PNode = typedef
        while ident.kind != nkIdent:
          case ident.kind
          of nkTypeDef:
            ident = ident[0]
          of nkPragmaExpr:
            ident = ident[0]
          of nkPostfix:
            ident = ident[1]
          else:
            break
        if ident.ident.s == "pixman_glyph_t":
          stmt.sons.insert(nkTypeDef.newTree(
            nkPostfix.newTree(
              ident("*"),
              ident("pixman_glyph_cache_t"),
            ),
            newNode(nkEmpty),
            newNode(nkObjectTy),
          ), i)
          inc i
        case typedef[2].kind
        of nkEnumTy:
          let enumty = typedef[2]
          var i: int = 1
          while i < enumty.len:
            if enumty[i].kind == nkEnumFieldDef and enumty[i][0].ident.s in ["PIXMAN_x4c4", "PIXMAN_x4g4"]:
              enumty.delSon(i)
            else:
              inc i
        of nkIdent:
          case typedef[2].ident.s
          of "pixman_glyph_cache_t":
            typedef[2] = newNode(nkObjectTy)
        else: discard
        inc i
    else: discard
    inc i
  result.sons.add ast.sortByKinds([nkWhenStmt, nkTypeSection]).sons
  result = result.map proc(ast: PNode): Pnode =
    case ast.kind
    of nkIdent:
      if ast.ident.s.startsWith"pixman_" or ast.ident.s.startsWith"PIXMAN_":
        ast.ident.s = ast.ident.s
          .replaceAll(pegsToReplace)
          .multiReplace(("pixman_", ""), ("PIXMAN_", ""))
          .camel(ast.ident.s in typesToCapitalize)
      ast
    else:
      ast

discard cd"."
  .c2nim(C2NimArgs(
    `in`: @["pixman.c", "pixman.c2nim", "../pixman/pixman/pixman.h"],
    `out`: "../src/pixman/includes/pixman_core.nim",
    preprocess: preprocess,
    postprocess: postprocess,
    dynlib: "libpixman-1.so",
    stdints: on, skipComments: on,
  ))