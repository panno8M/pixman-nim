import std/[strutils, sequtils]
import shellsophia/[shell, commands/c2nim]
import astutils
import "$nim"/compiler/[renderer, parser, idents, options]

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
  # block:
  #   var startif = result.find("#if PIXMAN_MAX_INDEXED")
  #   var endif = result.find("\n", startif)
  #   var startendif = result.find("#endif", endif)
  #   var endendif = result.find("\n", endif)
  #   result.delete(startendif..endendif)
  #   result.delete(startif..endif)

proc postprocess(ast: PNode): Pnode =
  result = newNode(nkStmtList)
  result.add parseString("include includes/templates", newIdentCache(), newConfigRef())
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
      for typedef in stmt:
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
          echo typedef[2].ident.s
          case typedef[2].ident.s
          of "pixmanGlyphCacheT":
            typedef[2] = newNode(nkObjectTy)
        else: discard
    else: discard
    inc i
  result.sons.add ast.sortByKinds([nkWhenStmt, nkTypeSection]).sons
  result = result.map proc(ast: PNode): Pnode =
    case ast.kind
    of nkIdent:
      ast.ident.s = ast.ident.s.multiReplace(("pixman", ""), ("Pixman", ""), ("PIXMAN_", ""))
      while ast.ident.s.startsWith "_":
        ast.ident.s.delete(0..0)
      ast
    else:
      ast

discard cd"."
  .c2nim(C2NimArgs(
    `in`: @["pixman.c", "pixman.c2nim", "../pixman/pixman/pixman.h"],
    `out`: "../src/pixman.nim",
    preprocess: preprocess,
    postprocess: postprocess,
    dynlib: "libpixman-1.so",
    stdints: on, skipComments: on, nep1: on,
  ))