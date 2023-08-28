// Filename:    tb_FA.v
// Author:      Addison Powell
// Date:        May 4, 2020
// Version:     1
// Description: Test bench for full-adder module.
//              Used to confirm function of specify block

`timescale 1ns/1ns

module tb_FA();

    reg a, b, cin;
    wire sum, cout;

    FA DUT(a,b,cin,sum,cout);

    initial begin
        a =   1'b0;
        b =   1'b0;
        cin = 1'b0;
        #100;
        a =   1'b0;
        b =   1'b0;
        cin = 1'b1;
        #100;
        a =   1'b0;
        b =   1'b0;
        cin = 1'b0;
        #100;
        a =   1'b0;
        b =   1'b1;
        cin = 1'b0;
        #100;
        a =   1'b0;
        b =   1'b1;
        cin = 1'b1;
        #100;
        a =   1'b0;
        b =   1'b0;
        cin = 1'b0;
        #100;
    end

endmodule