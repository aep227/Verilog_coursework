/*
    Filename:    tb_project5_aep227.v
    Author:      Addison Powell
    Date:        December 8, 2019
    Version:     1
    Description: A testbench for the top level project 5 module
*/

`timescale 1ns/1ns

module tb_project5_aep227();
    reg           CLOCK_50;
    reg     [1:0] KEY;//Key0 is reset, Key1 is enter
    reg     [7:0] SW;//Data input

    wire    [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;//7-segment displays
    wire    [9:0] LED;
    
    //Function unit register outputs. Used in debugging
    wire     [7:0] opA2, opB2; 
	wire     [3:0] op_out2;
    wire     [2:0] state;

    wire    enter;
    wire [3:0] control;

    //This commented out version was used to confirm that the correct values were being read into the correct registers
    // project5Top DUT_debug(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED, opA2, opB2, op_out2, state, enter, control);

    project5Top DUT(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);

    always begin
        #10;
        CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        CLOCK_50 = 1'b0;
        KEY = 2'b11;
        SW = 8'b00000000;
        #3;
        KEY[0] = 1'b0;
        #3;
        KEY[0] = 1'b1;//Resets the system
        #80;//Should remain in LOAD_OP state

        // //AND ID test
        // SW = 8'b00000000;//And ID command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b11111111;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b11111111;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to the ID number (0x7383)


        // //NAND test
        // SW = 8'b00000001;//NAND command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b10010100;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b10100110;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x007B


        // //NOR test
        // SW = 8'b00000010;//NOR command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b10110101;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00100101;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x004A


        // //XOR test
        // SW = 8'b00000011;//XOR command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b01001011;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b10110110;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x00FD


        // //1's complement test
        // SW = 8'b00000100;//1's complement command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000101;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;//Hex display should correctly update after only 2 presses since there is no operand B
        // //HEX[3:0] should change to 0x00FA


        // //Addition test
        // SW = 8'b00000101;//Add command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b01011100;//Operand A = 3
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00010101;//Operand B = 2
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x0071


        // //Subtract test
        // SW = 8'b00000110;//Subtract command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000111;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000011;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x0004


        // //Negate test
        // SW = 8'b00000111;//Negate command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00001000;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0xFFF8


        // //Arithmetic Shift Left
        // SW = 8'b00001000;//Arith Shift Left command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000001;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000100;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x0010


        // //Arithmetic Shift Right
        // SW = 8'b00001001;//Arith Shift Right command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00010000;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000011;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x0002


        // //Rotate Left
        // SW = 8'b00001010;//Rotate Left command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b11010111;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00001010;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x5C03


        // //Rotate Right
        // SW = 8'b00001011;//Rotate Right command
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b10110101;//Operand A
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // SW = 8'b00000111;//Operand B
        // #2;
        // KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        // #80;
        // //HEX[3:0] should change to 0x6A01


        //Multiply Test of 16*3
        SW = 8'b00001100;//Multiply command
        #2;
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;

        SW = 8'b01100110;//Operand A
        #2;
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;

        SW = 8'b00101101;//Operand B
        #2;
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x002D
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x3316
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x198B
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x3FC5
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x52E2
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x2971
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x47B8
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x23DC
        KEY[1] = 1'b0; #20; KEY[1] = 1'b1; //Enter pressed
        #80;
        //HEX[3:0] should change to 0x11EE

    end

endmodule