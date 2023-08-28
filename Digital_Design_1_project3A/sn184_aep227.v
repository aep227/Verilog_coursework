/*
    Filename:    sn184_aep227.v
    Author:      Addison Powell
    Date:        October 14, 2019
    Version:     1
    Description: A behavioral implementation of the SN74184 decoder
                 It takes a 6-bit BCD code input and outputs a 6-bit binary number
*/

`timescale 1ns/100ps

module sn184_aep227(g_n, bcd_in, bin_out); 
   input        g_n; 
   input  [5:0] bcd_in; 
   output [5:0] bin_out;
   reg    [5:0] bin_out;

   always@(bcd_in or g_n) begin
    if(g_n == 1'b0) begin
        case(bcd_in)
            6'b000000: bin_out = 6'b000000;
            6'b000001: bin_out = 6'b000001;
            6'b000010: bin_out = 6'b000010;
            6'b000011: bin_out = 6'b000011;
            6'b000100: bin_out = 6'b000100;
            6'b000101: bin_out = 6'b000101;
            6'b000110: bin_out = 6'b000110;
            6'b000111: bin_out = 6'b000111;
            6'b001000: bin_out = 6'b001000;
            6'b001001: bin_out = 6'b001001;
            6'b010000: bin_out = 6'b001010;
            6'b010001: bin_out = 6'b001011;
            6'b010010: bin_out = 6'b001100;
            6'b010011: bin_out = 6'b001101;
            6'b010100: bin_out = 6'b001110;
            6'b010101: bin_out = 6'b001111;
            6'b010110: bin_out = 6'b010000;
            6'b010111: bin_out = 6'b010001;
            6'b011000: bin_out = 6'b010010;
            6'b011001: bin_out = 6'b010011;
            6'b100000: bin_out = 6'b010100;
            6'b100001: bin_out = 6'b010101;
            6'b100010: bin_out = 6'b010110;
            6'b100011: bin_out = 6'b010111;
            6'b100100: bin_out = 6'b011000;
            6'b100101: bin_out = 6'b011001;
            6'b100110: bin_out = 6'b011010;
            6'b100111: bin_out = 6'b011011;
            6'b101000: bin_out = 6'b011100;
            6'b101001: bin_out = 6'b011101;
            6'b110000: bin_out = 6'b011110;
            6'b110001: bin_out = 6'b011111;
            6'b110010: bin_out = 6'b100000;
            6'b110011: bin_out = 6'b100001;
            6'b110100: bin_out = 6'b100010;
            6'b110101: bin_out = 6'b100011;
            6'b110110: bin_out = 6'b100100;
            6'b110111: bin_out = 6'b100101;
            6'b111000: bin_out = 6'b100110;
            6'b111001: bin_out = 6'b100111;
            default:   bin_out = 6'bxxxxxx;
            // default:   bin_out = 6'b111110;
        endcase
    end
    else begin
        bin_out = 6'b111111;
    end
   end

endmodule
