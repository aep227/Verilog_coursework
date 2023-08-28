////////////////////////////////////////////////////////////////////////////////
// Modify this header with your name, date, etc.

// Filename: project5Top.v
// Author:   Jason Thweatt
// Date:     28 November 2019
// Revision: 2
// 
// Description: 
// This is the top level module for ECE 3544 Project 5.
// Do not modify the module declarations or ports in this file.
// Make a pin assignment before you program your board with this design!

// module project5Top(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED, opA2, opB2, op_out2, state, pulse_out, control_debug);
module project5Top(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);
	input        CLOCK_50;
	input  [3:0] KEY;
	input  [9:0] SW;
	output [6:0] HEX5;
	output [6:0] HEX4;
	output [6:0] HEX3;
	output [6:0] HEX2;
	output [6:0] HEX1;
	output [6:0] HEX0;
	output [9:0] LED;
	
	wire 		  pulse_out, fin;
	wire   [15:0] alu_out;
	wire	[7:0] data_from_cntrl;
	wire	[3:0] control;
	wire 		  update_display;

	assign HEX5 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign LED = 10'd0;

	// output [7:0] opA2, opB2;//Debug signal
	// output [3:0] op_out2;//Debug signal
	// output [2:0] state;//Debug signal
	// output		 pulse_out;//Debug signal
	// output [3:0] control_debug;//Debug signal
	// assign control_debug = control;//Debug signal


	// alu_cntrl_aep227 controller(CLOCK_50, KEY[0], pulse_out, SW[7:0], fin, control, data_from_cntrl, update_display, state);//Debug signal
	alu_cntrl_aep227 controller(CLOCK_50, KEY[0], pulse_out, SW[7:0], fin, control, data_from_cntrl, update_display);


	// alu_core_aep227 func_unit(CLOCK_50, KEY[0], pulse_out, control, data_from_cntrl, fin, alu_out, update_display, opA2, opB2, op_out2);//Debug signal
	alu_core_aep227 func_unit(CLOCK_50, KEY[0], pulse_out, control, data_from_cntrl, fin, alu_out, update_display);

	buttonpressed button1(CLOCK_50, KEY[0], KEY[1], pulse_out);
	seven_segment_driver_aep227 HEX3_driver(alu_out[15:12], HEX3);
	seven_segment_driver_aep227 HEX2_driver(alu_out[11:8], HEX2);
	seven_segment_driver_aep227 HEX1_driver(alu_out[7:4], HEX1);
	seven_segment_driver_aep227 HEX0_driver(alu_out[3:0], HEX0);

endmodule
