{.passc: "-I /usr/include/pixman-1".}
import
  pixman, gtkutils

type
  BitMap[S: static Size] = array[S.h, array[S.w, uint32]]
  Point = object
    x, y: int16
  Size = object
    w, h: uint16

proc point(x, y: uint16): Point = Point(x: x.int16, y: y.int16)
proc zero(_: typedesc[Point]): Point = Point()
proc size(w, h: uint16): Size = Size(w: w, h: h)
proc `*`(s1, s2: Size): Size = size(s1.w * s2.w, s1.h * s2.h)
proc filled(B: typedesc[BitMap]; value: uint32): B =
  for h in 0'u16..<B.S.h:
    for w in 0'u16..<B.S.w:
      result[h][w] = value

proc createImage(src: BitMap, format: FormatCodeT): ptr ImageT =
  createBits(format, src.S.w.cint, src.S.h.cint, addr src[0][0], cint sizeof(src[0]))

proc screen(src, mask, dest: ptr ImageT;
            src_p, mask_p, dest_p: Point;
            size: Size) =
  composite(opScreen,
    src, mask, dest,
    src_p.x, src_p.y,
    mask_p.x, mask_p.y,
    dest_p.x, dest_p.y,
    size.w, size.h)

const
  S = size(40, 40)
let
  simg1 = BitMap[S].filled(0xff00007f'u32).createImage(r8g8b8a8)
  simg2 = BitMap[S].filled(0x00ff007f'u32).createImage(r8g8b8a8)
  simg3 = BitMap[S].filled(0x0000ff7f'u32).createImage(r8g8b8a8)
var dest: BitMap[S * size(3, 2)]
let dimg = dest.createImage(r8g8b8a8)
simg1.screen(nil, dimg, Point.zero, Point.zero, point(S.w, S.h div 4), S)
simg2.screen(nil, dimg, Point.zero, Point.zero, point(S.w div 2, S.h div 4 + S.h div 2), S)
simg3.screen(nil, dimg, Point.zero, Point.zero, point(S.w * 4 div 3, S.h), S)
show_image(dimg)
