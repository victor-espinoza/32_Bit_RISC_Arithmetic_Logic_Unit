# Lab_2-_ALU
Project Overview:  
Arithmetic-Logic Unit designed using Verilog.  
  
The purpose of this lab was to create an Arithmetic Logic Unit (ALU). The ALU basically contains all of the underlying logic behind the instructions that I was required to implement for this project. Since there are no clock inputs for the ALU, this means that all of the operations performed within the ALU are combinational. Combinational logic is defined as performing arithmetic operations on bits of data (bitwise logic) and 0/1 logic (True/false logic).   
  
The fact that the ALU was using combinational logic also meant that I needed to use blocking assignments instead of non-blocking assignments within my always block. The different instructions that were implemented into my ALU were no operation (nop), add, add unsigned (addu), subtract (sub), subtract unsigned (subu), bitwise and, bitwise or, bitwise xor, bitwise nor, set to 1 if less than signed (slt), set to 1 if less than unsigned (sltu), add immediate (addi), add unsigned immediate (addiu), store to 1 if less than immediate (slti), store to 1 if less than unsigned immediate (sltiu), bitwise and immediate (andi), bitwise or immediate (ori), and bitwise xor immediate (xori).
  
Here is the block diagram for this project:  
![ScreenShot](https://cloud.githubusercontent.com/assets/14812721/24939441/2ba32972-1ef2-11e7-90f3-86f13da36fe5.jpg)  
  
Dependencies:   
This project was created using the Xilinx ISE Project Navigator Version: 14.7.  

Project Verification:   
This project was verified using the ALU_tb module.    
  
For my test bench, after declaring all of the inputs, outputs, and local variables and instantiating the ALU file being tested, I first initialized all of my inputs to zero. After that, I then enter a for loop that lets me test each of the 18 individual instructions to verify their correctness.  
  
In the test bench, I came up with a series of three different test cases for each instruction in order test how the instructions handled different values. This helped me to verify that the instructions were working correctly under different circumstances.  
  
Thanks to the professor's test bench example, I was able to generate a test bench that is self checking, meaning that it knows the desired answer for each test case and displays the appropriate messages to let me know if an error occurred while testing the desired instruction. This made it alot easier to verify the correctness of my ALU module because humans often make many errors when trying to verify their work, and creating an automated message that lets the person testing the module know whether the instruction passed all of its test cases or not is way more efficient that going through the problems by hand every time you want to verify a module.   
