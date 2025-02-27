# General

``` bash
alias update-a='sudo apt update && sudo apt upgrade && sudo apt autoremove'
```
``` bash
alias rm-noex='find . -type f ! -name "*.?*" -delete'
```
``` bash
alias sd='shutdown now'
```
``` bash
alias brc='. ~/.bashrc'
```
``` bash
alias brc-edit='nvim ~/.bashrc && brc'
```

``` bash
find-noerr ()
{
  find $1 -iname $2 2> >(grep -v 'Permission denied' >&2)
}
```

``` bash
md ()
{
  mkdir $1
  cd $1
}
```


# Clang-format

``` bash
alias clang-format-all='find . -iname "*.cpp" -o -iname "*.hpp" -o -iname "*.h" | xargs clang-format -i'
```

``` bash
clang-format-rec ()
{
 find "$@" -iname "*.cpp" -o -iname "*.hpp" -o -iname "*.h" | xargs clang-format -i
}
```


# Container

``` bash
alias sc='sudo start_container'
```
``` bash
alias xsc='xhost + && sc'
```
``` bash
alias sclogisim='java -jar /opt/logisim/logisim-evolution.jar&'
```

## Auto script load and tmux
``` bash
if [ -d "/opt1/" ]; then
  export TERM=xterm-256color
  source /opt1/script.sh
  [ -z "$TMUX" ] && exec tmux
fi
```


# c++

``` bash
alias crrall='g++ *.cpp -o cpptemp && ./cpptemp && rm cpptemp'
```
``` bash
alias crrall-w='g++ -w *.cpp -o cpptemp && ./cpptemp && rm cpptemp'
```
``` bash
alias crrall-a='g++ -fsanitize=address *.cpp -o cpptemp && ./cpptemp && rm cpptemp'
```

``` bash
crr-a ()
{
 g++ -fsanitize=address "$@" -o cpptemp && ./cpptemp && rm cpptemp   
}
```

``` bash
crr-w ()
{
 g++ -w "$@" -o cpptemp && ./cpptemp && rm cpptemp   
}
```

``` bash
crr ()
{
 g++ "$@" -o cpptemp && ./cpptemp && rm cpptemp   
}
```

``` bash
ccrr-a ()
{
 clear && g++ -fsanitize=address "$@" -o cpptemp && ./cpptemp && rm cpptemp   
}
```

``` bash
ccrr-w ()
{
 clear && g++ -w "$@" -o cpptemp && ./cpptemp && rm cpptemp   
}
```

``` bash
ccrr ()
{
 clear && g++ "$@" -o cpptemp && ./cpptemp && rm cpptemp   
}
```


# Arhitektura racunara (MIPS)

### MIPS compile

``` bash
alias ecrrall='ecc -target mipsel-linux-eng *.c -o cpptemp && ./cpptemp && rm cpptemp'
```
``` bash
alias eccrall='ecc++ -target mips32r2el-linux -O0 -g *.cpp *.s -o ecctemp && qemu-mipsel ecctemp && rm ecctemp'
```
``` bash
alias mipsecc='ecc -target mips32r2el-linux'
```

``` bash
mcrr ()
{
 mipsecc "$@" -o asmtemp && qemu-mipsel asmtemp && rm asmtemp   
}
```

``` bash
mccrr ()
{
 clear && mipsecc "$@" -o asmtemp && qemu-mipsel asmtemp && rm asmtemp   
}
```


### MIPS debug

ecc-full kompajlira program i pokrece debuger

Koristi se kao: \
`ecc-full FILES` \
npr: `ecc-full test.s test.c`

Default port je 1234, ukoliko je potreban neki drugi prosljedjuje se kao prvi argument komande.

Koristi se kao: \
`ecc-full PORT_NUMBER FILES` \
npr: `ecc-full 9999 test.s test.c`

``` bash
ecc-full ()
{
  regex='^[0-9]+$'
  if [ $# -eq 0 ]; then
    echo "Empty argument!"
  elif ! [[ $1 =~ $regex ]] ; then
    ecc -target mips32r2el-linux -g "$@" -o asmtemp
    qemu-mipsel -g 1234 asmtemp&
    gdb-multiarch -q asmtemp 
    rm asmtemp
  else
    ecc -target mips32r2el-linux -g "$@" -o asmtemp
    qemu-mipsel -g $1 asmtemp&
    gdb-multiarch -q asmtemp 
    rm asmtemp
  fi
}
```


### MIPS disassembly

``` bash
mcl ()
{
  if [[ $# -eq 1 ]]; then
    mipsecc $1 -c -o asmtemp.o 
    ecc-objdump -s asmtemp.o 
    rm asmtemp.o
  elif [[ $# -eq 2 ]]; then
    mipsecc $1 -c -o asmtemp.o 
    ecc-objdump -s -j $2 asmtemp.o 
    rm asmtemp.o
  else
    echo "Invalid number of arguments"
  fi
}
```

``` bash
mcll ()
{
  if [[ $# -eq 1 ]]; then
    mipsecc $1 -o asmtemp
    ecc-objdump -s asmtemp
    rm asmtemp
  elif [[ $# -eq 2 ]]; then
    mipsecc $1 -o asmtemp
    ecc-objdump -s -j $2 asmtemp
    rm asmtemp
  else
    echo "Invalid number of arguments"
  fi
}
```


# Funkcionalno programiranje (F#)

### Compile and run f# file or project
Usage: \
`fsrun FILENAME.fsx` \
`fsrun FILENAME.fs` \
`fsrun` 

``` bash
fsrun ()
{
  if [ $# -eq 0 ]; then
    dotnet run
  elif [ $# -eq 1 ]; then
    if [[ "$1" == *.fsx ]]; then
      dotnet fsi $1
    elif [[ "$1" == *.fs ]]; then
      if [ ! -f ./fstemp.fsx ]; then
        cp $1 FSTemp.fsx
        dotnet fsi FSTemp.fsx
        rm FSTemp.fsx
      else
        dotnet fsi < $1
      fi
    else
      echo "Wrong file type!"
    fi
  else
    echo "Too many arguments!"
  fi
}
```

### Make new F# project
Usage: `fsnew PROJECTNAME`

``` bash
fsnew ()
{
  if [ $# -eq 0 ]; then
    echo "Empty argument!"
  elif [ $# -eq 1 ]; then
    dotnet new console -lang "F#" -o $1
  else
    echo "Too many arguments!"
  fi
}
```
