////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: project4.v
// Author:   Addison Powell
// Date:     November 22, 2019
// Version:  1
//
// Description:
// This is the top level module for ECE 3544 Project 4.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

// Do NOT modify the module declaration.

module project4(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);

//==========================================================
//  PORT declarations: Do NOT modify these declarations.
//==========================================================

	input        CLOCK_50;	// You must use this clock for the clock of all of your sequential hardware.
	input  [1:0] KEY;		// KEY[1] is the system enable.
							// KEY[0] is the (active-low) system reset.
	input  [9:0] SW;		// SW[2] controls the mode.
							// SW[1:0] represents a coin input.
							// The other switches are avaialble for debugging.
	output [6:0] HEX5;		// HEX5 and HEX4 display the number of quarters in the machine.
	output [6:0] HEX4;
	output [6:0] HEX3;		// HEX3 and HEX2 display the number of dimes in the machine.
	output [6:0] HEX2;
	output [6:0] HEX1;		// HEX1 and HEX0 display the number of nickels in the machine.
	output [6:0] HEX0;
	output [9:0] LED;		// LED[3] lights when the user must use exact change.
							// LED[2] lights for one second when the product is dispensed.
							// LED[1] lights for one second for each dime dispensed in change.
							// LED[0] lights for one second for each nickel dispensed in change.
							// The other LEDs are available for debugging.
	
// You should add your reg/wire/parameter declarations here.
	wire		  enable, reset_l, dime_dec, nickel_dec, inc_quar, inc_dime, inc_nick;
	wire	[7:0] quarters;
	wire	[7:0] dimes;
	wire	[7:0] nickels;
	wire	[3:0] change_to_give;
	wire	[2:0] LED_output;
	wire	[2:0] timers_expired;
	reg			  exact_change;

	

//=======================================================
// Module instantiantions
//=======================================================

// You should add your module instances here. You may also add continuous assignments as appropriate.

/*
module coin_counter(CLK, reset, enable, inc_sig, dec_sig, coins);
module user_deposit(CLK, switch_in, reset, enable, change, product);
module output_mod(CLK, reset, product, change_to_give, dime_dec, nickel_dec, LED_exact_change, LED_output, timers_expired);
module seven_segment_driver_aep227(hex_digit, hex_display);
module one_second_counter(clock, reset_l, enable, out, timer_expire);
*/

assign reset_l = KEY[0];
assign inc_quar = (SW[1] && SW[0]); //01
assign inc_dime = (SW[1] && ~SW[0]);//10
assign inc_nick = (~SW[1] && SW[0]);//11

/*
always@(posedge CLOCK_50) begin
	if( (dimes[1:0] == 2'b11 && nickels >= 8'd1) || (dimes[1:0] == 2'b10 && nickels >= 8'd1) ||
		(dimes[1:0] == 2'b01 && nickels >= 8'd2) || (dimes[1:0] == 2'b00 && nickels >= 8'd4) )
		exact_change = 1'b0;
	else
		exact_change = 1'b1;
end
*/

assign LED[3] = exact_change;

buttonpressed U1(CLOCK_50, reset_l, KEY[1], enable);

coin_counter quarter_counter(CLOCK_50, reset_l, enable, inc_quar, 1'b0, quarters);
coin_counter dime_counter(CLOCK_50, reset_l, enable, inc_dime, dime_dec, dimes);
coin_counter nickel_counter(CLOCK_50, reset_l, enable, inc_nick, nickel_dec, nickels);

user_deposit vending(CLOCK_50, SW[2:0], reset_l, enable, change_to_give, product);

output_mod out_control(CLK, reset_l, product, change_to_give, dime_dec, nickel_dec, LED_exact_change, LED_output, timers_expired);

one_second_counter LED_2(CLOCK_50, reset_l, LED_output[2], LED[2], timers_expired[2]);
one_second_counter LED_1(CLOCK_50, reset_l, LED_output[1], LED[1], timers_expired[1]);
one_second_counter LED_0(CLOCK_50, reset_l, LED_output[0], LED[0], timers_expired[0]);

seven_segment_driver_aep227 display5(quarters[7:4], HEX5);
seven_segment_driver_aep227 display4(quarters[3:0], HEX4);
seven_segment_driver_aep227 display3(dimes[7:4], HEX3);
seven_segment_driver_aep227 display2(dimes[3:0], HEX2);
seven_segment_driver_aep227 display1(nickels[7:4], HEX1);
seven_segment_driver_aep227 display0(nickels[3:0], HEX0);



endmodule
