/*
Filename:    output_mod.v
Author:      Addison Powell
Date:        November 22, 2019
Version:     1
Description: Module that handles the output of the vending machine
             Based on the number of coins in the system and the change
             signal received from the user_deposit module, it controls
             LED outputs and sends coin decrement signals to the corresponding
             coin_counter as change is given back.
*/

module output_mod(CLK, reset, product, change_to_give, dime_dec, nickel_dec, exact_change, LED_output, timers_expired);
    input         CLK, reset, product;
    input   [3:0] change_to_give; //Input from the user_deposit module. How much change to be given out
    input   [2:0] timers_expired; //Used in controlling enables to LED outputs. Active-high when timer is expired
                                  //Bit 2 = Product Timer
                                  //Bit 1 = Dime Timer
                                  //Bit 0 = Nickel Timer
    output        dime_dec, nickel_dec; //Decrement signals sent to the coin counters
    input         exact_change; //LED[3] = Exact Change. = 1 if < 20 cents worth of dimes+nickels AND at least 1 nickel. Off otherwise
                                //         If = 1, do not dispense change
    output  [2:0] LED_output; //LED output signals
                              //LED[2] = Product Dispense
                              //LED[1] = Dime Dispense
                              //LED[0] = Nickel Dispense

    reg     [3:0] change;
    reg     [2:0] LED_output;
    reg           dime_dec;
    reg           nickel_dec;

    always@(posedge CLK or negedge reset) begin
        if(~reset)
            change <= 4'd0;
        else if(change_to_give > 4'd0)
            change <= change_to_give;
        
        LED_output[2] <= product;
        
        /*
        if(~exact_change) begin
            if(change >= 4'd10) begin
                if(timers_expired[1]) begin
                    LED_output[1] <= 1'b1;
                    dime_dec <= 1'b1;
                    change <= change - 10;
                end
            end
            else if(change == 4'd5) begin
                if(timers_expired[0]) begin
                    LED_output[0] <= 1'b1;
                    nickel_dec <= 1'b1;
                    change <= change - 5;
                end
            end
            else begin
                LED_output[1:0] <= 2'b00;
                dime_dec <= 1'b0;
                nickel_dec <= 1'b0;
            end
        end
        */            
    end

endmodule