/*
    Filename:    alu_cntrl_aep227.v
    Author:      Addison Powell
    Date:        December 8, 2019
    Version:     1
    Description: A control module for the ALU core
                 Determines enables for the ALU registers and
                 Passes correct data to the ALU
*/

// module alu_cntrl_aep227(clock, reset, enter, data_in, fin, control, data_out, update_display, state);
module alu_cntrl_aep227(clock, reset, enter, data_in, fin, control, data_out, update_display);
    input         clock, reset, enter, fin; //Active low reset
    input   [7:0] data_in;

    output  [3:0] control;
    output  [7:0] data_out;
    // output  [2:0] state; //6 states, need 3 bits//Debug signal
    output        update_display;

    reg     [2:0] state; //6 states, need 3 bits
    reg     [3:0] opcode, control;
    reg           update_display, multiply_buffer;

    parameter WAIT = 3'b000, LOAD_OP = 3'b001, LOAD_A = 3'b010, LOAD_B = 3'b011,
              MULTIPLY_HOLD = 3'b100,
              ONE_CM = 4'b0100, NEGATE = 4'b0111, MULTIPLY_OP = 4'b1100;

    always@(posedge clock or negedge reset) begin
        if(~reset) begin
            state <= LOAD_OP;
            opcode <= 4'd0;
            update_display <= 1'b0;
            multiply_buffer <= 1'b0;
        end
        else if(state == LOAD_OP) begin
            if(enter)
                state <= LOAD_A;
                opcode <= data_in[3:0];
                update_display <= 1'b0;
        end
        else if(state == LOAD_A) begin
            if(enter && (opcode == ONE_CM || opcode == NEGATE)) begin //1's complement and negate don't need operand B
                state <= LOAD_OP;
                update_display <= 1'b1;
            end
            else if(enter)
                state <= LOAD_B;
        end
        else if(state == LOAD_B) begin
            if(enter && opcode == MULTIPLY_OP) begin
                state <= MULTIPLY_HOLD;
                multiply_buffer <= 1'b1;
            end
            else if(enter) begin
                state <= LOAD_OP;
                update_display <= 1'b1;
            end
        end
        else if(state == MULTIPLY_HOLD) begin
            update_display <= 1'b1;
            if(fin && ~multiply_buffer)
                state <= LOAD_OP;
            else
                multiply_buffer <= 1'b0;
        end
    end

    always@(state) begin
        if(state == LOAD_OP)
            control = 4'b0001;
        else if(state == LOAD_A)
            control = 4'b0010;
        else if(state == LOAD_B)
            control = 4'b0100;
        else if(state == MULTIPLY_HOLD)
            control = 4'b1000;
    end

   assign data_out = data_in;

endmodule