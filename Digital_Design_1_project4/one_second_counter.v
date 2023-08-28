/*
    Filename:    one_second_counter.v
    Author:      Addison Powell
    Date:        November 22, 2019
    Version:     1
    Description: A one-shot timer
                 Generates a 1 second wide pulse when enable is asserted
*/

module one_second_counter(clock, reset_l, enable, out, timer_expire);
    input         clock;
    input         reset_l;		// This reset is active-low.
    input         enable;		// This enable is active-high.
    output        out;			// The output pulse.
    output        timer_expire;	// Expire signal for output module

    reg    [25:0] state; // The counter state. 2^26 = 67,108,864 = 0b 10 11111010 11110000 10000000
    reg           out;
    reg           one_shot_on;   
    reg           timer_expire;

    always@(enable or timer_expire) begin
        if(enable)
            one_shot_on = 1'b1;
        else if(timer_expire)
            one_shot_on = 1'b0;
    end

    //State machine
    always@(posedge clock or negedge reset_l) begin
        if(~reset_l)
            state <= 26'd0;

        if(one_shot_on) begin
            if(state === 26'd50000000) begin
                state <= 26'd0;
                timer_expire <= 1'b1;
            end
            else begin
                state <= state + 1'b1;
                timer_expire <= 1'b0;
            end
        end
        else if(~enable) begin
            state <= state;
        end
        else
            state <= 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
    end

    //Output machine
    always@(state) begin
        if(state != 26'b0)
            out = 1'b1;
        else
            out = 1'b0;
        
    end

endmodule