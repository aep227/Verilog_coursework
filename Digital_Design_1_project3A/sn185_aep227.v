/*
    Filename:    sn185_aep227.v
    Author:      Addison Powell
    Date:        October 14, 2019
    Version:     1
    Description: A behavioral implementation of the SN74185 decoder
                 It takes a 6-bit binary input and outputs a 6-bit BCD code
*/

`timescale 1ns/100ps

module sn185_aep227(g_n, bin_in, bcd_out); 
   input        g_n; 
   input  [5:0] bin_in; 
   output [5:0] bcd_out;
   reg    [5:0] bcd_out;


      always@(bin_in or g_n) begin
    if(g_n == 1'b0) begin
        case(bin_in)
            6'b000000: bcd_out = 6'b000000;
            6'b000001: bcd_out = 6'b000001;
            6'b000010: bcd_out = 6'b000010;
            6'b000011: bcd_out = 6'b000011;
            6'b000100: bcd_out = 6'b000100;
            6'b000101: bcd_out = 6'b000101;
            6'b000110: bcd_out = 6'b000110;
            6'b000111: bcd_out = 6'b000111;
            6'b001000: bcd_out = 6'b001000;
            6'b001001: bcd_out = 6'b001001;
            6'b001010: bcd_out = 6'b010000;
            6'b001011: bcd_out = 6'b010001;
            6'b001100: bcd_out = 6'b010010;
            6'b001101: bcd_out = 6'b010011;
            6'b001110: bcd_out = 6'b010100;
            6'b001111: bcd_out = 6'b010101;
            6'b010000: bcd_out = 6'b010110;
            6'b010001: bcd_out = 6'b010111;
            6'b010010: bcd_out = 6'b011000;
            6'b010011: bcd_out = 6'b011001;
            6'b010100: bcd_out = 6'b100000;
            6'b010101: bcd_out = 6'b100001;
            6'b010110: bcd_out = 6'b100010;
            6'b010111: bcd_out = 6'b100011;
            6'b011000: bcd_out = 6'b100100;
            6'b011001: bcd_out = 6'b100101;
            6'b011010: bcd_out = 6'b100110;
            6'b011011: bcd_out = 6'b100111;
            6'b011100: bcd_out = 6'b101000;
            6'b011101: bcd_out = 6'b101001;
            6'b011110: bcd_out = 6'b110000;
            6'b011111: bcd_out = 6'b110001;
            6'b100000: bcd_out = 6'b110010;
            6'b100001: bcd_out = 6'b110011;
            6'b100010: bcd_out = 6'b110100;
            6'b100011: bcd_out = 6'b110101;
            6'b100100: bcd_out = 6'b110110;
            6'b100101: bcd_out = 6'b110111;
            6'b100110: bcd_out = 6'b111000;
            6'b100111: bcd_out = 6'b111001;
            default:   bcd_out = 6'bxxxxxx;
            // default:   bcd_out = 6'b111110;
        endcase
    end
    else begin
        bcd_out = 6'b111111;
    end
   end

endmodule
