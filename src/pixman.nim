
include
  includes / templates

const
  MAX_INDEXED* = 256
  TYPE_OTHER* = 0
  TYPE_A* = 1
  TYPE_ARGB* = 2
  TYPE_ABGR* = 3
  TYPE_COLOR* = 4
  TYPE_GRAY* = 5
  TYPE_YUY2* = 6
  TYPE_YV12* = 7
  TYPE_BGRA* = 8
  TYPE_RGBA* = 9
  TYPE_ARGB_SRGB* = 10
  TYPE_RGBA_FLOAT* = 11
when Max_Indexed <= 256:
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
    REPEAT_NONE, REPEAT_NORMAL, REPEAT_PAD, REPEAT_REFLECT
  DitherT* {.size: sizeof(cint).} = enum
    DITHER_NONE, DITHER_FAST, DITHER_GOOD, DITHER_BEST, DITHER_ORDERED_BAYER_8,
    DITHER_ORDERED_BLUE_NOISE_64
  FilterT* {.size: sizeof(cint).} = enum
    FILTER_FAST, FILTER_GOOD, FILTER_BEST, FILTER_NEAREST, FILTER_BILINEAR,
    FILTER_CONVOLUTION, FILTER_SEPARABLE_CONVOLUTION
  OpT* {.size: sizeof(cint).} = enum
    OP_CLEAR = 0x00000000, OP_SRC = 0x00000001, OP_DST = 0x00000002,
    OP_OVER = 0x00000003, OP_OVER_REVERSE = 0x00000004, OP_IN = 0x00000005,
    OP_IN_REVERSE = 0x00000006, OP_OUT = 0x00000007,
    OP_OUT_REVERSE = 0x00000008, OP_ATOP = 0x00000009,
    OP_ATOP_REVERSE = 0x0000000A, OP_XOR = 0x0000000B, OP_ADD = 0x0000000C,
    OP_SATURATE = 0x0000000D, OP_DISJOINT_CLEAR = 0x00000010,
    OP_DISJOINT_SRC = 0x00000011, OP_DISJOINT_DST = 0x00000012,
    OP_DISJOINT_OVER = 0x00000013, OP_DISJOINT_OVER_REVERSE = 0x00000014,
    OP_DISJOINT_IN = 0x00000015, OP_DISJOINT_IN_REVERSE = 0x00000016,
    OP_DISJOINT_OUT = 0x00000017, OP_DISJOINT_OUT_REVERSE = 0x00000018,
    OP_DISJOINT_ATOP = 0x00000019, OP_DISJOINT_ATOP_REVERSE = 0x0000001A,
    OP_DISJOINT_XOR = 0x0000001B, OP_CONJOINT_CLEAR = 0x00000020,
    OP_CONJOINT_SRC = 0x00000021, OP_CONJOINT_DST = 0x00000022,
    OP_CONJOINT_OVER = 0x00000023, OP_CONJOINT_OVER_REVERSE = 0x00000024,
    OP_CONJOINT_IN = 0x00000025, OP_CONJOINT_IN_REVERSE = 0x00000026,
    OP_CONJOINT_OUT = 0x00000027, OP_CONJOINT_OUT_REVERSE = 0x00000028,
    OP_CONJOINT_ATOP = 0x00000029, OP_CONJOINT_ATOP_REVERSE = 0x0000002A,
    OP_CONJOINT_XOR = 0x0000002B, OP_MULTIPLY = 0x00000030,
    OP_SCREEN = 0x00000031, OP_OVERLAY = 0x00000032, OP_DARKEN = 0x00000033,
    OP_LIGHTEN = 0x00000034, OP_COLOR_DODGE = 0x00000035,
    OP_COLOR_BURN = 0x00000036, OP_HARD_LIGHT = 0x00000037,
    OP_SOFT_LIGHT = 0x00000038, OP_DIFFERENCE = 0x00000039,
    OP_EXCLUSION = 0x0000003A, OP_HSL_HUE = 0x0000003B,
    OP_HSL_SATURATION = 0x0000003C, OP_HSL_COLOR = 0x0000003D,
    OP_HSL_LUMINOSITY = 0x0000003E
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
    REGION_OUT, REGION_IN, REGION_PART
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
    rgba*: array[Max_Indexed, uint32]
    ent*: array[32768, IndexType]
  FormatCodeT* {.size: sizeof(cint).} = enum
    rgbaFloat = Format_Byte(128, Type_Rgba_Float, 32, 32, 32, 32),
    rgbFloat = Format_Byte(96, Type_Rgba_Float, 0, 32, 32, 32),
    a16b16g16r16 = Format_Byte(64, Type_Abgr, 16, 16, 16, 16),
    a8r8g8b8 = Format(32, Type_Argb, 8, 8, 8, 8),
    x8r8g8b8 = Format(32, Type_Argb, 0, 8, 8, 8),
    a8b8g8r8 = Format(32, Type_Abgr, 8, 8, 8, 8),
    x8b8g8r8 = Format(32, Type_Abgr, 0, 8, 8, 8),
    b8g8r8a8 = Format(32, Type_Bgra, 8, 8, 8, 8),
    b8g8r8x8 = Format(32, Type_Bgra, 0, 8, 8, 8),
    r8g8b8a8 = Format(32, Type_Rgba, 8, 8, 8, 8),
    r8g8b8x8 = Format(32, Type_Rgba, 0, 8, 8, 8),
    x14r6g6b6 = Format(32, Type_Argb, 0, 6, 6, 6),
    x2r10g10b10 = Format(32, Type_Argb, 0, 10, 10, 10),
    a2r10g10b10 = Format(32, Type_Argb, 2, 10, 10, 10),
    x2b10g10r10 = Format(32, Type_Abgr, 0, 10, 10, 10),
    a2b10g10r10 = Format(32, Type_Abgr, 2, 10, 10, 10),
    a8r8g8b8SRGB = Format(32, Type_Argb_Srgb, 8, 8, 8, 8),
    r8g8b8SRGB = Format(24, Type_Argb_Srgb, 0, 8, 8, 8),
    r8g8b8 = Format(24, Type_Argb, 0, 8, 8, 8),
    b8g8r8 = Format(24, Type_Abgr, 0, 8, 8, 8),
    r5g6b5 = Format(16, Type_Argb, 0, 5, 6, 5),
    b5g6r5 = Format(16, Type_Abgr, 0, 5, 6, 5),
    a1r5g5b5 = Format(16, Type_Argb, 1, 5, 5, 5),
    x1r5g5b5 = Format(16, Type_Argb, 0, 5, 5, 5),
    a1b5g5r5 = Format(16, Type_Abgr, 1, 5, 5, 5),
    x1b5g5r5 = Format(16, Type_Abgr, 0, 5, 5, 5),
    a4r4g4b4 = Format(16, Type_Argb, 4, 4, 4, 4),
    x4r4g4b4 = Format(16, Type_Argb, 0, 4, 4, 4),
    a4b4g4r4 = Format(16, Type_Abgr, 4, 4, 4, 4),
    x4b4g4r4 = Format(16, Type_Abgr, 0, 4, 4, 4),
    a8 = Format(8, Type_A, 8, 0, 0, 0),
    r3g3b2 = Format(8, Type_Argb, 0, 3, 3, 2),
    b2g3r3 = Format(8, Type_Abgr, 0, 3, 3, 2),
    a2r2g2b2 = Format(8, Type_Argb, 2, 2, 2, 2),
    a2b2g2r2 = Format(8, Type_Abgr, 2, 2, 2, 2),
    c8 = Format(8, Type_Color, 0, 0, 0, 0),
    g8 = Format(8, Type_Gray, 0, 0, 0, 0), x4a4 = Format(8, Type_A, 4, 0, 0, 0),
    a4 = Format(4, Type_A, 4, 0, 0, 0),
    r1g2b1 = Format(4, Type_Argb, 0, 1, 2, 1),
    b1g2r1 = Format(4, Type_Abgr, 0, 1, 2, 1),
    a1r1g1b1 = Format(4, Type_Argb, 1, 1, 1, 1),
    a1b1g1r1 = Format(4, Type_Abgr, 1, 1, 1, 1),
    c4 = Format(4, Type_Color, 0, 0, 0, 0),
    g4 = Format(4, Type_Gray, 0, 0, 0, 0), a1 = Format(1, Type_A, 1, 0, 0, 0),
    g1 = Format(1, Type_Gray, 0, 0, 0, 0),
    yuy2 = Format(16, Type_Yuy2, 0, 0, 0, 0),
    yv12 = Format(12, Type_Yv12, 0, 0, 0, 0)
  KernelT* {.size: sizeof(cint).} = enum
    KERNEL_IMPULSE, KERNEL_BOX, KERNEL_LINEAR, KERNEL_CUBIC, KERNEL_GAUSSIAN,
    KERNEL_LANCZOS2, KERNEL_LANCZOS3, KERNEL_LANCZOS3_STRETCHED
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
    stepxSmall*: FixedT
    stepxBig*: FixedT
    dxSmall*: FixedT
    dxBig*: FixedT
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
  FixedE* = (cast[FixedT](1))
  Fixed1* = (IntToFixed(1))
  Fixed1MinusE* = (Fixed1 - FixedE)
  FixedMinus1* = (IntToFixed(-1))
  MaxFixed4816* = (cast[Fixed4816T](0x7FFFFFFF))
  MinFixed4816* = (-(cast[Fixed4816T](1) shl 31))
discard "forward decl of pixman_box16"
proc TransformInitIdentity*(matrix: ptr Transform) {.
    importc: "pixman_transform_init_identity", dynlib: "libpixman-1.so".}
proc TransformPoint3d*(transform: ptr Transform; vector: ptr Vector): BoolT {.
    importc: "pixman_transform_point_3d", dynlib: "libpixman-1.so".}
proc TransformPoint*(transform: ptr Transform; vector: ptr Vector): BoolT {.
    importc: "pixman_transform_point", dynlib: "libpixman-1.so".}
proc TransformMultiply*(dst: ptr Transform; l: ptr Transform; r: ptr Transform): BoolT {.
    importc: "pixman_transform_multiply", dynlib: "libpixman-1.so".}
proc TransformInitScale*(t: ptr Transform; sx: FixedT; sy: FixedT) {.
    importc: "pixman_transform_init_scale", dynlib: "libpixman-1.so".}
proc TransformScale*(forward: ptr Transform; reverse: ptr Transform; sx: FixedT;
                     sy: FixedT): BoolT {.importc: "pixman_transform_scale",
    dynlib: "libpixman-1.so".}
proc TransformInitRotate*(t: ptr Transform; cos: FixedT; sin: FixedT) {.
    importc: "pixman_transform_init_rotate", dynlib: "libpixman-1.so".}
proc TransformRotate*(forward: ptr Transform; reverse: ptr Transform; c: FixedT;
                      s: FixedT): BoolT {.importc: "pixman_transform_rotate",
    dynlib: "libpixman-1.so".}
proc TransformInitTranslate*(t: ptr Transform; tx: FixedT; ty: FixedT) {.
    importc: "pixman_transform_init_translate", dynlib: "libpixman-1.so".}
proc TransformTranslate*(forward: ptr Transform; reverse: ptr Transform;
                         tx: FixedT; ty: FixedT): BoolT {.
    importc: "pixman_transform_translate", dynlib: "libpixman-1.so".}
proc TransformBounds*(matrix: ptr Transform; b: ptr Box16): BoolT {.
    importc: "pixman_transform_bounds", dynlib: "libpixman-1.so".}
proc TransformInvert*(dst: ptr Transform; src: ptr Transform): BoolT {.
    importc: "pixman_transform_invert", dynlib: "libpixman-1.so".}
proc TransformIsIdentity*(t: ptr Transform): BoolT {.
    importc: "pixman_transform_is_identity", dynlib: "libpixman-1.so".}
proc TransformIsScale*(t: ptr Transform): BoolT {.
    importc: "pixman_transform_is_scale", dynlib: "libpixman-1.so".}
proc TransformIsIntTranslate*(t: ptr Transform): BoolT {.
    importc: "pixman_transform_is_int_translate", dynlib: "libpixman-1.so".}
proc TransformIsInverse*(a: ptr Transform; b: ptr Transform): BoolT {.
    importc: "pixman_transform_is_inverse", dynlib: "libpixman-1.so".}
proc TransformFromFTransform*(t: ptr Transform; ft: ptr FTransform): BoolT {.
    importc: "pixman_transform_from_pixman_f_transform",
    dynlib: "libpixman-1.so".}
proc FTransformFromTransform*(ft: ptr FTransform; t: ptr Transform) {.
    importc: "pixman_f_transform_from_pixman_transform",
    dynlib: "libpixman-1.so".}
proc FTransformInvert*(dst: ptr FTransform; src: ptr FTransform): BoolT {.
    importc: "pixman_f_transform_invert", dynlib: "libpixman-1.so".}
proc FTransformPoint*(t: ptr FTransform; v: ptr FVector): BoolT {.
    importc: "pixman_f_transform_point", dynlib: "libpixman-1.so".}
proc FTransformPoint3d*(t: ptr FTransform; v: ptr FVector) {.
    importc: "pixman_f_transform_point_3d", dynlib: "libpixman-1.so".}
proc FTransformMultiply*(dst: ptr FTransform; l: ptr FTransform;
                         r: ptr FTransform) {.
    importc: "pixman_f_transform_multiply", dynlib: "libpixman-1.so".}
proc FTransformInitScale*(t: ptr FTransform; sx: cdouble; sy: cdouble) {.
    importc: "pixman_f_transform_init_scale", dynlib: "libpixman-1.so".}
proc FTransformScale*(forward: ptr FTransform; reverse: ptr FTransform;
                      sx: cdouble; sy: cdouble): BoolT {.
    importc: "pixman_f_transform_scale", dynlib: "libpixman-1.so".}
proc FTransformInitRotate*(t: ptr FTransform; cos: cdouble; sin: cdouble) {.
    importc: "pixman_f_transform_init_rotate", dynlib: "libpixman-1.so".}
proc FTransformRotate*(forward: ptr FTransform; reverse: ptr FTransform;
                       c: cdouble; s: cdouble): BoolT {.
    importc: "pixman_f_transform_rotate", dynlib: "libpixman-1.so".}
proc FTransformInitTranslate*(t: ptr FTransform; tx: cdouble; ty: cdouble) {.
    importc: "pixman_f_transform_init_translate", dynlib: "libpixman-1.so".}
proc FTransformTranslate*(forward: ptr FTransform; reverse: ptr FTransform;
                          tx: cdouble; ty: cdouble): BoolT {.
    importc: "pixman_f_transform_translate", dynlib: "libpixman-1.so".}
proc FTransformBounds*(t: ptr FTransform; b: ptr Box16): BoolT {.
    importc: "pixman_f_transform_bounds", dynlib: "libpixman-1.so".}
proc FTransformInitIdentity*(t: ptr FTransform) {.
    importc: "pixman_f_transform_init_identity", dynlib: "libpixman-1.so".}
proc RegionSetStaticPointers*(emptyBox: ptr Box16T;
                              emptyData: ptr Region16DataT;
                              brokenData: ptr Region16DataT) {.
    importc: "pixman_region_set_static_pointers", dynlib: "libpixman-1.so".}
proc RegionInit*(region: ptr Region16T) {.importc: "pixman_region_init",
    dynlib: "libpixman-1.so".}
proc RegionInitRect*(region: ptr Region16T; x: cint; y: cint; width: cuint;
                     height: cuint) {.importc: "pixman_region_init_rect",
                                      dynlib: "libpixman-1.so".}
proc RegionInitRects*(region: ptr Region16T; boxes: ptr Box16T; count: cint): BoolT {.
    importc: "pixman_region_init_rects", dynlib: "libpixman-1.so".}
proc RegionInitWithExtents*(region: ptr Region16T; extents: ptr Box16T) {.
    importc: "pixman_region_init_with_extents", dynlib: "libpixman-1.so".}
proc RegionInitFromImage*(region: ptr Region16T; image: ptr ImageT) {.
    importc: "pixman_region_init_from_image", dynlib: "libpixman-1.so".}
proc RegionFini*(region: ptr Region16T) {.importc: "pixman_region_fini",
    dynlib: "libpixman-1.so".}
proc RegionTranslate*(region: ptr Region16T; x: cint; y: cint) {.
    importc: "pixman_region_translate", dynlib: "libpixman-1.so".}
proc RegionCopy*(dest: ptr Region16T; source: ptr Region16T): BoolT {.
    importc: "pixman_region_copy", dynlib: "libpixman-1.so".}
proc RegionIntersect*(newReg: ptr Region16T; reg1: ptr Region16T;
                      reg2: ptr Region16T): BoolT {.
    importc: "pixman_region_intersect", dynlib: "libpixman-1.so".}
proc RegionUnion*(newReg: ptr Region16T; reg1: ptr Region16T;
                  reg2: ptr Region16T): BoolT {.importc: "pixman_region_union",
    dynlib: "libpixman-1.so".}
proc RegionUnionRect*(dest: ptr Region16T; source: ptr Region16T; x: cint;
                      y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region_union_rect", dynlib: "libpixman-1.so".}
proc RegionIntersectRect*(dest: ptr Region16T; source: ptr Region16T; x: cint;
                          y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region_intersect_rect", dynlib: "libpixman-1.so".}
proc RegionSubtract*(regD: ptr Region16T; regM: ptr Region16T;
                     regS: ptr Region16T): BoolT {.
    importc: "pixman_region_subtract", dynlib: "libpixman-1.so".}
proc RegionInverse*(newReg: ptr Region16T; reg1: ptr Region16T;
                    invRect: ptr Box16T): BoolT {.
    importc: "pixman_region_inverse", dynlib: "libpixman-1.so".}
proc RegionContainsPoint*(region: ptr Region16T; x: cint; y: cint;
                          box: ptr Box16T): BoolT {.
    importc: "pixman_region_contains_point", dynlib: "libpixman-1.so".}
proc RegionContainsRectangle*(region: ptr Region16T; prect: ptr Box16T): RegionOverlapT {.
    importc: "pixman_region_contains_rectangle", dynlib: "libpixman-1.so".}
proc RegionEmpty*(region: ptr Region16T): BoolT {.
    importc: "pixman_region_empty", dynlib: "libpixman-1.so".}
proc RegionNotEmpty*(region: ptr Region16T): BoolT {.
    importc: "pixman_region_not_empty", dynlib: "libpixman-1.so".}
proc RegionExtents*(region: ptr Region16T): ptr Box16T {.
    importc: "pixman_region_extents", dynlib: "libpixman-1.so".}
proc RegionNRects*(region: ptr Region16T): cint {.
    importc: "pixman_region_n_rects", dynlib: "libpixman-1.so".}
proc RegionRectangles*(region: ptr Region16T; nRects: ptr cint): ptr Box16T {.
    importc: "pixman_region_rectangles", dynlib: "libpixman-1.so".}
proc RegionEqual*(region1: ptr Region16T; region2: ptr Region16T): BoolT {.
    importc: "pixman_region_equal", dynlib: "libpixman-1.so".}
proc RegionSelfcheck*(region: ptr Region16T): BoolT {.
    importc: "pixman_region_selfcheck", dynlib: "libpixman-1.so".}
proc RegionReset*(region: ptr Region16T; box: ptr Box16T) {.
    importc: "pixman_region_reset", dynlib: "libpixman-1.so".}
proc RegionClear*(region: ptr Region16T) {.importc: "pixman_region_clear",
    dynlib: "libpixman-1.so".}
proc Region32Init*(region: ptr Region32T) {.importc: "pixman_region32_init",
    dynlib: "libpixman-1.so".}
proc Region32InitRect*(region: ptr Region32T; x: cint; y: cint; width: cuint;
                       height: cuint) {.importc: "pixman_region32_init_rect",
                                        dynlib: "libpixman-1.so".}
proc Region32InitRects*(region: ptr Region32T; boxes: ptr Box32T; count: cint): BoolT {.
    importc: "pixman_region32_init_rects", dynlib: "libpixman-1.so".}
proc Region32InitWithExtents*(region: ptr Region32T; extents: ptr Box32T) {.
    importc: "pixman_region32_init_with_extents", dynlib: "libpixman-1.so".}
proc Region32InitFromImage*(region: ptr Region32T; image: ptr ImageT) {.
    importc: "pixman_region32_init_from_image", dynlib: "libpixman-1.so".}
proc Region32Fini*(region: ptr Region32T) {.importc: "pixman_region32_fini",
    dynlib: "libpixman-1.so".}
proc Region32Translate*(region: ptr Region32T; x: cint; y: cint) {.
    importc: "pixman_region32_translate", dynlib: "libpixman-1.so".}
proc Region32Copy*(dest: ptr Region32T; source: ptr Region32T): BoolT {.
    importc: "pixman_region32_copy", dynlib: "libpixman-1.so".}
proc Region32Intersect*(newReg: ptr Region32T; reg1: ptr Region32T;
                        reg2: ptr Region32T): BoolT {.
    importc: "pixman_region32_intersect", dynlib: "libpixman-1.so".}
proc Region32Union*(newReg: ptr Region32T; reg1: ptr Region32T;
                    reg2: ptr Region32T): BoolT {.
    importc: "pixman_region32_union", dynlib: "libpixman-1.so".}
proc Region32IntersectRect*(dest: ptr Region32T; source: ptr Region32T; x: cint;
                            y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region32_intersect_rect", dynlib: "libpixman-1.so".}
proc Region32UnionRect*(dest: ptr Region32T; source: ptr Region32T; x: cint;
                        y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region32_union_rect", dynlib: "libpixman-1.so".}
proc Region32Subtract*(regD: ptr Region32T; regM: ptr Region32T;
                       regS: ptr Region32T): BoolT {.
    importc: "pixman_region32_subtract", dynlib: "libpixman-1.so".}
proc Region32Inverse*(newReg: ptr Region32T; reg1: ptr Region32T;
                      invRect: ptr Box32T): BoolT {.
    importc: "pixman_region32_inverse", dynlib: "libpixman-1.so".}
proc Region32ContainsPoint*(region: ptr Region32T; x: cint; y: cint;
                            box: ptr Box32T): BoolT {.
    importc: "pixman_region32_contains_point", dynlib: "libpixman-1.so".}
proc Region32ContainsRectangle*(region: ptr Region32T; prect: ptr Box32T): RegionOverlapT {.
    importc: "pixman_region32_contains_rectangle", dynlib: "libpixman-1.so".}
proc Region32Empty*(region: ptr Region32T): BoolT {.
    importc: "pixman_region32_empty", dynlib: "libpixman-1.so".}
proc Region32NotEmpty*(region: ptr Region32T): BoolT {.
    importc: "pixman_region32_not_empty", dynlib: "libpixman-1.so".}
proc Region32Extents*(region: ptr Region32T): ptr Box32T {.
    importc: "pixman_region32_extents", dynlib: "libpixman-1.so".}
proc Region32NRects*(region: ptr Region32T): cint {.
    importc: "pixman_region32_n_rects", dynlib: "libpixman-1.so".}
proc Region32Rectangles*(region: ptr Region32T; nRects: ptr cint): ptr Box32T {.
    importc: "pixman_region32_rectangles", dynlib: "libpixman-1.so".}
proc Region32Equal*(region1: ptr Region32T; region2: ptr Region32T): BoolT {.
    importc: "pixman_region32_equal", dynlib: "libpixman-1.so".}
proc Region32Selfcheck*(region: ptr Region32T): BoolT {.
    importc: "pixman_region32_selfcheck", dynlib: "libpixman-1.so".}
proc Region32Reset*(region: ptr Region32T; box: ptr Box32T) {.
    importc: "pixman_region32_reset", dynlib: "libpixman-1.so".}
proc Region32Clear*(region: ptr Region32T) {.importc: "pixman_region32_clear",
    dynlib: "libpixman-1.so".}
proc Region64fInit*(region: ptr Region64fT) {.importc: "pixman_region64f_init",
    dynlib: "libpixman-1.so".}
proc Region64fInitRect*(region: ptr Region64fT; x: cint; y: cint; width: cuint;
                        height: cuint) {.importc: "pixman_region64f_init_rect",
    dynlib: "libpixman-1.so".}
proc Region64fInitRectf*(region: ptr Region64fT; x: cdouble; y: cdouble;
                         width: cdouble; height: cdouble) {.
    importc: "pixman_region64f_init_rectf", dynlib: "libpixman-1.so".}
proc Region64fInitRects*(region: ptr Region64fT; boxes: ptr Box64fT; count: cint): BoolT {.
    importc: "pixman_region64f_init_rects", dynlib: "libpixman-1.so".}
proc Region64fInitWithExtents*(region: ptr Region64fT; extents: ptr Box64fT) {.
    importc: "pixman_region64f_init_with_extents", dynlib: "libpixman-1.so".}
proc Region64fInitFromImage*(region: ptr Region64fT; image: ptr ImageT) {.
    importc: "pixman_region64f_init_from_image", dynlib: "libpixman-1.so".}
proc Region64fFini*(region: ptr Region64fT) {.importc: "pixman_region64f_fini",
    dynlib: "libpixman-1.so".}
proc Region64fTranslate*(region: ptr Region64fT; x: cint; y: cint) {.
    importc: "pixman_region64f_translate", dynlib: "libpixman-1.so".}
proc Region64fCopy*(dest: ptr Region64fT; source: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_copy", dynlib: "libpixman-1.so".}
proc Region64fIntersect*(newReg: ptr Region64fT; reg1: ptr Region64fT;
                         reg2: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_intersect", dynlib: "libpixman-1.so".}
proc Region64fUnion*(newReg: ptr Region64fT; reg1: ptr Region64fT;
                     reg2: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_union", dynlib: "libpixman-1.so".}
proc Region64fIntersectRect*(dest: ptr Region64fT; source: ptr Region64fT;
                             x: cint; y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region64f_intersect_rect", dynlib: "libpixman-1.so".}
proc Region64fIntersectRectf*(dest: ptr Region64fT; source: ptr Region64fT;
                              x: cdouble; y: cdouble; width: cdouble;
                              height: cdouble): BoolT {.
    importc: "pixman_region64f_intersect_rectf", dynlib: "libpixman-1.so".}
proc Region64fUnionRect*(dest: ptr Region64fT; source: ptr Region64fT; x: cint;
                         y: cint; width: cuint; height: cuint): BoolT {.
    importc: "pixman_region64f_union_rect", dynlib: "libpixman-1.so".}
proc Region64fUnionRectf*(dest: ptr Region64fT; source: ptr Region64fT;
                          x: cdouble; y: cdouble; width: cdouble;
                          height: cdouble): BoolT {.
    importc: "pixman_region64f_union_rectf", dynlib: "libpixman-1.so".}
proc Region64fSubtract*(regD: ptr Region64fT; regM: ptr Region64fT;
                        regS: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_subtract", dynlib: "libpixman-1.so".}
proc Region64fInverse*(newReg: ptr Region64fT; reg1: ptr Region64fT;
                       invRect: ptr Box64fT): BoolT {.
    importc: "pixman_region64f_inverse", dynlib: "libpixman-1.so".}
proc Region64fContainsPoint*(region: ptr Region64fT; x: cint; y: cint;
                             box: ptr Box64fT): BoolT {.
    importc: "pixman_region64f_contains_point", dynlib: "libpixman-1.so".}
proc Region64fContainsRectangle*(region: ptr Region64fT; prect: ptr Box64fT): RegionOverlapT {.
    importc: "pixman_region64f_contains_rectangle", dynlib: "libpixman-1.so".}
proc Region64fEmpty*(region: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_empty", dynlib: "libpixman-1.so".}
proc Region64fNotEmpty*(region: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_not_empty", dynlib: "libpixman-1.so".}
proc Region64fExtents*(region: ptr Region64fT): ptr Box64fT {.
    importc: "pixman_region64f_extents", dynlib: "libpixman-1.so".}
proc Region64fNRects*(region: ptr Region64fT): cint {.
    importc: "pixman_region64f_n_rects", dynlib: "libpixman-1.so".}
proc Region64fRectangles*(region: ptr Region64fT; nRects: ptr cint): ptr Box64fT {.
    importc: "pixman_region64f_rectangles", dynlib: "libpixman-1.so".}
proc Region64fEqual*(region1: ptr Region64fT; region2: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_equal", dynlib: "libpixman-1.so".}
proc Region64fSelfcheck*(region: ptr Region64fT): BoolT {.
    importc: "pixman_region64f_selfcheck", dynlib: "libpixman-1.so".}
proc Region64fReset*(region: ptr Region64fT; box: ptr Box64fT) {.
    importc: "pixman_region64f_reset", dynlib: "libpixman-1.so".}
proc Region64fClear*(region: ptr Region64fT) {.
    importc: "pixman_region64f_clear", dynlib: "libpixman-1.so".}
proc Blt*(srcBits: ptr uint32; dstBits: ptr uint32; srcStride: cint;
          dstStride: cint; srcBpp: cint; dstBpp: cint; srcX: cint; srcY: cint;
          destX: cint; destY: cint; width: cint; height: cint): BoolT {.
    importc: "pixman_blt", dynlib: "libpixman-1.so".}
proc Fill*(bits: ptr uint32; stride: cint; bpp: cint; x: cint; y: cint;
           width: cint; height: cint; `xor`: uint32): BoolT {.
    importc: "pixman_fill", dynlib: "libpixman-1.so".}
proc Version*(): cint {.importc: "pixman_version", dynlib: "libpixman-1.so".}
proc VersionString*(): cstring {.importc: "pixman_version_string",
                                 dynlib: "libpixman-1.so".}
proc FormatSupportedDestination*(format: FormatCodeT): BoolT {.
    importc: "pixman_format_supported_destination", dynlib: "libpixman-1.so".}
proc FormatSupportedSource*(format: FormatCodeT): BoolT {.
    importc: "pixman_format_supported_source", dynlib: "libpixman-1.so".}
proc ImageCreateSolidFill*(color: ptr ColorT): ptr ImageT {.
    importc: "pixman_image_create_solid_fill", dynlib: "libpixman-1.so".}
proc ImageCreateLinearGradient*(p1: ptr PointFixedT; p2: ptr PointFixedT;
                                stops: ptr GradientStopT; nStops: cint): ptr ImageT {.
    importc: "pixman_image_create_linear_gradient", dynlib: "libpixman-1.so".}
proc ImageCreateRadialGradient*(inner: ptr PointFixedT; outer: ptr PointFixedT;
                                innerRadius: FixedT; outerRadius: FixedT;
                                stops: ptr GradientStopT; nStops: cint): ptr ImageT {.
    importc: "pixman_image_create_radial_gradient", dynlib: "libpixman-1.so".}
proc ImageCreateConicalGradient*(center: ptr PointFixedT; angle: FixedT;
                                 stops: ptr GradientStopT; nStops: cint): ptr ImageT {.
    importc: "pixman_image_create_conical_gradient", dynlib: "libpixman-1.so".}
proc ImageCreateBits*(format: FormatCodeT; width: cint; height: cint;
                      bits: ptr uint32; rowstrideBytes: cint): ptr ImageT {.
    importc: "pixman_image_create_bits", dynlib: "libpixman-1.so".}
proc ImageCreateBitsNoClear*(format: FormatCodeT; width: cint; height: cint;
                             bits: ptr uint32; rowstrideBytes: cint): ptr ImageT {.
    importc: "pixman_image_create_bits_no_clear", dynlib: "libpixman-1.so".}
proc ImageRef*(image: ptr ImageT): ptr ImageT {.importc: "pixman_image_ref",
    dynlib: "libpixman-1.so".}
proc ImageUnref*(image: ptr ImageT): BoolT {.importc: "pixman_image_unref",
    dynlib: "libpixman-1.so".}
proc ImageSetDestroyFunction*(image: ptr ImageT; function: ImageDestroyFuncT;
                              data: pointer) {.
    importc: "pixman_image_set_destroy_function", dynlib: "libpixman-1.so".}
proc ImageGetDestroyData*(image: ptr ImageT): pointer {.
    importc: "pixman_image_get_destroy_data", dynlib: "libpixman-1.so".}
proc ImageSetClipRegion*(image: ptr ImageT; region: ptr Region16T): BoolT {.
    importc: "pixman_image_set_clip_region", dynlib: "libpixman-1.so".}
proc ImageSetClipRegion32*(image: ptr ImageT; region: ptr Region32T): BoolT {.
    importc: "pixman_image_set_clip_region32", dynlib: "libpixman-1.so".}
proc ImageSetClipRegion64f*(image: ptr ImageT; region: ptr Region64fT): BoolT {.
    importc: "pixman_image_set_clip_region64f", dynlib: "libpixman-1.so".}
proc ImageSetHasClientClip*(image: ptr ImageT; clienClip: BoolT) {.
    importc: "pixman_image_set_has_client_clip", dynlib: "libpixman-1.so".}
proc ImageSetTransform*(image: ptr ImageT; transform: ptr TransformT): BoolT {.
    importc: "pixman_image_set_transform", dynlib: "libpixman-1.so".}
proc ImageSetRepeat*(image: ptr ImageT; repeat: RepeatT) {.
    importc: "pixman_image_set_repeat", dynlib: "libpixman-1.so".}
proc ImageSetDither*(image: ptr ImageT; dither: DitherT) {.
    importc: "pixman_image_set_dither", dynlib: "libpixman-1.so".}
proc ImageSetDitherOffset*(image: ptr ImageT; offsetX: cint; offsetY: cint) {.
    importc: "pixman_image_set_dither_offset", dynlib: "libpixman-1.so".}
proc ImageSetFilter*(image: ptr ImageT; filter: FilterT;
                     filterParams: ptr FixedT; nFilterParams: cint): BoolT {.
    importc: "pixman_image_set_filter", dynlib: "libpixman-1.so".}
proc ImageSetSourceClipping*(image: ptr ImageT; sourceClipping: BoolT) {.
    importc: "pixman_image_set_source_clipping", dynlib: "libpixman-1.so".}
proc ImageSetAlphaMap*(image: ptr ImageT; alphaMap: ptr ImageT; x: int16;
                       y: int16) {.importc: "pixman_image_set_alpha_map",
                                   dynlib: "libpixman-1.so".}
proc ImageSetComponentAlpha*(image: ptr ImageT; componentAlpha: BoolT) {.
    importc: "pixman_image_set_component_alpha", dynlib: "libpixman-1.so".}
proc ImageGetComponentAlpha*(image: ptr ImageT): BoolT {.
    importc: "pixman_image_get_component_alpha", dynlib: "libpixman-1.so".}
proc ImageSetAccessors*(image: ptr ImageT; readFunc: ReadMemoryFuncT;
                        writeFunc: WriteMemoryFuncT) {.
    importc: "pixman_image_set_accessors", dynlib: "libpixman-1.so".}
proc ImageSetIndexed*(image: ptr ImageT; indexed: ptr IndexedT) {.
    importc: "pixman_image_set_indexed", dynlib: "libpixman-1.so".}
proc ImageGetData*(image: ptr ImageT): ptr uint32 {.
    importc: "pixman_image_get_data", dynlib: "libpixman-1.so".}
proc ImageGetWidth*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_width", dynlib: "libpixman-1.so".}
proc ImageGetHeight*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_height", dynlib: "libpixman-1.so".}
proc ImageGetStride*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_stride", dynlib: "libpixman-1.so".}
proc ImageGetDepth*(image: ptr ImageT): cint {.
    importc: "pixman_image_get_depth", dynlib: "libpixman-1.so".}
proc ImageGetFormat*(image: ptr ImageT): FormatCodeT {.
    importc: "pixman_image_get_format", dynlib: "libpixman-1.so".}
proc FilterCreateSeparableConvolution*(nValues: ptr cint; scaleX: FixedT;
                                       scaleY: FixedT; reconstructX: KernelT;
                                       reconstructY: KernelT; sampleX: KernelT;
                                       sampleY: KernelT; subsampleBitsX: cint;
                                       subsampleBitsY: cint): ptr FixedT {.
    importc: "pixman_filter_create_separable_convolution",
    dynlib: "libpixman-1.so".}
proc ImageFillRectangles*(op: OpT; image: ptr ImageT; color: ptr ColorT;
                          nRects: cint; rects: ptr Rectangle16T): BoolT {.
    importc: "pixman_image_fill_rectangles", dynlib: "libpixman-1.so".}
proc ImageFillBoxes*(op: OpT; dest: ptr ImageT; color: ptr ColorT; nBoxes: cint;
                     boxes: ptr Box32T): BoolT {.
    importc: "pixman_image_fill_boxes", dynlib: "libpixman-1.so".}
proc ComputeCompositeRegion*(region: ptr Region16T; srcImage: ptr ImageT;
                             maskImage: ptr ImageT; destImage: ptr ImageT;
                             srcX: int16; srcY: int16; maskX: int16;
                             maskY: int16; destX: int16; destY: int16;
                             width: uint16; height: uint16): BoolT {.
    importc: "pixman_compute_composite_region", dynlib: "libpixman-1.so".}
proc ImageComposite*(op: OpT; src: ptr ImageT; mask: ptr ImageT;
                     dest: ptr ImageT; srcX: int16; srcY: int16; maskX: int16;
                     maskY: int16; destX: int16; destY: int16; width: uint16;
                     height: uint16) {.importc: "pixman_image_composite",
                                       dynlib: "libpixman-1.so".}
proc ImageComposite32*(op: OpT; src: ptr ImageT; mask: ptr ImageT;
                       dest: ptr ImageT; srcX: int32; srcY: int32; maskX: int32;
                       maskY: int32; destX: int32; destY: int32; width: int32;
                       height: int32) {.importc: "pixman_image_composite32",
                                        dynlib: "libpixman-1.so".}
proc ImageComposite64f*(op: OpT; src: ptr ImageT; mask: ptr ImageT;
                        dest: ptr ImageT; srcX: cdouble; srcY: cdouble;
                        maskX: cdouble; maskY: cdouble; destX: cdouble;
                        destY: cdouble; width: cdouble; height: cdouble) {.
    importc: "pixman_image_composite64f", dynlib: "libpixman-1.so".}
proc DisableOutOfBoundsWorkaround*() {.importc: "pixman_disable_out_of_bounds_workaround",
                                       dynlib: "libpixman-1.so".}
proc GlyphCacheCreate*(): ptr GlyphCacheT {.
    importc: "pixman_glyph_cache_create", dynlib: "libpixman-1.so".}
proc GlyphCacheDestroy*(cache: ptr GlyphCacheT) {.
    importc: "pixman_glyph_cache_destroy", dynlib: "libpixman-1.so".}
proc GlyphCacheFreeze*(cache: ptr GlyphCacheT) {.
    importc: "pixman_glyph_cache_freeze", dynlib: "libpixman-1.so".}
proc GlyphCacheThaw*(cache: ptr GlyphCacheT) {.
    importc: "pixman_glyph_cache_thaw", dynlib: "libpixman-1.so".}
proc GlyphCacheLookup*(cache: ptr GlyphCacheT; fontKey: pointer;
                       glyphKey: pointer): pointer {.
    importc: "pixman_glyph_cache_lookup", dynlib: "libpixman-1.so".}
proc GlyphCacheInsert*(cache: ptr GlyphCacheT; fontKey: pointer;
                       glyphKey: pointer; originX: cint; originY: cint;
                       glyphImage: ptr ImageT): pointer {.
    importc: "pixman_glyph_cache_insert", dynlib: "libpixman-1.so".}
proc GlyphCacheRemove*(cache: ptr GlyphCacheT; fontKey: pointer;
                       glyphKey: pointer) {.
    importc: "pixman_glyph_cache_remove", dynlib: "libpixman-1.so".}
proc GlyphGetExtents*(cache: ptr GlyphCacheT; nGlyphs: cint; glyphs: ptr GlyphT;
                      extents: ptr Box32T) {.
    importc: "pixman_glyph_get_extents", dynlib: "libpixman-1.so".}
proc GlyphGetMaskFormat*(cache: ptr GlyphCacheT; nGlyphs: cint;
                         glyphs: ptr GlyphT): FormatCodeT {.
    importc: "pixman_glyph_get_mask_format", dynlib: "libpixman-1.so".}
proc CompositeGlyphs*(op: OpT; src: ptr ImageT; dest: ptr ImageT;
                      maskFormat: FormatCodeT; srcX: int32; srcY: int32;
                      maskX: int32; maskY: int32; destX: int32; destY: int32;
                      width: int32; height: int32; cache: ptr GlyphCacheT;
                      nGlyphs: cint; glyphs: ptr GlyphT) {.
    importc: "pixman_composite_glyphs", dynlib: "libpixman-1.so".}
proc CompositeGlyphsNoMask*(op: OpT; src: ptr ImageT; dest: ptr ImageT;
                            srcX: int32; srcY: int32; destX: int32;
                            destY: int32; cache: ptr GlyphCacheT; nGlyphs: cint;
                            glyphs: ptr GlyphT) {.
    importc: "pixman_composite_glyphs_no_mask", dynlib: "libpixman-1.so".}
proc SampleCeilY*(y: FixedT; bpp: cint): FixedT {.
    importc: "pixman_sample_ceil_y", dynlib: "libpixman-1.so".}
proc SampleFloorY*(y: FixedT; bpp: cint): FixedT {.
    importc: "pixman_sample_floor_y", dynlib: "libpixman-1.so".}
proc EdgeStep*(e: ptr EdgeT; n: cint) {.importc: "pixman_edge_step",
                                        dynlib: "libpixman-1.so".}
proc EdgeInit*(e: ptr EdgeT; bpp: cint; yStart: FixedT; xTop: FixedT;
               yTop: FixedT; xBot: FixedT; yBot: FixedT) {.
    importc: "pixman_edge_init", dynlib: "libpixman-1.so".}
proc LineFixedEdgeInit*(e: ptr EdgeT; bpp: cint; y: FixedT;
                        line: ptr LineFixedT; xOff: cint; yOff: cint) {.
    importc: "pixman_line_fixed_edge_init", dynlib: "libpixman-1.so".}
proc RasterizeEdges*(image: ptr ImageT; l: ptr EdgeT; r: ptr EdgeT; t: FixedT;
                     b: FixedT) {.importc: "pixman_rasterize_edges",
                                  dynlib: "libpixman-1.so".}
proc AddTraps*(image: ptr ImageT; xOff: int16; yOff: int16; ntrap: cint;
               traps: ptr TrapT) {.importc: "pixman_add_traps",
                                   dynlib: "libpixman-1.so".}
proc AddTrapezoids*(image: ptr ImageT; xOff: int16; yOff: cint; ntraps: cint;
                    traps: ptr TrapezoidT) {.importc: "pixman_add_trapezoids",
    dynlib: "libpixman-1.so".}
proc RasterizeTrapezoid*(image: ptr ImageT; trap: ptr TrapezoidT; xOff: cint;
                         yOff: cint) {.importc: "pixman_rasterize_trapezoid",
                                       dynlib: "libpixman-1.so".}
proc CompositeTrapezoids*(op: OpT; src: ptr ImageT; dst: ptr ImageT;
                          maskFormat: FormatCodeT; xSrc: cint; ySrc: cint;
                          xDst: cint; yDst: cint; nTraps: cint;
                          traps: ptr TrapezoidT) {.
    importc: "pixman_composite_trapezoids", dynlib: "libpixman-1.so".}
proc CompositeTriangles*(op: OpT; src: ptr ImageT; dst: ptr ImageT;
                         maskFormat: FormatCodeT; xSrc: cint; ySrc: cint;
                         xDst: cint; yDst: cint; nTris: cint;
                         tris: ptr TriangleT) {.
    importc: "pixman_composite_triangles", dynlib: "libpixman-1.so".}
proc AddTriangles*(image: ptr ImageT; xOff: int32; yOff: int32; nTris: cint;
                   tris: ptr TriangleT) {.importc: "pixman_add_triangles",
    dynlib: "libpixman-1.so".}