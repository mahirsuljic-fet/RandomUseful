==============
| MIPS I GDB |
==============

# Kompajliranje programa
ecc -target mips32r2el-linux -g IME_ASSEMBLY_FAJLA -o IME_OUTPUT_FAJLA

# Pokretanje programa
qemu-mipsel -g 1234 IME_OUTPUT_FAJLA&

# Pokretanje GDB-a
gdb-multiarch -q IME_OUTPUT_FAJLA

# Povezivanje GDB-a i programa
target remote :1234

# Napomena: 
# 1234 je broj porta, moze i neki drugi broj pod uslovom da ni jedan drugi proces ne koristi dati port, 1234 je izabrano zbog jednostavnosti.

===========
| LOGISIM |
===========

java -jar /opt/logisim/logisim-evolution.jar&

# LOGISIM HOST ERROR (izvrsiti prije pokretanje containera)
xhost +
