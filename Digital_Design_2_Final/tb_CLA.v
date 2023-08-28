// Filename:    tb_CLA.v
// Author:      Addison Powell
// Date:        May 5, 2020
// Version:     1
// Description: Test bench for the 32-bit Ripple Carry Adder
//              Used to determine maximum prop delay/maximum clock speed

`timescale 1ns/1ns

module tb_CLA();

    reg         CLK, reset, value;
    reg  [31:0] opA, opB;
    wire [63:0] result;

    CLA DUT(opA, opB, result);

    //Basic function test
    // initial begin
    //     opA = 32'd0;
    //     opB = 32'd0;
    //     #100;
    //     opA = 32'd5;
    //     opB = 32'd10;
    //     #100;
    //     opA = 32'd23;
    //     opB = 32'd7;
    //     #100;
    //     opA = 32'd4294967295;
    //     opB = 32'd4294967295;
    //     #100;
    // end

    //Max clock speed test
    always begin //clock offset, but posedge every 21ns
        CLK = 1'b0;
        #11;
        CLK = 1'b1;
        #10;
    end

    always@(posedge CLK or posedge reset) begin
        if(reset) begin
            opA <= 32'd0;
            opB <= 32'd0;
            value <= 1'b0;
        end
        else if(~value) begin
            opA <= 32'hFFFFFFFF;
            opB <= 32'hFFFFFFFF;
            value <= ~value;
        end
        else if(value) begin
            opA <= 32'd0;
            opB <= 32'd0;
            value <= ~value;
        end
    end

    initial begin
        reset = 1'b0;
        #20;
        reset = 1'b1;
        #20;
        reset = 1'b0;
    end

endmodule