3D bar chart (on a Tk canvas)
FROM: http://en.wikibooks.org/wiki/Tcl_Programming/Tk_examples
(imaged on 19 mar 2009)

The following script displays a bar chart on a canvas,
with pseudo-3-dimensional bars - a rectangle in front as
specified, embellished with two polygons - one for the top,
one for the side.

----

proc 3drect {w args} {
   if [string is int -strict [lindex $args 1]] {
      set coords [lrange $args 0 3]
   } else {
      set coords [lindex $args 0]
   }
   foreach {x0 y0 x1 y1} $coords break
   set d [expr {($x1-$x0)/3}]
   set x2 [expr {$x0+$d+1}]
   set x3 [expr {$x1+$d}]
   set y2 [expr {$y0-$d+1}]
   set y3 [expr {$y1-$d-1}]
   set id [eval [list $w create rect] $args]
   set fill [$w itemcget $id -fill]
   set tag [$w gettags $id]
   $w create poly $x0 $y0 $x2 $y2 $x3 $y2 $x1 $y0 \
       -fill [dim $fill 0.8] -outline black
   $w create poly $x1 $y1 $x3 $y3 $x3 $y2 $x1 $y0 \
       -fill [dim $fill 0.6] -outline black -tag $tag
}

# For a more plastic look, the fill color of the polygons is
# reduced in brightness ("dimmed"):

proc dim {color factor} {
  foreach i {r g b} n [winfo rgb . $color] d [winfo rgb . white] {
     set $i [expr int(255.*$n/$d*$factor)]
  }
  format #%02x%02x%02x $r $g $b
}

# Draw a simple scale for the y axis, and return the scaling factor:

proc yscale {w x0 y0 y1 min max} {
  set dy   [expr {$y1-$y0}]
  regexp {([1-9]+)} $max -> prefix
  set stepy [expr {1.*$dy/$prefix}]
  set step [expr {$max/$prefix}]
  set y $y0
  set label $max
  while {$label>=$min} {
     $w create text $x0 $y -text $label -anchor w
     set y [expr {$y+$stepy}]
     set label [expr {$label-$step}]
  }
  expr {$dy/double($max)}
}

# An interesting sub-challenge was to round numbers very roughly,
# to 1 or maximally 2 significant digits - by default rounding up,
# add "-" to round down:

proc roughly {n {sgn +}} {
  regexp {(.+)e([+-])0*(.+)} [format %e $n] -> mant sign exp
  set exp [expr $sign$exp]
  if {abs($mant)<1.5} {
     set mant [expr $mant*10]
     incr exp -1
  }
  set t [expr round($mant $sgn 0.49)*pow(10,$exp)]
  expr {$exp>=0? int($t): $t}
}

# So here is my little bar chart generator. Given a canvas pathname,
# a bounding rectangle, and the data to display (a list of
# {name value color} triples), it figures out the geometry.
# A gray "ground plane" is drawn first. Note how negative values
# are tagged with "d"(eficit), so they look like they
# "drop through the plane".

proc bars {w x0 y0 x1 y1 data} {
   set vals 0
   foreach bar $data {
      lappend vals [lindex $bar 1]
   }
   set top [roughly [max $vals]]
   set bot [roughly [min $vals] -]
   set f [yscale $w $x0 $y0 $y1 $bot $top]
   set x [expr $x0+30]
   set dx [expr ($x1-$x0-$x)/[llength $data]]
   set y3 [expr $y1-20]
   set y4 [expr $y1+10]
   $w create poly $x0 $y4 [expr $x0+30] $y3 $x1 $y3 [expr $x1-20] $y4 -fill gray65
   set dxw [expr $dx*6/10]
   foreach bar $data {
      foreach {txt val col} $bar break
      set y [expr {round($y1-($val*$f))}]
      set y1a $y1
      if {$y>$y1a} {swap y y1a}
      set tag [expr {$val<0? "d": ""}]
      3drect $w $x $y [expr $x+$dxw] $y1a -fill $col -tag $tag
      $w create text [expr {$x+12}] [expr {$y-12}] -text $val
      $w create text [expr {$x+12}] [expr {$y1a+2}] -text $txt -anchor n
      incr x $dx
   }
   $w lower d
}

# Generally useful helper functions:

proc max list {
   set res [lindex $list 0]
   foreach e [lrange $list 1 end] {
      if {$e>$res} {set res $e}
   }
   set res
}
proc min list {
   set res [lindex $list 0]
   foreach e [lrange $list 1 end] {
      if {$e<$res} {set res $e}
   }
   set res
}
proc swap {_a _b} {
   upvar 1 $_a a $_b b
   foreach {a b} [list $b $a] break
}

# Putting it all together:

pack [canvas .c -width 240 -height 280]
bars .c 10 20 240 230 {
  {red 765 red}
  {green 234 green}
  {blue 345 blue}
  {yel-\nlow 321 yellow}
  {ma-\ngenta 567 magenta}
  {cyan -123 cyan}
  {white 400 white}
}
.c create text 120 10 -anchor nw -font {Helvetica 18} -text "Bar Chart\nDemo"
