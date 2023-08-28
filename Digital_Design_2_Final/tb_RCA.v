// Filename:    tb_RCA.v
// Author:      Addison Powell
// Date:        May 5, 2020
// Version:     1
// Description: Test bench for the 32-bit Ripple Carry Adder
//              Used to determine maximum prop delay/maximum clock speed

`timescale 1ns/1ns

module tb_RCA();

    reg         CLK, reset, value;
    reg  [31:0] opA, opB;
    wire [63:0] result;

    RCA DUT(opA, opB, result);

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

    //Max prop delay test
    //0+0 to "reset" -> max value + 1 -> 0+0
    // initial begin
    //     opA = 32'h00000000;
    //     opB = 32'h00000000;
    //     #100;
    //     opA = 32'hFFFFFFFF;
    //     opB = 32'h00000001;
    //     #300;
    //     opA = 32'h00000000;
    //     opB = 32'h00000000;
    //     #100;
    // end

    //Max clock speed test
    //Period of 204ns correctly works, period of 202ns does not
    always begin
        CLK = 1'b0;
        #102;
        CLK = 1'b1;
        #102;
    end

    always@(posedge CLK or posedge reset) begin
        if(reset) begin
            opA <= 32'd0;
            opB <= 32'd0;
            value <= 1'b0;
        end
        else if(~value) begin
            opA <= 32'hFFFFFFFF;
            opB <= 32'h00000001;
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