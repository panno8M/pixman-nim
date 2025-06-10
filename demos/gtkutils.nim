{.passc: "-I /usr/include/gtk-3.0".}
{.passl: "-lgtk-3".}
{.passc: "-I /usr/include/glib-2.0".}
{.passc: "-I /usr/lib/glib-2.0/include".}
{.passl: "-lglib-2.0".}
{.passc: "-I /usr/include/pango-1.0".}
{.passl: "-lpango-1.0".}
{.passc: "-I /usr/include/harfbuzz".}
{.passl: "-lharfbuzz".}
{.passc: "-I /usr/include/cairo".}
{.passl: "-lcairo".}
{.passc: "-I /usr/include/gdk-pixbuf-2.0".}
{.passl: "-lgdk_pixbuf-2.0".}
{.passc: "-I /usr/include/atk-1.0".}
{.passl: "-latk-1.0".}
{.passl: "-lgobject-2.0".}
{.passl: "-lpixman-1".}
{.compile: "../pixman/demos/gtk-utils.c".}

import pixman

proc showImage*(image: ptr ImageT) {.importc: "show_image".}
proc imageFromFile*(filename: cstring; format: FormatCodeT): ptr ImageT {.importc: "pixman_image_from_file".}