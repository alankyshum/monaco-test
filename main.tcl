puts "What do you want to say?"
set userInput "aaaabbcc"
# set userInput [gets stdin]

array set letterOccurrenceList [list]

proc getLetterOccurrence {userInput} {
  set userInputLength [string length $userInput]

  for {set i 0} {$i < [string length $userInput]} {incr i} {
    set letter [string index $userInput $i];

    if ([info exists letterOccurrenceList($letter)]) {
      incr letterOccurrenceList($letter);
    } else {
      set letterOccurrenceList($letter) 1;
    }
  }

  foreach {letter occurrence} [array get letterOccurrenceList] {
    set occurrence [expr double($occurrence)]
    set letterOccurrenceList($letter) [expr {$occurrence / $userInputLength * 100}]
  }

  return [array get letterOccurrenceList]
}

puts [getLetterOccurrence $userInput]

# # get percentages
# Object.keys(letterOccurrenceList).forEach(letter => {
#   letterOccurrenceList[letter] = letterOccurrenceList[letter] / userInputLength;
# })

# # plot chart


# debugging
exit
