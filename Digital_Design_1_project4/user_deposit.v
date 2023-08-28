/*
Filename:    user_deposit.v
Author:      Addison Powell
Date:        November 22, 2019
Version:     1
Description: FSM that detects how much money has been deposited by a user.
             Only active in normal
             Resets upon receiving an active-low reset signal or entering maintenance mode
*/

module user_deposit(CLK, switch_in, reset, enable, change_to_give, product);
    input           CLK, reset, enable;
    input   [2:0]   switch_in;
    output  [3:0]   change_to_give;
    output          product;
    reg     [6:0]   deposited;
    reg     [3:0]   change;
    reg     [3:0]   change_to_give;
    reg             product;       

    parameter QUARTER_IN = 2'b11, DIME_IN = 2'b10, NICKEL_IN = 2'b01;

    always@(posedge CLK or negedge reset) begin
        if(~reset) begin
				if(product) begin //Nested if because Quartus is throwing a fit when I try to do if(~reset || product) above
					change <= 4'd0;
					deposited <= 7'd0;
					end
        end
        else if(enable && ~switch_in[2]) begin
            case(switch_in[1:0])
                NICKEL_IN: deposited <= deposited + 5;
                DIME_IN: deposited <= deposited + 10;
                QUARTER_IN: deposited <= deposited + 25;
                default: deposited <= 7'bxxxxxxx;
            endcase
        end
    end
	 
	 

    always@(deposited) begin
        if(deposited >= 7'd60) begin
            product = 1'b1;
            change_to_give = deposited - 60;
        end
        else begin
            product = 1'b0;
            change_to_give = 4'd0;
        end
    end

endmodule