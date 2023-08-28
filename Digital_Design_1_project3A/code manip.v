/*
    Filename:    dual_converter_aep227.v
    Author:      Addison Powell
    Date:        October 23, 2019
    Version:     1
    Description: A module that uses a select bit to determine whether out not to output
                 a 6-bit value as a binary value or as a Binary Coded Decimal value.
                 This is done with 2 decoders and a procedural 2-to-1 mux.
*/

module dual_converter_aep227(conv_sel, conv_in, conv_out);
  input        conv_sel;// 0 = binary, 1 = BCD
  input  [5:0] conv_in;
  output [5:0] conv_out;
  reg    [5:0] conv_out;
  wire   [5:0] dec_184_out;
  wire   [5:0] dec_185_out;

  sn184_aep227 dec_184(1'b0, conv_in, dec_184_out);//outputs binary
  sn185_aep227 dec_185(1'b0, conv_in, dec_185_out);//outputs BCD

  always@(conv_sel or dec_185_out or dec_184_out) begin
        if(~conv_sel)
            conv_out = dec_185_out;
        else if(conv_sel)
            conv_out = dec_184_out;
        else
            conv_out = 6'bxxxxxx;
  end

endmodule