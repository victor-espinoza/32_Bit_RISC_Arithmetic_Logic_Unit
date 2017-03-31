`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// 
// Author:        Victor Espinoza
// Email:         victor.alfonso94@gmail.com
// Project #:     Project 2 - Arithmetic Logic Unit (ALU)
// Course:        CECS 440
// Create Date:   1:29:37 2/21/2015
//
// Module Name:   ALU_tb
// File Name:     ALU_tb.v
//
// Description:   This module creates a test bench used to test each individual
//                instruction within the ALU and make sure that it is working
//                properly. The instructions inside of the ALU consist of nop,
//                add, addu, sub, subu, and, or, xor, nor, slt, sltu, addi, 
//                addiu, slti, sltiu, andi, ori, and xori. In the test bench,
//                I come up with a series of three different test cases for 
//                each instruction in order to verify that the instructions
//                work correctly under different circumstances. Thanks to the 
//                professor's testbench example, I was able to generate a test 
//                bench that is self checking, meaning that it knows the desired 
//                answer for each test case and displays the appropriate  
//                messages to let me know if an error occurred while testing the 
//                desired instruction. This made it alot easier to verify the
//                correctness of my ALU module because a message was displayed 
//                that let me know whether the instruction passed all of its 
//                test cases or not.
//                  
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module ALU_tb;

   // Inputs
   wire [4:0]  sel;
   wire [31:0] A;
   wire [31:0] B;

   // Outputs
   wire [31:0] Y;
   wire        ZF;

   // Variables
   integer i,j,k;

   assign A   = j;
   assign B   = k;
   assign sel = i;

   // Instantiate the Unit Under Test (UUT)
   //module ALU(sel, A, B, ZF, Y);
   ALU uut (
   .sel(sel), 
   .A(A), 
   .B(B), 
   .ZF(ZF), 
   .Y(Y)
   );

   initial begin
      // Initialize Inputs
      i = 0;
      j = 0;
      k = 0;

      // Add stimulus here: sel = i, A = j, B = k
      for (i=0; i<18; i=i+1)

         case(i)
            5'h0: begin // nop
               $display("NOP");
               j = 1234;
               k = 5678;
               #100 if (Y!=32'h0) 
                  $display("Error on NOP. sb: 0x00000000 is: %h",Y);
            end

            5'h1: begin // Add Signed
               $display("Add");
               //numbers less than 0000_FFFF addition
               j = 1200;
               k = 6400;
               #100 if (Y!=7600) 
                  $display("Error on Add. A: %h B: %h sb: 7600 is:%h", A, B, Y);
               //negative number addition
               j = -250;
               k = -750;
               #100 if (Y!=32'hFFFFFC18) 
                  $display("Error on Add. A: %h B: %h sb: 32'hFFFFFC18 is: %h", 
                   A, B, Y);
               //negative and positive number addition
               j = -1024;
               k = 2048;
               #100 if (Y!=1024) 
                  $display("Error on Add. A: %h B: %h sb: 1024 is: %h", 
                   A, B, Y);
            end

            5'h2: begin // Add Unsigned
               $display("Add Unsigned");
               //numbers bigger than 0000_FFFF addition
               j = 123456;
               k = 678910;
               #100 if (Y!=32'H000C3E3E) 
                  $display("Error on Addu. A: %h B: %h sb: 32'H000C3E3E is: %h", 
                   A, B, Y);
               //numbers on different sides of the spectrum
               j = 32'h7FFFFFFF;
               k = 32'h00000012;
               #100 if (Y!=32'H80000011) 
                  $display("Error on Addu. A: %h B: %h sb: 32'H80000011 is: %h", 
                   A, B, Y);
               //overflow example
               j = 32'hFFFFFFF0;
               k = 32'h000000FF;
               #100 if (Y!=32'H000000EF) 
                  $display("Error on Addu. A: %h B: %h sb: 32'H000000EF is: %h", 
                   A, B, Y);
            end

            5'h3: begin // Signed Subtract
               $display("Subtract");
               //causes a negative result
               j = 123456;
               k = 678910;
               #100 if (Y!=32'HFFF78642) 
                  $display("Error on Sub. A: %H B: %H sb: 32'HFFF78642 is: %H", 
                   A, B, Y);
               //causes a positive result
               j = 32'hFFFFFFFA;
               k = 32'hFFFFFFA5;
               #100 if (Y!=32'H00000055) 
                  $display("Error on Sub. A: %H B: %H sb: 32'H00000055 is: %H", 
                   A, B, Y);
               //causes a negative result
               j = 32'hFFFFFFF0;
               k = 32'h0000001B;
               #100 if (Y!=32'HFFFFFFD5) 
                  $display("Error on Sub. A: %H B: %H sb: 32'HFFFFFFD5 is: %H", 
                   A, B, Y);
            end

            5'h4: begin // Unsigned Subtract
               $display("Subtract Unsigned");
               //numbers greater than 0000_FFFF
               j = 32'HFFFFFFFF;
               k = 32'HAAAAAAAA;
               #100 if (Y!=32'H55555555) 
                  $display("Error on Subu. A: %H B: %H sb: 32'H55555555 is: %H", 
                   A, B, Y);
               //numbers close to each other
               j = 32'hFFFFFFFA;
               k = 32'hFFFFFF50;
               #100 if (Y!=32'H000000AA) 
                  $display("Error on Subu. A: %H B: %H sb: 32'H000000AA is: %H", 
                   A, B, Y);
               //numbers less than 0000_FFFF
               j = 32'h0000DDDD;
               k = 32'h00000123;
               #100 if (Y!=32'H0000DCBA) 
                  $display("Error on Subu. A: %H B: %H sb: 32'H0000DCBA is: %H", 
                   A, B, Y);
            end

            5'h5: begin // Bitwise AND
               $display("AND");
               //numbers have some bits in common
               j = 32'HFEDC64A4;
               k = 32'H0000161D;
               #100 if (Y!=32'H00000404) 
                  $display("Error on And. A: %H B: %H sb: 32'H00000404 is: %H", 
                   A, B, Y);
               //numbers have no bits in common
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H00000000) 
                  $display("Error on And. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
               //all numbers have same bits in common
               j = 32'hDDDDDDDD;
               k = 32'hAAAAAAAA;
               #100 if (Y!=32'H88888888) 
                  $display("Error on And. A: %H B: %H sb: 32'H88888888 is: %H", 
                   A, B, Y);
            end

            5'h6: begin // Bitwise OR
               $display("OR");
               //last 4 digits change
               j = 32'HFEDCBA98;
               k = 32'H00004567;
               #100 if (Y!=32'HFEDCFFFF) 
                  $display("Error on Or. A: %H B: %H sb: 32'HFEDCFFFF is: %H", 
                   A, B, Y);
               //most of digits change
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H77777777) 
                  $display("Error on Or. A: %H B: %H sb: 32'H77777777 is: %H", 
                   A, B, Y);
               //all of the digits change
               j = 32'h88888888;
               k = 32'h22222222;
               #100 if (Y!=32'HAAAAAAAA) 
                  $display("Error on Or. A: %H B: %H sb: 32'HAAAAAAAA is: %H", 
                   A, B, Y);
            end

            5'h7: begin // Bitwise XOR
               $display("XOR");
               //some bits are masked
               j = 32'HFEDCBA09;
               k = 32'H00001111;
               #100 if (Y!=32'HFEDCAB18) 
                  $display("Error on Xor. A: %H B: %H sb: 32'HFEDCAB18 is: %H", 
                   A, B, Y);
               //all bits are set
               j = 32'h88888888;
               k = 32'h77777777;
               #100 if (Y!=32'HFFFFFFFF) 
                  $display("Error on Xor. A: %H B: %H sb: 32'HFFFFFFFF is: %H", 
                   A, B, Y);
               //all bits are cleared
               j = 32'h55555555;
               k = 32'h55555555;
               #100 if (Y!=32'H00000000) 
                  $display("Error on Xor. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
            end

            5'h8: begin // Bitwise NOR
               $display("NOR");
               //two different ways to complement value; either nor it with 0 or 
               //with itself
               j = 32'HFEDCBA98;
               k = 32'H0000BA98;
               #100 if (Y!=32'H01234567) 
                  $display("Error on Nor. A: %H B: %H sb: 32'H01234567 is: %H", 
                   A, B, Y);
               //inputs result in a value of 88888888 because this bit is the 
               //only bit that is not set when performing a nor operation on 
               //these two inputs.
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H88888888) 
                  $display("Error on Nor. A: %H B: %H sb: 32'H88888888 is: %H", 
                   A, B, Y);
               //result is the complement of the inputs.
               j = 32'hAAAAAAAA;
               k = 32'hAAAAAAAA;
               #100 if (Y!=32'H55555555) 
                  $display("Error on Nor. A: %H B: %H sb: 32'H55555555 is: %H", 
                   A, B, Y);
            end

            5'h9: begin // Set to 1 if Less Than Signed
               $display("Set to 1 if < Signed");
               //test a negative value to make sure that it sets
               j = 32'H87654321;
               k = 32'H7FFFFFFF;
               #100 if (Y!=32'H00000001) 
                  $display("Error on Set<1. A: %H B: %H sb: 32'H00000001 is: %H", 
                   A, B, Y);
               //test a value that is bigger than the second register
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H00000000) 
                  $display("Error on Set<1. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
               //test a positive value that is smaller than the second register
               j = 32'h12345678;
               k = 32'h5A5A5A5A;
               #100 if (Y!=32'H00000001) 
                  $display("Error on Set<1. A: %H B: %H sb: 32'H00000001 is: %H", 
                   A, B, Y);
               //test a negative value that is smaller than the second register
               j = 32'hAAAAAAAA;
               k = 32'h81234567;
               #100 if (Y!=32'H00000001) 
                  $display("Error on Set<1. A: %H B: %H sb: 32'H00000001 is: %H", 
                   uut.Aint, uut.Bint, Y);
            end

            5'hA: begin // Set to 1 if Less Than Unsigned
               $display("Set to 1 if < unsigned");
               //Use the same test cases as the ones in the slt instruction to 
               //prove the difference between the slt and sltu instructions.
               //this value should be zero because 87654321 is bigger than 
               //7FFFFFFF because the value is unsigned.
               j = 32'H87654321;
               k = 32'H7FFFFFFF;
               #100 if (Y!=32'H00000000) $display(
                  "Error on Set<1 unsigned. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
               //j value is bigger than the second register, so Y should equal 0.
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H00000000) $display(
                  "Error on Set<1 unsigned. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
               //j value is smaller than the second register, so Y should be 1.
               j = 32'h12345678;
               k = 32'h5A5A5A5A;
               #100 if (Y!=32'H00000001) $display(
                  "Error on Set<1 unsigned. A: %H B: %H sb: 32'H00000001 is: %H", 
                   A, B, Y);
            end

            5'hB: begin // Add Immediate Signed
               $display("Add Immediate Signed");
               //Add register A with a 16 bit immediate value (6400).
               //The msb of k, 0, is sign extended to the upper 16 bits of the 
               //number and then the 16-bit immediate date is added to this to 
               //create our 32 bit B value.
               j = 1200;
               k = 6400;
               #100 if (Y!=7600) 

                  $display("Error on Addi. A: %h B: %h sb: 7600 is: %h", A, B, Y);
               //negative number addition. Only the lower 16  bits of the k value
               //are read into the B register. The msb of k, 1, is sign extended 
               //to the upper 16 bits of the number and then the 16-bit immediate 
               //date is added to this to create our 32 bit B value.
               j = -250;
               k = -750;
               #100 if (Y!=32'hFFFFFC18)
                  $display("Error on Addi. A: %h B: %h sb: 32'hFFFFFC18 is: %h", 
                   A, B, Y);
               //negative and positive number addition. Only the lower 16  bits of 
               //the k value are read into the B register. The msb of k, 0, is sign 
               //extended to the upper 16 bits of the number and then the 16-bit 
               //immediate date is added to this to create our 32 bit B value.
               j = -1024;
               k = 2048;
               #100 if (Y!=1024) 
                  $display("Error on Addi. A: %h B: %h sb: 1024 is: %h", A, B, Y);
            end

            5'hC: begin // Add Immediate Unsigned 
               $display("Add Immediate Unsigned");
               //For these values, only the lower 16 bits of the k value are read 
               //into register B. The upper 16 bits are set to all zeroes no matter 
               //what the value in the lower 16 bits, showing that the unsigned add 
               //immediate instruction is different from that of the signed  
               //immediate add instruction.
               //add the same number together. Note, we only read the lower 16 bits  
               //of the k value.
               j = 32'H12345678;
               k = 32'H12345678;
               #100 if (Y!=32'H1234ACF0) 
                  $display("Error on Addu. A: %h B: %h sb: 32'H1234ACF0 is: %h", 
                   A, B, Y);
               //add A register with a 16-bit value.
               j = 32'h7FFFFFFF;
               k = 32'h00000012;
               #100 if (Y!=32'H80000011) 
                  $display("Error on Addu. A: %h B: %h sb: 32'H80000011 is: %h", 
                   A, B, Y);
               //cause an overflow to occur, which causes the numbers to roll over 
               //and start count from the beginning (00000000). 
               j = 32'hFFFFFFF0;
               k = 32'h000000FF;
               #100 if (Y!=32'H000000EF) 
                  $display("Error on Addu. A: %h B: %h sb: 32'H000000EF is: %h", 
                   A, B, Y); 
            end 

            5'hD: begin // Set to 1 if Less Than Signed
               $display("Set to 1 if < Immediate Signed");
               //test a negative value to make sure that it sets
               //The msb of k, 1, is sign extended to the upper 16 bits of the 
               //number and then the 16-bit immediate date is added to this to 
               //create our 32 bit B value.
               j = 32'H87654321;
               k = 32'H7FFFFFFF;
               #100 if (Y!=32'H00000001) $display
                  ("Error on Set<1 Immediate. A: %H B: %H sb: 32'H00000001 is: %H", 
                   A, B, Y);
               //test a number bigger than B to make sure that y is set to 0.
               //The msb of k, 1, is sign extended to the upper 16 bits of the 
               //number and then the 16-bit immediate date is added to this to 
               //create our 32 bit B value. J, being a positive number, is bigger 
               //than k, which is interpreted as a negative number once it is sign 
               //extended. This makes the output 0.
               j = 32'h76543210;
               k = 32'h0123F567;
               #100 if (Y!=32'H00000000) $display
                  ("Error on Set<1 Immediate. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
               //test a positive value that is smaller than the immediate value
               //this sets Y equal to 1.
               j = 32'h00005678;
               k = 32'h23456789;
               #100 if (Y!=32'H00000001) $display
                  ("Error on Set<1 Immediate. A: %H B: %H sb: 32'H00000001 is: %H", 
                   A, B, Y);
            end

            5'hE: begin // Set to 1 if Less Than Immediate Unsigned
               $display("Set to 1 if < Immediate");
               //The upper 16 bits of k are set to zeros and then the 16-bit 
               //immediate date is added to this to create our 32 bit B value.
               //Compare a value that is larger than B, resulting in Y equaling 0.
               j = 32'H87654321;
               k = 32'H7FFFFFFF;
               #100 if (Y!=32'H00000000)
                  $display("Error on Set<1 immediate unsigned.",
                   " A: %H B: %H sb: 32'H00000000 is: %H", A, B, Y);
               //test a number smaller than k to make sure that Y equals 1.
               j = 32'h0000AAAA;
               k = 32'H0000FFFF;
               #100 if (Y!=32'H00000001) 
                  $display("Error on Set<1 immediate unsigned.",
                   " A: %H B: %H sb: 32'H00000001 is: %H", 
                   A, B, Y);
               //test another number smaller than k to make sure that Y equals 1.
               j = 32'h0000E678;
               k = 32'h0000F789;
               #100 if (Y!=32'H00000001) 
                  $display("Error on Set<1 immediate unsigned.",
                   " A: %H B: %H sb: 32'H00000001 is: %H", A, B, Y);
            end

            5'hF: begin // Bitwise AND Immediate
               $display("AND Immediate"); 
               //Since we are performing operations on the bits, we will use the 
               //unsigned representation of the immediate values. To do this, we 
               //set the upper 16 bits of k to zeros and then add the 16-bit 
               //immediate date to create the 32 bit B value.
               //numbers have some bits in common
               j = 32'HFEDC64A4;
               k = 32'H0000161D;
               #100 if (Y!=32'H00000404) 
                  $display("Error on Andi. A: %H B: %H sb: 32'H00000404 is: %H", 
                   A, B, Y);
               //numbers have no bits in common
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H00000000) 
                  $display("Error on Andi. A: %H B: %H sb: 32'H00000000 is: %H", 
                   A, B, Y);
               //all numbers have same bits in common
               j = 32'hDDDDDDDD;
               k = 32'hAAAAAAAA;
               #100 if (Y!=32'H00008888)  
                  $display("Error on Andi. A: %H B: %H sb: 32'H00008888 is: %H", 
                   A, B, Y);
            end

            5'h10: begin // Bitwise OR Immediate
               $display("OR Immediate"); 
               //Since we are performing operations on the bits, we will use the 
               //unsigned representation of the immediate values. To do this, we 
               //set the upper 16 bits of k to zeros and then add the 16-bit 
               //immediate date to create the 32 bit B value.
               //last 4 digits change
               j = 32'HFEDCBA98;
               k = 32'H00004567;
               #100 if (Y!=32'HFEDCFFFF) 
                  $display("Error on Ori. A: %H B: %H sb: 32'HFEDCFFFF is: %H", 
                   A, B, Y);
               //last 4 digits change
               j = 32'h76543210;
               k = 32'h01234567;
               #100 if (Y!=32'H76547777) 
                  $display("Error on Ori. A: %H B: %H sb: 32'H76547777 is: %H", 
                   A, B, Y);
               //nothing changes
               j = 32'h88888888;
               k = 32'hAAAA8888;
               #100 if (Y!=32'H88888888) 
                  $display("Error on Ori. A: %H B: %H sb: 32'H88888888 is: %H",
                   A, B, Y);
            end

            5'h11: begin // Bitwise XOR Immediate
               $display("XOR Immediate"); 
               //Since we are performing operations on the bits, we will use the 
               //unsigned representation of the immediate values. To do this, we 
               //set the upper 16 bits of k to zeros and then add the 16-bit 
               //immediate date to create the 32 bit B value.
               //some bits are masked
               j = 32'HFEDCBA09;
               k = 32'H00001111;
               #100 if (Y!=32'HFEDCAB18) 
                  $display("Error on Xori. A: %H B: %H sb: 32'HFEDCAB18 is: %H", 
                   A, B, Y);
               //all bits in last 4 digits are set
               j = 32'h88888888;
               k = 32'h77777777;
               #100 if (Y!=32'H8888FFFF) 
                  $display("Error on Xori. A: %H B: %H sb: 32'H8888FFFF is: %H", 
                   A, B, Y);
               //all bits are cleared
               j = 32'h55555555;
               k = 32'h55555555;
               #100 if (Y!=32'H55550000) 
                  $display("Error on XoriA: %H B: %H sb: 32'H55550000 is: %H", 
                   A, B, Y);
            end

            default: begin // nop for default operation
               $display("NOP"); 
               //do nothing for the no-op.
               j = 1234;
               k = 5678;
               #100 if (Y!=32'h0) $display("Error on NOP. sb: 0x00000000 is: %h",Y);
            end
         endcase
   end//for loop

endmodule
