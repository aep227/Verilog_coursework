`timescale 1ns/1ns

module tb_arith();

    reg CLK, reset;
    reg [31:0] opA, opB;
    reg [63:0] result;
    reg [1:0] module_select;
    wire DUT_out;

    //Arithemetic module under test goes here
    




    //Result register. Stores result of arithmetic module. Used to determine correct function
    always@(posedge CLK or negedge reset) begin
        if(reset)
            result <= 64'd0;
        else
            result <= DUT_out;
    end

    always begin
        CLK = 1'b0;
        #100;
        CLK = 1'b1;
        #100;
    end

    initial begin
        reset = 1'b1;
        opA = 32'd0;
        opB = 32'd0;
        #100;
        reset = 1'b0;
        // #100;
        // opA = 32'd0;
        // opB = 32'd0;
    end


endmodule