/*
    Filename:    alu_register_aep227.v
    Author:      Addison Powell
    Date:        December 7, 2019
    Version:     2
    Description: An 8-bit register module modified from HW7 Problem 3
*/

module alu_register_aep227(clock, reset, enable, ins, outs);
    input        clock, reset, enable; //Reset is async active-low; enable is active-high
    input  [7:0] ins;
    output [7:0] outs;

    reg    [7:0] state;

    always@(posedge clock or negedge reset) begin
        if(~reset)
            state <= 8'd0;
        else if(enable)
            state <= ins;
    end

    assign outs = state;

endmodule