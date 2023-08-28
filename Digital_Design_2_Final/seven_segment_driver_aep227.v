/*
Filename:    seven_segment_driver_aep227.v
Author:      Addison Powell
Date:        October 23, 2019
Version:     1
Description: A simple 7-segment driver for the DE1-SoC FPGA
*/

module seven_segment_driver_aep227(hex_digit, hex_display);
   input  [3:0] hex_digit; //Unsigned binary value
   output [6:0] hex_display;
   reg	  [6:0] hex_display;

    always@(hex_digit) begin
        case(hex_digit)
            4'd0: hex_display = 7'b1000000;
            4'd1: hex_display = 7'b1111001;
            4'd2: hex_display = 7'b0100100;
            4'd3: hex_display = 7'b0110000;
            4'd4: hex_display = 7'b0011001;
            4'd5: hex_display = 7'b0010010;
            4'd6: hex_display = 7'b0000010;
            4'd7: hex_display = 7'b1111000;
            4'd8: hex_display = 7'b0000000;
            4'd9: hex_display = 7'b0010000;
            4'd10: hex_display = 7'b0001000;
            4'd11: hex_display = 7'b0000011;
            4'd12: hex_display = 7'b1000110;
            4'd13: hex_display = 7'b0100001;
            4'd14: hex_display = 7'b0000110;
            4'd15: hex_display = 7'b0001110;
            default: hex_display = 7'bxxxxxxx;
        endcase
    end

endmodule