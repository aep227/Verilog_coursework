/*
    Filename:    symbol_driver_aep227.v
    Author:      Addison Powell
    Date:        October 23, 2019
    Version:     1
    Description: This module outputs a symbol depending on the select bit
                 and outputs the corresponding 7-bit code for an active-low
                 7-segment display.
                 When select is 0, the output is a lowercase b for binary
                 When select is 1, the output is a lowercase d for decimal
*/

module symbol_driver_aep227(select, hex_driver[6:0]);
  input        select; //0 = binary, 1 = decimal
  output [6:0] hex_driver;

      always@(select) begin
        case(select)
            1'b0: hex_driver = 7'b1100000;// "b"
            1'b1: hex_driver = 7'b1000010;// "d"
            default: hex_driver = 7'bxxxxxxx;
        endcase
    end

endmodule