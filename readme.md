# Monaco test
A programme written in `tcl/tk` to take user input from console, and plot a histogram chart on the occurrence of different alphabet characters in the input.

## Within 1.5 hour

1. What? What's TCL? Googled around and downloaded the installation package, coz the
    - `brew install wish` yields an error of formula not found
1. Able to take user input
1. Read number of occurrence of different letters
    - Got looping of a string working
1. Looked into how to plot chart and tons of docs
    - :thinking: Um...
1. Setup my vscode default build task
    - allowing me to run build as quickly as possible
    ```json
    {
      // See https://go.microsoft.com/fwlink/?LinkId=733558
      // for the documentation about the tasks.json format
      "version": "2.0.0",
      "tasks": [
        {
          "label": "Build Wish",
          "type": "shell",
          "command": "wish ${file}",
          "group": {
            "kind": "build",
            "isDefault": true
          }
        }
      ]
    }
    ```

## Extra 3 hours - Impediments

### Data Structure

- Array can only be manipulated, or passed to passed with `[array set arr]` and `[array get arr]`
- Which mean cannot use `$arr` to read an array, as they need that 'evaluation' wrapper

### Basics

- Totally new things to me, almost as fun as writing Hammerspoon script on my Mac in Lua
- Setting variables `set $var1 = 1` (shit, should be `set var 1`)
- Setting array `array set arr [list]`
- Often forgot the different syntax for read and write

### Builtin Functions

- `max` function requires list of arguments, and does not accept list or array
- Arithmetric Comparisons requires extra wrapper `[expr {$one == 1}]`

### Lack of examples

- The official docs has no example, and the doc style is really old school, took me some time to really understand that (e.g. when configuring the format of the axis)

### Debugging

- Can't check variable type easily, but need to guess by running the code. That's how I recognise the difference between `array` and `list` in this language.

## Reflections
> I personally always find it fun to learn new things, but I was surprised by how long I need to finish this project. Logics are simple but debugging and looking for reference is hard. However, I never felt so excited to get this done!!! In new language!!! WOW, anyway, I am proud of what I have done.

## References

1. [Getting Started Tutorial from ActiveTcl](http://docs.activestate.com/activetcl/8.6/)
1. [Demo on tklib for chart plotting](https://github.com/tcltk/tklib/)
1. [Official tklib doc](https://core.tcl.tk/tklib/doc/trunk/embedded/www/tklib/files/modules/plotchart/plotchart.html)
    - On configuring the y-axis label format with percentage sign
