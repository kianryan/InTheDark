## In The Dark

A rogue-like survival game for CP/M, DOS and modern systems.

![](rogue.gif )



## Download

Downloads for the following systems are available in Releases:
* ITDARK80.COM - CP/M with ANSI Terminal (developed for RC2014).
* ITDARK7.EXE - 16 Bit DOS (tested in DOS Box).
* ITDARKFP.EXE - Modern Windows executable.

## Playing

"In the Dark" in a never-ending, generative dungeon crawler, filled with light 
sources `#`, treasure `$` and Grue `"`.  Progress from dungeon to dungeon by 
exploring each room and collecting treasure.  The Grue will hide from the 
light, but when the lights go out, they're coming for you...

## Controls

**wasd** : Movement  
**q** : Quit

## Compiling

In The Dark is built on multiple generations of Turbo Pascal and Free Pascal. 
Each binary is compiled on its respective system.

**ITDARK80.COM** - Turbo Pascal 3.0 for CP/M.  Built on a RC2014 Pro.  
**ITDARK7.COM** - Turbo Pascal 7.0 for DOS.  Built using DOSBOX.  
**ITDARKFP.EXE** - Free Pascal Compiler.  Built on Windows 10.

Development builds were performed using Free Pascal, Windows Subsytem for Linux and 
Ubuntu 20.04.  You can build a Linux release with:

```
apt install lazarus
fpc itdarktp.pas
```

## License

Copyright 2022 Kian Ryan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.