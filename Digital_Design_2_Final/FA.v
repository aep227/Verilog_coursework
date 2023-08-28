// Filename:    FA.v
// Author:      Addison Powell
// Date:        May 4, 2020
// Version:     1
// Description: Full-adder module for use in the Ripple Carry Adder and Carry Lookahead Adder

`timescale 1ns/1ns

module FA(input a,
          input b,
          input cin,
          output sum,
          output cout);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

    //(In => Out) = (TRise, TFall);
    //TI SNx4S00 NAND used. Typical prop delay = 3ns LtH and HtL
    specify
        (a => sum)    =  (18, 18);//6 NANDs
        (b => sum)    =  (18, 18);//6 NANDs
        (cin => sum)  =  (9, 9);//3 NANDs
        (a => cout)   =  (15, 15);//5 NANDs
        (b => cout)   =  (15, 15);//5 NANDs
        (cin => cout) =  (6, 6);//2 NANDs
    endspecify

endmodule