# C-Compiler


I have implemented a C compiler using Flex and Bison as tokenizer and parser. This compiler gets a C language program file as input and provides a MIPS assembly output file. You can also run MIPS output file using QtSpim simulator. 

## Usage guide

### Requirements
* Flex
* Bison 

Flex and Bison are tools for building programs that handle structured input. 
They were originally tools for building compilers, but they have proven to be useful in many other areas.

You can get and install Flex & Bison tools using the below commands:
```
sudo apt-get update
sudo apt-get install flex
sudo apt-get install bison
```

### Related Links
* [Unix Text Processing Tools](https://web.iitd.ac.in/~sumeet/flex__bison.pdf)
* [What are Flex and Bison?](https://aquamentus.com/flex_bison.html)
* [Introducing Flex and Bison](https://www.oreilly.com/library/view/flex-bison/9780596805418/ch01.html)
* [Download QtSpim Simulator](http://spimsimulator.sourceforge.net/)

### Step 1: Download tokenizer.l & parser.y Files

### Step 2: Compile & Run Files
```
flex tokenizer.l
bison -d parser.y
gcc parser.tab.c lex.yy.c -o compiler
```

### Step 3: Compile Your C Program Using My Compiler
Finally, you can compile your C program using the below command:

```
./compiler input.c output.asm
```

<!-- 
### Step 3: Modify input.txt File 
You may want to modify input.txt file based on your C program.
consider in this compiler we support these structures :
* int data type
* variable declaration & definition
* function definition (functions having void or int output data type)
* while
* if 
* function call
* array
* global variables
* scope checking 
* 
Finally, run `./script.sh` file. 
-->
