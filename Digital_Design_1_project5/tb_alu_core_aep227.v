/*
    Filename:    tb_alu_core_aep227.v
    Author:      Addison Powell
    Date:        December 8, 2019
    Version:     1
    Description: A testbench for confirming some basic functions
                 of the alu_core module
*/

`timescale 1ns/1ns

module tb_alu_core_aep227();
    reg            clock, reset, enter;//Active low reset
    reg     [3:0]  control;
    reg     [7:0]  data_in;
    wire           fin;
    wire    [15:0] alu_out;
    wire     [7:0] opA2, opB2, op_out2;

    //This commented out version was used to confirm that the correct values were being read into the correct registers
    // alu_core_aep227 DUT(clock, reset, enter, control, data_in, fin, alu_out, op_out2, opA2, opB2);
    alu_core_aep227 DUT(clock, reset, enter, control, data_in, fin, alu_out);

    always begin
        #10;
        clock = ~clock;
    end

    initial begin
        clock = 1'b0;
        reset = 1'b1;
        control = 4'b0000;
        data_in = 8'd0;
        #3;
        reset = 1'b0;
        #3;
        reset = 1'b1;
        data_in = 8'b00000000; //AND ID. ID = 7383 = 0111 0011 1000 0011
        control = 4'b0001;
        #5;//Opcode loaded into opcode register
        data_in = 8'b11111111;//Operand A
        control = 4'b0010;
        #20;//Loaded into register A
        data_in = 8'b00000011;//Operand B
        control = 4'b0100;
        #40;//Loaded into register B. alu_out should update immediately to 0111 0011 0000 0011

        data_in = 8'b00000001; //NAND
        control = 4'b0001;
        #20;//Opcode loaded into opcode register
        data_in = 8'b10010100;//Operand A
        control = 4'b0010;
        #20;//Loaded into register A
        data_in = 8'b10100110;//Operand B
        control = 4'b0100;
        #40;//Loaded into register B. alu_out should update immediately to 0000 0000 0111 1011

        data_in = 8'b00000010; //NOR
        control = 4'b0001;
        #20;//Opcode loaded into opcode register
        data_in = 8'b10110101;//Operand A
        control = 4'b0010;
        #20;//Loaded into register A
        data_in = 8'b00100101;//Operand B
        control = 4'b0100;
        #40;//Loaded into register B. alu_out should update immediately to 0000 0000 0100 1010

        data_in = 8'b00000101; //Add
        control = 4'b0001;
        #20;//Opcode loaded into opcode register
        data_in = 8'b01011100;//Operand A
        control = 4'b0010;
        #20;//Loaded into register A
        data_in = 8'b00010101;//Operand B
        control = 4'b0100;
        #40;//Loaded into register B. alu_out should update immediately to 0000 0000 0111 0001

    end

endmodule