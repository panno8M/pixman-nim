
include
  includes / templates

const
  maxIndexed* = 256
  typeOther* = 0
  typeA* = 1
  typeArgb* = 2
  typeAbgr* = 3
  typeColor* = 4
  typeGray* = 5
  typeYuy2* = 6
  typeYv12* = 7
  typeBgra* = 8
  typeRgba* = 9
  typeArgbSrgb* = 10
  typeRgbaFloat* = 11
when maxIndexed <= 256:
  type
    IndexType* = uint8
type
  Image* {.bycopy.} = object
  BoolT* = cint
  Fixed3232T* = int64
  Fixed4816T* = Fixed3232T
  Fixed131T* = uint32
  Fixed116T* = uint32
  Fixed1616T* = int32
  FixedT* = Fixed1616T
  ColorT* = Color
  PointFixedT* = PointFixed
  LineFixedT* = LineFixed
  VectorT* = Vector
  TransformT* = Transform
  Color* {.bycopy.} = object
    red*: uint16
    green*: uint16
    blue*: uint16
    alpha*: uint16
  PointFixed* {.bycopy.} = object
    x*: FixedT
    y*: FixedT
  LineFixed* {.bycopy.} = object
    p1*: PointFixedT
    p2*: PointFixedT
  Vector* {.bycopy.} = object
    vector*: array[3, FixedT]
  Transform* {.bycopy.} = object
    matrix*: array[3, array[3, FixedT]]
  ImageT* = Image
  FTransformT* = FTransform
  FVectorT* = FVector
  FVector* {.bycopy.} = object
    v*: array[3, cdouble]
  FTransform* {.bycopy.} = object
    m*: array[3, array[3, cdouble]]
  RepeatT* {.size: sizeof(cint).} = enum
    repeatNone, repeatNormal, repeatPad, repeatReflect
  DitherT* {.size: sizeof(cint).} = enum
    ditherNone, ditherFast, ditherGood, ditherBest, ditherOrderedBayer8,
    ditherOrderedBlueNoise64
  FilterT* {.size: sizeof(cint).} = enum
    filterFast, filterGood, filterBest, filterNearest, filterBilinear,
    filterConvolution, filterSeparableConvolution
  OpT* {.size: sizeof(cint).} = enum
    opClear = 0x00000000, opSrc = 0x00000001, opDst = 0x00000002,
    opOver = 0x00000003, opOverReverse = 0x00000004, opIn = 0x00000005,
    opInReverse = 0x00000006, opOut = 0x00000007, opOutReverse = 0x00000008,
    opAtop = 0x00000009, opAtopReverse = 0x0000000A, opXor = 0x0000000B,
    opAdd = 0x0000000C, opSaturate = 0x0000000D, opDisjointClear = 0x00000010,
    opDisjointSrc = 0x00000011, opDisjointDst = 0x00000012,
    opDisjointOver = 0x00000013, opDisjointOverReverse = 0x00000014,
    opDisjointIn = 0x00000015, opDisjointInReverse = 0x00000016,
    opDisjointOut = 0x00000017, opDisjointOutReverse = 0x00000018,
    opDisjointAtop = 0x00000019, opDisjointAtopReverse = 0x0000001A,
    opDisjointXor = 0x0000001B, opConjointClear = 0x00000020,
    opConjointSrc = 0x00000021, opConjointDst = 0x00000022,
    opConjointOver = 0x00000023, opConjointOverReverse = 0x00000024,
    opConjointIn = 0x00000025, opConjointInReverse = 0x00000026,
    opConjointOut = 0x00000027, opConjointOutReverse = 0x00000028,
    opConjointAtop = 0x00000029, opConjointAtopReverse = 0x0000002A,
    opConjointXor = 0x0000002B, opMultiply = 0x00000030, opScreen = 0x00000031,
    opOverlay = 0x00000032, opDarken = 0x00000033, opLighten = 0x00000034,
    opColorDodge = 0x00000035, opColorBurn = 0x00000036,
    opHardLight = 0x00000037, opSoftLight = 0x00000038,
    opDifference = 0x00000039, opExclusion = 0x0000003A, opHslHue = 0x0000003B,
    opHslSaturation = 0x0000003C, opHslColor = 0x0000003D,
    opHslLuminosity = 0x0000003E
  Region16DataT* = Region16Data
  Box16T* = Box16
  Rectangle16T* = Rectangle16
  Region16T* = Region16
  Region16Data* {.bycopy.} = object
    size*: clong
    numRects*: clong
  Rectangle16* {.bycopy.} = object
    x*: int16
    y*: int16
    width*: uint16
    height*: uint16
  Box16* {.bycopy.} = object
    x1*: int16
    y1*: int16
    x2*: int16
    y2*: int16
  Region16* {.bycopy.} = object
    extents*: Box16T
    data*: ptr Region16DataT
  RegionOverlapT* {.size: sizeof(cint).} = enum
    regionOut, regionIn, regionPart
  Region32DataT* = Region32Data
  Box32T* = Box32
  Rectangle32T* = Rectangle32
  Region32T* = Region32
  Region32Data* {.bycopy.} = object
    size*: clong
    numRects*: clong
  Rectangle32* {.bycopy.} = object
    x*: int32
    y*: int32
    width*: uint32
    height*: uint32
  Box32* {.bycopy.} = object
    x1*: int32
    y1*: int32
    x2*: int32
    y2*: int32
  Region32* {.bycopy.} = object
    extents*: Box32T
    data*: ptr Region32DataT
  Region64fDataT* = Region64fData
  Box64fT* = Box64f
  Rectangle64fT* = Rectangle64f
  Region64fT* = Region64f
  Region64fData* {.bycopy.} = object
    size*: clong
    numRects*: clong
  Rectangle64f* {.bycopy.} = object
    x*: cdouble
    y*: cdouble
    width*: cdouble
    height*: cdouble
  Box64f* {.bycopy.} = object
    x1*: cdouble
    y1*: cdouble
    x2*: cdouble
    y2*: cdouble
  Region64f* {.bycopy.} = object
    extents*: Box64fT
    data*: ptr Region64fDataT
  IndexedT* = Indexed
  GradientStopT* = GradientStop
  ReadMemoryFuncT* = proc (src: pointer; size: cint): uint32
  WriteMemoryFuncT* = proc (dst: pointer; value: uint32; size: cint)
  ImageDestroyFuncT* = proc (image: ptr ImageT; data: pointer)
  GradientStop* {.bycopy.} = object
    x*: FixedT
    color*: ColorT
  Indexed* {.bycopy.} = object
    color*: BoolT
    rgba*: array[maxIndexed, uint32]
    ent*: array[32768, IndexType]
  FormatCodeT* {.size: sizeof(cint).} = enum
    rgbaFloat = formatByte(128, typeRgbaFloat, 32, 32, 32, 32),
    rgbFloat = formatByte(96, typeRgbaFloat, 0, 32, 32, 32),
    a16b16g16r16 = formatByte(64, typeAbgr, 16, 16, 16, 16),
    a8r8g8b8 = format(32, typeArgb, 8, 8, 8, 8),
    x8r8g8b8 = format(32, typeArgb, 0, 8, 8, 8),
    a8b8g8r8 = format(32, typeAbgr, 8, 8, 8, 8),
    x8b8g8r8 = format(32, typeAbgr, 0, 8, 8, 8),
    b8g8r8a8 = format(32, typeBgra, 8, 8, 8, 8),
    b8g8r8x8 = format(32, typeBgra, 0, 8, 8, 8),
    r8g8b8a8 = format(32, typeRgba, 8, 8, 8, 8),
    r8g8b8x8 = format(32, typeRgba, 0, 8, 8, 8),
    x14r6g6b6 = format(32, typeArgb, 0, 6, 6, 6),
    x2r10g10b10 = format(32, typeArgb, 0, 10, 10, 10),
    a2r10g10b10 = format(32, typeArgb, 2, 10, 10, 10),
    x2b10g10r10 = format(32, typeAbgr, 0, 10, 10, 10),
    a2b10g10r10 = format(32, typeAbgr, 2, 10, 10, 10),
    a8r8g8b8SRgb = format(32, typeArgbSrgb, 8, 8, 8, 8),
    r8g8b8SRgb = format(24, typeArgbSrgb, 0, 8, 8, 8),
    r8g8b8 = format(24, typeArgb, 0, 8, 8, 8),
    b8g8r8 = format(24, typeAbgr, 0, 8, 8, 8),
    r5g6b5 = format(16, typeArgb, 0, 5, 6, 5),
    b5g6r5 = format(16, typeAbgr, 0, 5, 6, 5),
    a1r5g5b5 = format(16, typeArgb, 1, 5, 5, 5),
    x1r5g5b5 = format(16, typeArgb, 0, 5, 5, 5),
    a1b5g5r5 = format(16, typeAbgr, 1, 5, 5, 5),
    x1b5g5r5 = format(16, typeAbgr, 0, 5, 5, 5),
    a4r4g4b4 = format(16, typeArgb, 4, 4, 4, 4),
    x4r4g4b4 = format(16, typeArgb, 0, 4, 4, 4),
    a4b4g4r4 = format(16, typeAbgr, 4, 4, 4, 4),
    x4b4g4r4 = format(16, typeAbgr, 0, 4, 4, 4),
    a8 = format(8, typeA, 8, 0, 0, 0), r3g3b2 = format(8, typeArgb, 0, 3, 3, 2),
    b2g3r3 = format(8, typeAbgr, 0, 3, 3, 2),
    a2r2g2b2 = format(8, typeArgb, 2, 2, 2, 2),
    a2b2g2r2 = format(8, typeAbgr, 2, 2, 2, 2),
    c8 = format(8, typeColor, 0, 0, 0, 0), g8 = format(8, typeGray, 0, 0, 0, 0),
    x4a4 = format(8, typeA, 4, 0, 0, 0), a4 = format(4, typeA, 4, 0, 0, 0),
    r1g2b1 = format(4, typeArgb, 0, 1, 2, 1),
    b1g2r1 = format(4, typeAbgr, 0, 1, 2, 1),
    a1r1g1b1 = format(4, typeArgb, 1, 1, 1, 1),
    a1b1g1r1 = format(4, typeAbgr, 1, 1, 1, 1),
    c4 = format(4, typeColor, 0, 0, 0, 0), g4 = format(4, typeGray, 0, 0, 0, 0),
    a1 = format(1, typeA, 1, 0, 0, 0), g1 = format(1, typeGray, 0, 0, 0, 0),
    yuy2 = format(16, typeYuy2, 0, 0, 0, 0),
    yv12 = format(12, typeYv12, 0, 0, 0, 0)
  KernelT* {.size: sizeof(cint).} = enum
    kernelImpulse, kernelBox, kernelLinear, kernelCubic, kernelGaussian,
    kernelLanczos2, kernelLanczos3, kernelLanczos3Stretched
  GlyphCacheT* = object
  GlyphT* {.bycopy.} = object
    x*: cint
    y*: cint
    glyph*: pointer
  EdgeT* = Edge
  TrapezoidT* = Trapezoid
  TrapT* = Trap
  SpanFixT* = SpanFix
  TriangleT* = Triangle
  Edge* {.bycopy.} = object
    x*: FixedT
    e*: FixedT
    stepx*: FixedT
    signdx*: FixedT
    dy*: FixedT
    dx*: FixedT
    stepx_small*: FixedT
    stepx_big*: FixedT
    dx_small*: FixedT
    dx_big*: FixedT
  Trapezoid* {.bycopy.} = object
    top*: FixedT
    bottom*: FixedT
    left*: LineFixedT
    right*: LineFixedT
  Triangle* {.bycopy.} = object
    p1*: PointFixedT
    p2*: PointFixedT
    p3*: PointFixedT
  SpanFix* {.bycopy.} = object
    l*: FixedT
    r*: FixedT
    y*: FixedT
  Trap* {.bycopy.} = object
    top*: SpanFixT
    bot*: SpanFixT
const
  fixedE* = (cast[FixedT](1))
  fixed1* = (intToFixed(1))
  fixed1MinusE* = (fixed1 - fixedE)
  fixedMinus1* = (intToFixed(-1))
  maxFixed4816* = (cast[Fixed4816T](0x7FFFFFFF))
  minFixed4816* = (-(cast[Fixed4816T](1) shl 31))
discard "forward decl of pixman_box16"
proc transformInitIdentity*(matrix: ptr Transform) {.
    importc: "pixman_transform_init_identity", dynlib: "libpixman-1.so".}
proc transformPoint3d*(transform: ptr Transform; vector: ptr Vector): BoolT {.
    importc: "pixman_transform_point_3d", dynlib: "libpixman-1.so".}
proc transformPoint*(transform: ptr Transform; vector: ptr Vector): BoolT {.
    importc: "pixman_transform_point", dynlib: "libpixman-1.so".}
proc transformMultiply*(dst: ptr Transform; l: ptr Transform; r: ptr Transform): BoolT {.
    importc: "pixman_transform_multiply", dynlib: "libpixman-1.so".}
proc transformInitScale*(t: ptr Transform; sx: FixedT; sy: FixedT) {.
    importc: "pixman_transform_init_scale", dynlib: "libpixman-1.so".}
proc transformScale*(forward: ptr Transform; reverse: ptr Transform; sx: FixedT;
                     sy: FixedT): BoolT {.importc: "pixman_transform_scale",
    dynlib: "libpixman-1.so".}
proc transformInitRotate*(t: ptr Transform; cos: FixedT; sin: FixedT) {.
    importc: "pixman_transform_init_rotate", dynlib: "libpixman-1.so".}
proc transformRotate*(forward: ptr Transform; reverse: ptr Transform; c: FixedT;
                      s: FixedT): BoolT {.importc: "pixman_transform_rotate",
    dynlib: "libpixman-1.so".}
proc transformInitTranslate*(t: ptr Transform; tx: FixedT; ty: FixedT) {.
    importc: "pixman_transform_init_translate", dynlib: "libpixman-1.so".}
proc transformTranslate*(forward: ptr Transform; reverse: ptr Transform;
                         tx: FixedT; ty: FixedT): BoolT {.
    importc: "pixman_transform_translate", dynlib: "libpixman-1.so".}
proc transformBounds*(matrix: ptr Transform; b: ptr Box16): BoolT {.
    importc: "pixman_transform_bounds", dynlib: "libpixman-1.so".}
proc transformInvert*(dst: ptr Transform; src: ptr Transform): BoolT {.
    importc: "pixman_transform_invert", dynlib: "libpixman-1.so".}
proc transformIsIdentity*(t: ptr Transform): BoolT {.
    importc: "pixman_transform_is_identity", dynlib: "libpixman-1.so".}
proc transformIsScale*(t: ptr Transform): BoolT {.
    importc: "pixman_transform_is_scale", dynlib: "libpixman-1.so".}
proc transformIsIntTranslate*(t: ptr Transform): BoolT {.
    importc: "pixman_transform_is_int_translate", dynlib: "libpixman-1.so".}
proc transformIsInverse*(a: ptr Transform; b: ptr Transform): BoolT {.
    importc: "pixman_transform_is_inverse", dynlib: "libpixman-1.so".}
proc transformFromPixmanFTransform*(t: ptr Transform; ft: ptr FTransform): BoolT {.
    importc: "pixman_transform_from_pixman_f_transform",
    dynlib: "libpixman-1.so".}
proc fTransformFromPixmanTransform*(ft: ptr FTransform; t: ptr Transform) {.
    importc: "pixman_f_transform_from_pixman_transform",
    dynlib: "libpixman-1.so".}
proc fTransformInvert*(dst: ptr FTransform; src: ptr FTransform): BoolT {.
    importc: "pixman_f_transform_invert", dynlib: "libpixman-1.so".}
proc fTransformPoint*(t: ptr FTransform; v: ptr FVector): BoolT {.
    importc: "pixman_f_transform_point", dynlib: "libpixman-1.so".}
proc fTransformPoint3d*(t: ptr FTransform; v: ptr FVector) {.
    importc: "pixman_f_transform_point_3d", dynlib: "libpixman-1.so".}
proc fTransformMultiply*(dst: ptr FTransform; l: ptr FTransform;
                         r: ptr FTransform) {.
    importc: "pixman_f_transform_multiply", dynlib: "libpixman-1.so".}
proc fTransformInitScale*(t: ptr FTransform; sx: cdouble; sy: cdouble) {.
    importc: "pixman_f_transform_init_scale", dynlib: "libpixman-1.so".}
proc fTransformScale*(forward: ptr FTransform; reverse: ptr FTransform;
                      sx: cdouble; sy: cdouble): BoolT {.
    importc: "pixman_f_transform_scale", dynlib: "libpixman-1.so".}
proc fTransformInitRotate*(t: ptr FTransform; cos: cdouble; sin: cdouble) {.
    importc: "pixman_f_transform_init_rotate", dynlib: "libpixman-1.so".}
proc fTransformRotate*(forward: ptr FTransform; reverse: ptr FTransform;
                       c: cdouble; s: cdouble): BoolT {.
    importc: "pixman_f_transform_rotate", dynlib: "libpixman-1.so".}
proc fTransformInitTranslate*(t: ptr FTransform; tx: cdouble; ty: cdouble) {.
    importc: "pixman_f_transform_init_translate", dynlib: "libpixman-1.so".}
proc fTransformTranslate*(forward: ptr FTransform; reverse: ptr FTransform;
                          tx: cdouble; ty: cdouble): BoolT {.
    importc: "pixman_f_transform_translate", dynlib: "libpixman-1.so".}
proc fTransformBounds*(t: ptr FTransform; b: ptr Box16): BoolT {.
    importc: "pixman_f_transform_bounds", dynlib: "libpixman-1.so".}
proc fTransformInitIdentity*(t: ptr FTransform) {.
    importc: "pixman_f_transform_init_identity", dynlib: "libpixman-1.so".}
proc regionSetStaticPointers*(empty_box: ptr Box16T;
                              empty_data: ptr Region16DataT;
                              broken_data: ptr Region16DataT) {.
    importc: "pixman_region_set_static_pointers", dynlib: "libpixman-1.so".}
proc regionInit*(region: ptr Region16T) {.importc: "pixman_region_init",
    dynlib: "libpixman-1.so".}
proc regionInitRect*(region: ptr Region16T; x: cint; y: cint; width: cuint;
                     height: cuint) {.importc: "pixman_region_init_rect",
                                      dynlib: "libpixman-1.so".}
proc regionInitRects*(region: ptr Region16T; boxes: ptr Box16T; count: cint): BoolT {.
    importc: "pixman_region_init_rects", dynlib: "libpixman-1.so".}
proc regionInitWithExtents*(region: ptr Region16T; extents: ptr Box16T) {.
    importc: "pixman_region_init_with_extents", dynlib: "libpixman-1.so".}
proc regionInitFromImage*(region: ptr Region16T; image: ptr ImageT) {.
    importc: "pixman_region_init_from_image", dynlib: "libpixman-1.so".}
proc regionFini*(region: ptr Region16T) {.importc: "pixman_region_fini",
    dynlib: "libpixman-1.so".}
proc regionTranslate*(region: ptr Region16T; x: cint; y: cint) {.
    importc: "pixman_region_translate", dynlib: "libpixman-1.so".}
proc regionCopy*(dest: ptr Region16T; source: ptr Region16T): BoolT {.
    importc: "pixman_region_copy", dynlib: "libpixman-1.so".}
proc regionIntersect*(new_reg: ptr Region16T; reg1: ptr Region16T;
                      reg2: ptr Region16T): BoolT {.
    importc: "pixman_region_intersect", dynlib: "libpixman-1.so".}
proc regionUnion*(new_reg: ptr Region16T; reg1: ptr Region16T;
                  reg2: ptr Region16T): BoolT {.importc: "pixman_region_union",
    dynlib: "libpixman-1.so".}
proc regionUnionRect*(dest: ptr Region16T; source: ptr Region16T; x: cint;
                      y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region_union_rect", dynlib: "libpixman-1.so".}
proc regionIntersectRect*(dest: ptr Region16T; source: ptr Region16T; x: cint;
                          y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region_intersect_rect", dynlib: "libpixman-1.so".}
proc regionSubtract*(reg_d: ptr Region16T; reg_m: ptr Region16T;
                     reg_s: ptr Region16T): BoolT {.
    importc: "pixman_region_subtract", dynlib: "libpixman-1.so".}
proc regionInverse*(new_reg: ptr Region16T; reg1: ptr Region16T;
                    inv_rect: ptr Box16T): BoolT {.
    importc: "pixman_region_inverse", dynlib: "libpixman-1.so".}
proc regionContainsPoint*(region: ptr Region16T; x: cint; y: cint;
                          box: ptr Box16T): BoolT {.
    importc: "pixman_region_contains_point", dynlib: "libpixman-1.so".}
proc regionContainsRectangle*(region: ptr Region16T; prect: ptr Box16T): RegionOverlapT {.
    importc: "pixman_region_contains_rectangle", dynlib: "libpixman-1.so".}
proc regionEmpty*(region: ptr Region16T): BoolT {.
    importc: "pixman_region_empty", dynlib: "libpixman-1.so".}
proc regionNotEmpty*(region: ptr Region16T): BoolT {.
    importc: "pixman_region_not_empty", dynlib: "libpixman-1.so".}
proc regionExtents*(region: ptr Region16T): ptr Box16T {.
    importc: "pixman_region_extents", dynlib: "libpixman-1.so".}
proc regionNRects*(region: ptr Region16T): cint {.
    importc: "pixman_region_n_rects", dynlib: "libpixman-1.so".}
proc regionRectangles*(region: ptr Region16T; n_rects: ptr cint): ptr Box16T {.
    importc: "pixman_region_rectangles", dynlib: "libpixman-1.so".}
proc regionEqual*(region1: ptr Region16T; region2: ptr Region16T): BoolT {.
    importc: "pixman_region_equal", dynlib: "libpixman-1.so".}
proc regionSelfcheck*(region: ptr Region16T): BoolT {.
    importc: "pixman_region_selfcheck", dynlib: "libpixman-1.so".}
proc regionReset*(region: ptr Region16T; box: ptr Box16T) {.
    importc: "pixman_region_reset", dynlib: "libpixman-1.so".}
proc regionClear*(region: ptr Region16T) {.importc: "pixman_region_clear",
    dynlib: "libpixman-1.so".}
proc region32Init*(region: ptr Region32T) {.importc: "pixman_region32_init",
    dynlib: "libpixman-1.so".}
proc region32InitRect*(region: ptr Region32T; x: cint; y: cint; width: cuint;
                       height: cuint) {.importc: "pixman_region32_init_rect",
                                        dynlib: "libpixman-1.so".}
proc region32InitRects*(region: ptr Region32T; boxes: ptr Box32T; count: cint): BoolT {.
    importc: "pixman_region32_init_rects", dynlib: "libpixman-1.so".}
proc region32InitWithExtents*(region: ptr Region32T; extents: ptr Box32T) {.
    importc: "pixman_region32_init_with_extents", dynlib: "libpixman-1.so".}
proc region32InitFromImage*(region: ptr Region32T; image: ptr ImageT) {.
    importc: "pixman_region32_init_from_image", dynlib: "libpixman-1.so".}
proc region32Fini*(region: ptr Region32T) {.importc: "pixman_region32_fini",
    dynlib: "libpixman-1.so".}
proc region32Translate*(region: ptr Region32T; x: cint; y: cint) {.
    importc: "pixman_region32_translate", dynlib: "libpixman-1.so".}
proc region32Copy*(dest: ptr Region32T; source: ptr Region32T): BoolT {.
    importc: "pixman_region32_copy", dynlib: "libpixman-1.so".}
proc region32Intersect*(new_reg: ptr Region32T; reg1: ptr Region32T;
                        reg2: ptr Region32T): BoolT {.
    importc: "pixman_region32_intersect", dynlib: "libpixman-1.so".}
proc region32Union*(new_reg: ptr Region32T; reg1: ptr Region32T;
                    reg2: ptr Region32T): BoolT {.
    importc: "pixman_region32_union", dynlib: "libpixman-1.so".}
proc region32IntersectRect*(dest: ptr Region32T; source: ptr Region32T; x: cint;
                            y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region32_intersect_rect", dynlib: "libpixman-1.so".}
proc region32UnionRect*(dest: ptr Region32T; source: ptr Region32T; x: cint;
                        y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region32_union_rect", dynlib: "libpixman-1.so".}
proc region32Subtract*(reg_d: ptr Region32T; reg_m: ptr Region32T;
                       reg_s: ptr Region32T): BoolT {.
    importc: "pixman_region32_subtract", dynlib: "libpixman-1.so".}
proc region32Inverse*(new_reg: ptr Region32T; reg1: ptr Region32T;
                      inv_rect: ptr Box32T): BoolT {.
    importc: "pixman_region32_inverse", dynlib: "libpixman-1.so".}
proc region32ContainsPoint*(region: ptr Region32T; x: cint; y: cint;
                            box: ptr Box32T): BoolT {.
    importc: "pixman_region32_contains_point", dynlib: "libpixman-1.so".}
proc region32ContainsRectangle*(region: ptr Region32T; prect: ptr Box32T): RegionOverlapT {.
    importc: "pixman_region32_contains_rectangle", dynlib: "libpixman-1.so".}
proc region32Empty*(region: ptr Region32T): BoolT {.
    importc: "pixman_region32_empty", dynlib: "libpixman-1.so".}
proc region32NotEmpty*(region: ptr Region32T): BoolT {.
    importc: "pixman_region32_not_empty", dynlib: "libpixman-1.so".}
proc region32Extents*(region: ptr Region32T): ptr Box32T {.
    importc: "pixman_region32_extents", dynlib: "libpixman-1.so".}
proc region32NRects*(region: ptr Region32T): cint {.
    importc: "pixman_region32_n_rects", dynlib: "libpixman-1.so".}
proc region32Rectangles*(region: ptr Region32T; n_rects: ptr cint): ptr Box32T {.
    importc: "pixman_region32_rectangles", dynlib: "libpixman-1.so".}
proc region32Equal*(region1: ptr Region32T; region2: ptr Region32T): BoolT {.
    importc: "pixman_region32_equal", dynlib: "libpixman-1.so".}
proc region32Selfcheck*(region: ptr Region32T): BoolT {.
    importc: "pixman_region32_selfcheck", dynlib: "libpixman-1.so".}
proc region32Reset*(region: ptr Region32T; box: ptr Box32T) {.
    importc: "pixman_region32_reset", dynlib: "libpixman-1.so".}
proc region32Clear*(region: ptr Region32T) {.importc: "pixman_region32_clear",
    dynlib: "libpixman-1.so".}
proc region64fInit*(region: ptr Region64fT) {.importc: "pixman_region64f_init",
    dynlib: "libpixman-1.so".}
proc region64fInitRect*(region: ptr Region64fT; x: cint; y: cint; width: cuint;
                        height: cuint) {.importc: "pixman_region64f_init_rect",
    dynlib: "libpixman-1.so".}
proc region64fInitRectf*(region: ptr Region64fT; x: cdouble; y: cdouble;
                         width: cdouble; height: cdouble) {.
    importc: "pixman_region64f_init_rectf", dynlib: "libpixman-1.so".}
proc region64fInitRects*(region: ptr Region64fT; boxes: ptr Box64fT; count: cint): BoolT {.
    importc: "pixman_region64f_init_rects", dynlib: "libpixman-1.so".}
proc region64fInitWithExtents*(region: ptr Region64fT; extents: ptr Box64fT) {.
    importc: "pixman_region64f_init_with_extents", dynlib: "libpixman-1.so".}
proc region64fInitFromImage*(region: ptr Region64fT; image: ptr ImageT) {.
    importc: "pixman_region64f_init_from_image", dynlib: "libpixman-1.so".}
proc region64fFini*(region: ptr Region64fT) {.importc: "pixman_region64f_fini",
    dynlib: "libpixman-1.so".}
proc region64fTranslate*(region: ptr Region64fT; x: cint; y: cint) {.
    importc: "pixman_region64f_translate", dynlib: "libpixman-1.so".}
proc region64fCopy*(dest: ptr Region64fT; source: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_copy", dynlib: "libpixman-1.so".}
proc region64fIntersect*(new_reg: ptr Region64fT; reg1: ptr Region64fT;
                         reg2: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_intersect", dynlib: "libpixman-1.so".}
proc region64fUnion*(new_reg: ptr Region64fT; reg1: ptr Region64fT;
                     reg2: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_union", dynlib: "libpixman-1.so".}
proc region64fIntersectRect*(dest: ptr Region64fT; source: ptr Region64fT;
                             x: cint; y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region64f_intersect_rect", dynlib: "libpixman-1.so".}
proc region64fIntersectRectf*(dest: ptr Region64fT; source: ptr Region64fT;
                              x: cdouble; y: cdouble; width: cdouble;
                              height: cdouble): BoolT {.
    importc: "pixman_region64f_intersect_rectf", dynlib: "libpixman-1.so".}
proc region64fUnionRect*(dest: ptr Region64fT; source: ptr Region64fT; x: cint;
                         y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region64f_union_rect", dynlib: "libpixman-1.so".}
proc region64fUnionRectf*(dest: ptr Region64fT; source: ptr Region64fT;
                          x: cdouble; y: cdouble; width: cdouble;
                          height: cdouble): BoolT {.
    importc: "pixman_region64f_union_rectf", dynlib: "libpixman-1.so".}
proc region64fSubtract*(reg_d: ptr Region64fT; reg_m: ptr Region64fT;
                        reg_s: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_subtract", dynlib: "libpixman-1.so".}
proc region64fInverse*(new_reg: ptr Region64fT; reg1: ptr Region64fT;
                       inv_rect: ptr Box64fT): BoolT {.
    importc: "pixman_region64f_inverse", dynlib: "libpixman-1.so".}
proc region64fContainsPoint*(region: ptr Region64fT; x: cint; y: cint;
                             box: ptr Box64fT): BoolT {.
    importc: "pixman_region64f_contains_point", dynlib: "libpixman-1.so".}
proc region64fContainsRectangle*(region: ptr Region64fT; prect: ptr Box64fT): RegionOverlapT {.
    importc: "pixman_region64f_contains_rectangle", dynlib: "libpixman-1.so".}
proc region64fEmpty*(region: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_empty", dynlib: "libpixman-1.so".}
proc region64fNotEmpty*(region: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_not_empty", dynlib: "libpixman-1.so".}
proc region64fExtents*(region: ptr Region64fT): ptr Box64fT {.
    importc: "pixman_region64f_extents", dynlib: "libpixman-1.so".}
proc region64fNRects*(region: ptr Region64fT): cint {.
    importc: "pixman_region64f_n_rects", dynlib: "libpixman-1.so".}
proc region64fRectangles*(region: ptr Region64fT; n_rects: ptr cint): ptr Box64fT {.
    importc: "pixman_region64f_rectangles", dynlib: "libpixman-1.so".}
proc region64fEqual*(region1: ptr Region64fT; region2: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_equal", dynlib: "libpixman-1.so".}
proc region64fSelfcheck*(region: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_selfcheck", dynlib: "libpixman-1.so".}
proc region64fReset*(region: ptr Region64fT; box: ptr Box64fT) {.
    importc: "pixman_region64f_reset", dynlib: "libpixman-1.so".}
proc region64fClear*(region: ptr Region64fT) {.
    importc: "pixman_region64f_clear", dynlib: "libpixman-1.so".}
proc blt*(src_bits: ptr uint32; dst_bits: ptr uint32; src_stride: cint;
          dst_stride: cint; src_bpp: cint; dst_bpp: cint; src_x: cint;
          src_y: cint; dest_x: cint; dest_y: cint; width: cint; height: cint): BoolT {.
    importc: "pixman_blt", dynlib: "libpixman-1.so".}
proc fill*(bits: ptr uint32; stride: cint; bpp: cint; x: cint; y: cint;
           width: cint; height: cint; `xor`: uint32): BoolT {.
    importc: "pixman_fill", dynlib: "libpixman-1.so".}
proc version*(): cint {.importc: "pixman_version", dynlib: "libpixman-1.so".}
proc versionString*(): cstring {.importc: "pixman_version_string",
                                 dynlib: "libpixman-1.so".}
proc formatSupportedDestination*(format: FormatCodeT): BoolT {.
    importc: "pixman_format_supported_destination", dynlib: "libpixman-1.so".}
proc formatSupportedSource*(format: FormatCodeT): BoolT {.
    importc: "pixman_format_supported_source", dynlib: "libpixman-1.so".}
proc imageCreateSolidFill*(color: ptr ColorT): ptr ImageT {.
    importc: "pixman_image_create_solid_fill", dynlib: "libpixman-1.so".}
proc imageCreateLinearGradient*(p1: ptr PointFixedT; p2: ptr PointFixedT;
                                stops: ptr GradientStopT; n_stops: cint): ptr ImageT {.
    importc: "pixman_image_create_linear_gradient", dynlib: "libpixman-1.so".}
proc imageCreateRadialGradient*(inner: ptr PointFixedT; outer: ptr PointFixedT;
                                inner_radius: FixedT; outer_radius: FixedT;
                                stops: ptr GradientStopT; n_stops: cint): ptr ImageT {.
    importc: "pixman_image_create_radial_gradient", dynlib: "libpixman-1.so".}
proc imageCreateConicalGradient*(center: ptr PointFixedT; angle: FixedT;
                                 stops: ptr GradientStopT; n_stops: cint): ptr ImageT {.
    importc: "pixman_image_create_conical_gradient", dynlib: "libpixman-1.so".}
proc imageCreateBits*(format: FormatCodeT; width: cint; height: cint;
                      bits: ptr uint32; rowstride_bytes: cint): ptr ImageT {.
    importc: "pixman_image_create_bits", dynlib: "libpixman-1.so".}
proc imageCreateBitsNoClear*(format: FormatCodeT; width: cint; height: cint;
                             bits: ptr uint32; rowstride_bytes: cint): ptr ImageT {.
    importc: "pixman_image_create_bits_no_clear", dynlib: "libpixman-1.so".}
proc imageRef*(image: ptr ImageT): ptr ImageT {.importc: "pixman_image_ref",
    dynlib: "libpixman-1.so".}
proc imageUnref*(image: ptr ImageT): BoolT {.importc: "pixman_image_unref",
    dynlib: "libpixman-1.so".}
proc imageSetDestroyFunction*(image: ptr ImageT; function: ImageDestroyFuncT;
                              data: pointer) {.
    importc: "pixman_image_set_destroy_function", dynlib: "libpixman-1.so".}
proc imageGetDestroyData*(image: ptr ImageT): pointer {.
    importc: "pixman_image_get_destroy_data", dynlib: "libpixman-1.so".}
proc imageSetClipRegion*(image: ptr ImageT; region: ptr Region16T): BoolT {.
    importc: "pixman_image_set_clip_region", dynlib: "libpixman-1.so".}
proc imageSetClipRegion32*(image: ptr ImageT; region: ptr Region32T): BoolT {.
    importc: "pixman_image_set_clip_region32", dynlib: "libpixman-1.so".}
proc imageSetClipRegion64f*(image: ptr ImageT; region: ptr Region64fT): BoolT {.
    importc: "pixman_image_set_clip_region64f", dynlib: "libpixman-1.so".}
proc imageSetHasClientClip*(image: ptr ImageT; clien_clip: BoolT) {.
    importc: "pixman_image_set_has_client_clip", dynlib: "libpixman-1.so".}
proc imageSetTransform*(image: ptr ImageT; transform: ptr TransformT): BoolT {.
    importc: "pixman_image_set_transform", dynlib: "libpixman-1.so".}
proc imageSetRepeat*(image: ptr ImageT; repeat: RepeatT) {.
    importc: "pixman_image_set_repeat", dynlib: "libpixman-1.so".}
proc imageSetDither*(image: ptr ImageT; dither: DitherT) {.
    importc: "pixman_image_set_dither", dynlib: "libpixman-1.so".}
proc imageSetDitherOffset*(image: ptr ImageT; offset_x: cint; offset_y: cint) {.
    importc: "pixman_image_set_dither_offset", dynlib: "libpixman-1.so".}
proc imageSetFilter*(image: ptr ImageT; filter: FilterT;
                     filter_params: ptr FixedT; n_filter_params: cint): BoolT {.
    importc: "pixman_image_set_filter", dynlib: "libpixman-1.so".}
proc imageSetSourceClipping*(image: ptr ImageT; source_clipping: BoolT) {.
    importc: "pixman_image_set_source_clipping", dynlib: "libpixman-1.so".}
proc imageSetAlphaMap*(image: ptr ImageT; alpha_map: ptr ImageT; x: int16;
                       y: int16) {.importc: "pixman_image_set_alpha_map",
                                   dynlib: "libpixman-1.so".}
proc imageSetComponentAlpha*(image: ptr ImageT; component_alpha: BoolT) {.
    importc: "pixman_image_set_component_alpha", dynlib: "libpixman-1.so".}
proc imageGetComponentAlpha*(image: ptr ImageT): BoolT {.
    importc: "pixman_image_get_component_alpha", dynlib: "libpixman-1.so".}
proc imageSetAccessors*(image: ptr ImageT; read_func: ReadMemoryFuncT;
                        write_func: WriteMemoryFuncT) {.
    importc: "pixman_image_set_accessors", dynlib: "libpixman-1.so".}
proc imageSetIndexed*(image: ptr ImageT; indexed: ptr IndexedT) {.
    importc: "pixman_image_set_indexed", dynlib: "libpixman-1.so".}
proc imageGetData*(image: ptr ImageT): ptr uint32 {.
    importc: "pixman_image_get_data", dynlib: "libpixman-1.so".}
proc imageGetWidth*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_width", dynlib: "libpixman-1.so".}
proc imageGetHeight*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_height", dynlib: "libpixman-1.so".}
proc imageGetStride*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_stride", dynlib: "libpixman-1.so".}
proc imageGetDepth*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_depth", dynlib: "libpixman-1.so".}
proc imageGetFormat*(image: ptr ImageT): FormatCodeT {.
    importc: "pixman_image_get_format", dynlib: "libpixman-1.so".}
proc filterCreateSeparableConvolution*(n_values: ptr cint; scale_x: FixedT;
                                       scale_y: FixedT; reconstruct_x: KernelT;
                                       reconstruct_y: KernelT;
                                       sample_x: KernelT; sample_y: KernelT;
                                       subsample_bits_x: cint;
                                       subsample_bits_y: cint): ptr FixedT {.
    importc: "pixman_filter_create_separable_convolution",
    dynlib: "libpixman-1.so".}
proc imageFillRectangles*(op: OpT; image: ptr ImageT; color: ptr ColorT;
                          n_rects: cint; rects: ptr Rectangle16T): BoolT {.
    importc: "pixman_image_fill_rectangles", dynlib: "libpixman-1.so".}
proc imageFillBoxes*(op: OpT; dest: ptr ImageT; color: ptr ColorT;
                     n_boxes: cint; boxes: ptr Box32T): BoolT {.
    importc: "pixman_image_fill_boxes", dynlib: "libpixman-1.so".}
proc computeCompositeRegion*(region: ptr Region16T; src_image: ptr ImageT;
                             mask_image: ptr ImageT; dest_image: ptr ImageT;
                             src_x: int16; src_y: int16; mask_x: int16;
                             mask_y: int16; dest_x: int16; dest_y: int16;
                             width: uint16; height: uint16): BoolT {.
    importc: "pixman_compute_composite_region", dynlib: "libpixman-1.so".}
proc imageComposite*(op: OpT; src: ptr ImageT; mask: ptr ImageT;
                     dest: ptr ImageT; src_x: int16; src_y: int16;
                     mask_x: int16; mask_y: int16; dest_x: int16; dest_y: int16;
                     width: uint16; height: uint16) {.
    importc: "pixman_image_composite", dynlib: "libpixman-1.so".}
proc imageComposite32*(op: OpT; src: ptr ImageT; mask: ptr ImageT;
                       dest: ptr ImageT; src_x: int32; src_y: int32;
                       mask_x: int32; mask_y: int32; dest_x: int32;
                       dest_y: int32; width: int32; height: int32) {.
    importc: "pixman_image_composite32", dynlib: "libpixman-1.so".}
proc imageComposite64f*(op: OpT; src: ptr ImageT; mask: ptr ImageT;
                        dest: ptr ImageT; src_x: cdouble; src_y: cdouble;
                        mask_x: cdouble; mask_y: cdouble; dest_x: cdouble;
                        dest_y: cdouble; width: cdouble; height: cdouble) {.
    importc: "pixman_image_composite64f", dynlib: "libpixman-1.so".}
proc disableOutOfBoundsWorkaround*() {.importc: "pixman_disable_out_of_bounds_workaround",
                                       dynlib: "libpixman-1.so".}
proc glyphCacheCreate*(): ptr GlyphCacheT {.
    importc: "pixman_glyph_cache_create", dynlib: "libpixman-1.so".}
proc glyphCacheDestroy*(cache: ptr GlyphCacheT) {.
    importc: "pixman_glyph_cache_destroy", dynlib: "libpixman-1.so".}
proc glyphCacheFreeze*(cache: ptr GlyphCacheT) {.
    importc: "pixman_glyph_cache_freeze", dynlib: "libpixman-1.so".}
proc glyphCacheThaw*(cache: ptr GlyphCacheT) {.
    importc: "pixman_glyph_cache_thaw", dynlib: "libpixman-1.so".}
proc glyphCacheLookup*(cache: ptr GlyphCacheT; font_key: pointer;
                       glyph_key: pointer): pointer {.
    importc: "pixman_glyph_cache_lookup", dynlib: "libpixman-1.so".}
proc glyphCacheInsert*(cache: ptr GlyphCacheT; font_key: pointer;
                       glyph_key: pointer; origin_x: cint; origin_y: cint;
                       glyph_image: ptr ImageT): pointer {.
    importc: "pixman_glyph_cache_insert", dynlib: "libpixman-1.so".}
proc glyphCacheRemove*(cache: ptr GlyphCacheT; font_key: pointer;
                       glyph_key: pointer) {.
    importc: "pixman_glyph_cache_remove", dynlib: "libpixman-1.so".}
proc glyphGetExtents*(cache: ptr GlyphCacheT; n_glyphs: cint;
                      glyphs: ptr GlyphT; extents: ptr Box32T) {.
    importc: "pixman_glyph_get_extents", dynlib: "libpixman-1.so".}
proc glyphGetMaskFormat*(cache: ptr GlyphCacheT; n_glyphs: cint;
                         glyphs: ptr GlyphT): FormatCodeT {.
    importc: "pixman_glyph_get_mask_format", dynlib: "libpixman-1.so".}
proc compositeGlyphs*(op: OpT; src: ptr ImageT; dest: ptr ImageT;
                      mask_format: FormatCodeT; src_x: int32; src_y: int32;
                      mask_x: int32; mask_y: int32; dest_x: int32;
                      dest_y: int32; width: int32; height: int32;
                      cache: ptr GlyphCacheT; n_glyphs: cint; glyphs: ptr GlyphT) {.
    importc: "pixman_composite_glyphs", dynlib: "libpixman-1.so".}
proc compositeGlyphsNoMask*(op: OpT; src: ptr ImageT; dest: ptr ImageT;
                            src_x: int32; src_y: int32; dest_x: int32;
                            dest_y: int32; cache: ptr GlyphCacheT;
                            n_glyphs: cint; glyphs: ptr GlyphT) {.
    importc: "pixman_composite_glyphs_no_mask", dynlib: "libpixman-1.so".}
proc sampleCeilY*(y: FixedT; bpp: cint): FixedT {.
    importc: "pixman_sample_ceil_y", dynlib: "libpixman-1.so".}
proc sampleFloorY*(y: FixedT; bpp: cint): FixedT {.
    importc: "pixman_sample_floor_y", dynlib: "libpixman-1.so".}
proc edgeStep*(e: ptr EdgeT; n: cint) {.importc: "pixman_edge_step",
                                        dynlib: "libpixman-1.so".}
proc edgeInit*(e: ptr EdgeT; bpp: cint; y_start: FixedT; x_top: FixedT;
               y_top: FixedT; x_bot: FixedT; y_bot: FixedT) {.
    importc: "pixman_edge_init", dynlib: "libpixman-1.so".}
proc lineFixedEdgeInit*(e: ptr EdgeT; bpp: cint; y: FixedT;
                        line: ptr LineFixedT; x_off: cint; y_off: cint) {.
    importc: "pixman_line_fixed_edge_init", dynlib: "libpixman-1.so".}
proc rasterizeEdges*(image: ptr ImageT; l: ptr EdgeT; r: ptr EdgeT; t: FixedT;
                     b: FixedT) {.importc: "pixman_rasterize_edges",
                                  dynlib: "libpixman-1.so".}
proc addTraps*(image: ptr ImageT; x_off: int16; y_off: int16; ntrap: cint;
               traps: ptr TrapT) {.importc: "pixman_add_traps",
                                   dynlib: "libpixman-1.so".}
proc addTrapezoids*(image: ptr ImageT; x_off: int16; y_off: cint; ntraps: cint;
                    traps: ptr TrapezoidT) {.importc: "pixman_add_trapezoids",
    dynlib: "libpixman-1.so".}
proc rasterizeTrapezoid*(image: ptr ImageT; trap: ptr TrapezoidT; x_off: cint;
                         y_off: cint) {.importc: "pixman_rasterize_trapezoid",
                                        dynlib: "libpixman-1.so".}
proc compositeTrapezoids*(op: OpT; src: ptr ImageT; dst: ptr ImageT;
                          mask_format: FormatCodeT; x_src: cint; y_src: cint;
                          x_dst: cint; y_dst: cint; n_traps: cint;
                          traps: ptr TrapezoidT) {.
    importc: "pixman_composite_trapezoids", dynlib: "libpixman-1.so".}
proc compositeTriangles*(op: OpT; src: ptr ImageT; dst: ptr ImageT;
                         mask_format: FormatCodeT; x_src: cint; y_src: cint;
                         x_dst: cint; y_dst: cint; n_tris: cint;
                         tris: ptr TriangleT) {.
    importc: "pixman_composite_triangles", dynlib: "libpixman-1.so".}
proc addTriangles*(image: ptr ImageT; x_off: int32; y_off: int32; n_tris: cint;
                   tris: ptr TriangleT) {.importc: "pixman_add_triangles",
    dynlib: "libpixman-1.so".}