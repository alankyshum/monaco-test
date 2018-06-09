package require Plotchart

puts "What do you want to say?"
set userInput [gets stdin]

proc getLetterOccurrence {srcString} {
  array set occurrenceList [list]
  set srcStringLength [string length $srcString]

  for {set i 0} {$i < [string length $srcString]} {incr i} {
    set letter [string index $srcString $i];
    set letter [string toupper $letter ]

    if ([info exists occurrenceList($letter)]) {
      incr occurrenceList($letter);
    } else {
      set occurrenceList($letter) 1;
    }
  }

  foreach {letter occurrence} [array get occurrenceList] {
    set occurrence [expr double($occurrence)]
    set occurrenceList($letter) [expr {$occurrence / $srcStringLength * 100}]
  }

  return [array get occurrenceList]
}

array set letterOccurrenceList [getLetterOccurrence $userInput]
puts "\[DEBUG\] letterOccurrenceList = [array get letterOccurrenceList]"

proc findMax {valueList} {
  array set valueArray $valueList
  set max 0

  foreach {letter occurrence} [array get valueArray] {
    set occurrence [expr double($occurrence)]
    if ([expr {$occurrence > $max}]) { set max $occurrence }
  }

  return $max
}

set alphabets [list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
set maxPercentage [findMax [array get letterOccurrenceList]]
set yRange [list 0 $maxPercentage 1]
set xRange [list 0 [llength $alphabets] ""]

pack [canvas .c -width 1280 -height 720 -bg white];
Plotchart::plotstyle configure default histogram leftaxis format "%.0f%%"
set p [::Plotchart::createHistogram .c $xRange $yRange \
  -xlabels $alphabets
];

$p dataconfig data -style filled -fillcolour #50ACC4 -colour "";

for {set i 0} {$i < [llength $alphabets]} {incr i} {
  set letter [lindex $alphabets $i]
  set chartIndex [expr {$i + 1}]

  if ([info exists letterOccurrenceList($letter)]) {
    set occurrence $letterOccurrenceList($letter)
  } else {
    set occurrence 0
  }

  puts "letter plotData: $letter $chartIndex $occurrence";
  $p plot data $chartIndex $occurrence;
}

# # # debugging
# exit
