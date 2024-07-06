# Atari 2600 Template

This repository is just a simple quick-start for Atari 2600
development using [ld65](https://cc65.github.io/doc/ca65.html)
assembler, [ld65](https://cc65.github.io/doc/ld65.html) linker and the
[Stella](https://stella-emu.github.io/) emulator.

Assembling the target binary is just a matter of running `make`. We
also provide a `make run` target which merely runs the resulting
binary with the emulator and a `make debug` target which passes the
`-debug` flag to the emulator.

Note that we also rely on [GNU
awk](https://www.gnu.org/software/gawk/manual/gawk.html) to convert
`ca65`'s symbol file into a `dasm`-compatible version which `stella`
can understand.
