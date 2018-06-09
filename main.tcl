puts "What do you want to say?"

# set userInput "asdasdasdasd asd asd"
set userInput [gets stdin]

array set letterOccurrenceList [list]
set userInputLength [string length $userInput]

puts "\[DEBUG\]: String '$userInput' with length $userInputLength"

# # get number of occurrence of each letter
for {set i 0} {$i < [string length $userInput]} {incr i} {
  set letter [string index $userInput $i];
  set letterOccurence [array get letterOccurrenceList($letter)];

  set hasRecord [info exists letterOccurrenceList($letter)];
  puts "$letter has record? $hasRecord"
  if ($hasRecord) { set letterOccurence [expr { $letterOccurence + 1 }] } else { set letterOccurence 0 }

  set letterOccurrenceList($letter) $letterOccurence
}

puts [array get letterOccurrenceList]

# # get percentages
# Object.keys(letterOccurrenceList).forEach(letter => {
#   letterOccurrenceList[letter] = letterOccurrenceList[letter] / userInputLength;
# })

# # plot chart


# debugging
exit
