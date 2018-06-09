package require Plotchart

puts "What do you want to say?"
set userInput "aaaabbcc"
# set userInput [gets stdin]

proc getLetterOccurrence {srcString} {
  array set occurrenceList [list]
  set srcStringLength [string length $srcString]

  for {set i 0} {$i < [string length $srcString]} {incr i} {
    set letter [string index $srcString $i];

    if ([info exists occurrenceList($letter)]) {
      incr occurrenceList($letter);
    } else {
      set occurrenceList($letter) 1;
    }
  }

  foreach {letter occurrence} [array get occurrenceList] {
    set occurrence [expr double($occurrence)]
    set occurrenceList($letter) [expr {$occurrence / $userInputLength * 100}]
  }

  return [array get occurrenceList]
}

set letterOccurrenceList [getLetterOccurrence $userInput]

# pack [canvas .c -width 400 -height 300 -bg white]

# set p [::Plotchart::createHistogram .c {0 100 20} {0 50 10}]

# $p dataconfig data -style filled -fillcolour cyan -width 2 -colour blue

# $p plot data 0.0  10.0
# $p plot data 20.0 10.0
# $p plot data 40.0  3.0
# $p plot data 45.0  6.0
# $p plot data 55.0 26.0
# $p plot data 67.0 24.0


# # debugging
# exit
