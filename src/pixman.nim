template fixedToInt*(f: untyped): untyped =
  ((int)((f) shr 16))

template intToFixed*(i: untyped): untyped =
  ((FixedT)((i) shl 16))

template fixedToDouble*(f: untyped): untyped =
  (double)((f) div cast[cdouble](Fixed1))

template doubleToFixed*(d: untyped): untyped =
  ((FixedT)((d) * 65536.0))

template fixedFrac*(f: untyped): untyped =
  ((f) and Fixed1MinusE)

template fixedFloor*(f: untyped): untyped =
  ((f) and not Fixed1MinusE)

template fixedCeil*(f: untyped): untyped =
  FixedFloor((f) + Fixed1MinusE)

template fixedFraction*(f: untyped): untyped =
  ((f) and Fixed1MinusE)

template fixedMod2*(f: untyped): untyped =
  ((f) and (Fixed1 or Fixed1MinusE))

template format*(bpp, `type`, a, r, g, b: untyped): untyped =
  (((bpp) shl 24) or ((`type`) shl 16) or ((a) shl 12) or ((r) shl 8) or
      ((g) shl 4) or
      ((b)))

template format_Byte*(bpp, `type`, a, r, g, b: untyped): untyped =
  (((bpp shr 3) shl 24) or (3 shl 22) or ((`type`) shl 16) or ((a shr 3) shl 12) or
      ((r shr 3) shl 8) or
      ((g shr 3) shl 4) or
      ((b shr 3)))

template format_Reshift*(val, ofs, num: untyped): untyped =
  (((val shr (ofs)) and ((1 shl (num)) - 1)) shl ((val shr 22) and 3))

template format_Bpp*(f: untyped): untyped =
  Format_Reshift(f, 24, 8)

template format_Shift*(f: untyped): untyped =
  ((uint32)((f shr 22) and 3))

template format_Type*(f: untyped): untyped =
  (((f) shr 16) and 0x0000003F)

template format_A*(f: untyped): untyped =
  Format_Reshift(f, 12, 4)

template format_R*(f: untyped): untyped =
  Format_Reshift(f, 8, 4)

template format_G*(f: untyped): untyped =
  Format_Reshift(f, 4, 4)

template format_B*(f: untyped): untyped =
  Format_Reshift(f, 0, 4)

template format_Rgb*(f: untyped): untyped =
  (((f)) and 0x00000FFF)

template format_Vis*(f: untyped): untyped =
  (((f)) and 0x0000FFFF)

template format_Depth*(f: untyped): untyped =
  (Format_A(f) + Format_R(f) + Format_G(f) + Format_B(f))

template format_Color*(f: untyped): untyped =
  (Format_Type(f) == Type_Argb or Format_Type(f) == Type_Abgr or
      Format_Type(f) == Type_Bgra or
      Format_Type(f) == Type_Rgba or
      Format_Type(f) == Type_Rgba_Float)

template trapezoidValid*(t: untyped): untyped =
  ((t).left.p1.y != (t).left.p2.y and (t).right.p1.y != (t).right.p2.y and
      ((t).bottom > (t).top))

include pixman/includes/pixman_core