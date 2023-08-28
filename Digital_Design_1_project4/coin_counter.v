/*
Filename:    coin_counter.v
Author:      Addison Powell
Date:        November 22, 2019
Version:     1
Description: A simple 8-bit counter that tracks the vending machines
             inventory of coins
*/

module coin_counter(CLK, reset, enable, inc_sig, dec_sig, coins);
    input           CLK, enable, inc_sig, dec_sig;
    input           reset; //Active-low reset
    output  [7:0]   coins; //Upper 4 bits drives one display, lower 4 bits drive another
    reg     [7:0]   coins;

    always@(posedge CLK or negedge reset) begin
        if(~reset)
            coins <= 8'd0;
        else if(enable && inc_sig)
            coins <= coins + 1;
        else if(dec_sig && coins > 0)
            coins <= coins - 1;
    end


endmodule