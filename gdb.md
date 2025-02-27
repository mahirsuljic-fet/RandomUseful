### [GDB reference](https://visualgdb.com/gdbreference/commands/)

## Kontrola toka programa

### Breakpoint (zaustavi izvrsenje programa na LABEL, npr. ime funkcije kao main ili slicno)
`break LABEL`\
`b LABEL`       (skracenica)

### Continue (nastavi izvrsenje programa (do kraja ili do sljedeceg breakpoint-a))
`continue` \
`c`             (skracenica)

### Next Instruction (izvrsi narednu instrukciju)
`ni`


## LAYOUTS

### Source code
`layout src`

### Registers
`layout regs` \
`layout r`      (skracenica)


## Print

https://visualgdb.com/gdbreference/commands/print

### FORMATI
o - octal \
x - hexadecimal \
u - unsigned decimal \
t - binary \
f - floating point \
a - address \
c - char \
s - string

### Print register
`print /FORMAT $GP`

Primjer:
`print /x $a0` \
`print $a0`     (moze se izostaviti, koristi cjelobrojni format)
