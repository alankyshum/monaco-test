package require Plotchart

puts "What do you want to say?"
set userInput "aaaabbccee"
# set userInput [gets stdin]

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

pack [canvas .c -width 1280 -height 720 -bg white];
set alphabets [list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
set p [::Plotchart::createHistogram .c {0 26 ""} {0 100 1} \
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

  # puts "letter plotData: $letter $chartIndex $occurrence";
  $p plot data $chartIndex $occurrence;
}

# debugging
# exit
