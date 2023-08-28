/*
    Filename:    multiplier_aep227.v
    Author:      Addison Powell
    Date:        December 7, 2019
    Version:     2
    Description: A sequential multiplier module
                 Modified from the 4-bit version in HW7
                 to be an 8-bit multiplier and to perform
                 operations when enter is asserted
*/


module multiplier_aep227(clock, reset_l, enter, enable, op_in_A, op_in_B, product, fin);
    input         clock, reset_l, enter, enable;
    input  [7:0]  op_in_A, op_in_B;
    output [15:0] product;
    output        fin;

    reg    [16:0] sum_reg;
    reg    [3:0]  multiply_counter;
    reg           hold, fin;

    /*
        8-bit register multiplicand
        17-bit register to hold sum and multiplier
            -Reg[16] = Carry out from sum
            -Reg[15:8] = Sum from additions/product
            -Reg[7:0] = multiplier
    */

    always@(posedge clock or negedge reset_l) begin
        if(~reset_l) begin
            sum_reg <= 17'd0;
            multiply_counter <= 4'd0;
            hold <= 1'b0;
        end
        else if(hold) begin //Shift right "state"
            sum_reg <= (sum_reg >> 1);    
            hold <= 1'b0;
        end
        else if(enable && multiply_counter == 4'd0) begin
            sum_reg <= {9'b00000, op_in_B};
            multiply_counter <= 4'd1;
        end
        else if(enable && enter && multiply_counter != 4'd0) begin
            if(sum_reg[0] == 1'b1) begin //Add
                sum_reg[16:8] <= sum_reg[15:8] + op_in_A;
            end
            hold <= 1'b1;
            multiply_counter <= multiply_counter + 1'b1;
            if(multiply_counter == 4'd8) begin //If 8 shifts have happened, reset this counter to the hold state
                multiply_counter <= 4'b0;
            end
        end
    end

    always@(multiply_counter) begin
        if(multiply_counter == 4'd0)
            fin = 1'b1;
        else
            fin = 1'b0;
    end

    assign product = sum_reg[15:0];

endmodule