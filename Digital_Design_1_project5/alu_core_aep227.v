/*
    Filename:    alu_core_aep227.v
    Author:      Addison Powell
    Date:        December 7, 2019
    Version:     1
    Description: Core function unit for Project 5.
                 Has registers for storing operands and
                 the serial multiplier module
*/

// module alu_core_aep227(clock, reset, enter, control, data_in, fin, alu_out, update_display, opA2, opB2, op_out2);
module alu_core_aep227(clock, reset, enter, control, data_in, fin, alu_out, update_display);
    input        clock, reset, enter, update_display; //Reset is active low
    input  [7:0] data_in;
    input  [3:0] control;//enable signals for registers/multiplier. 
                         //{multiply_en, opB, opA, opcode}

    output [15:0] alu_out;
    output        fin;//Tells alu_cntrl operation is complete and is ready to receive another command
    // output [7:0]  opA2, opB2;//Debug signal
    // output [3:0]  op_out2;//Debug signal

    reg    [15:0] combi_alu, alu_out;
    wire   [15:0] extend_A, extend_B, zerof_A, zerof_B, product;
    wire   [7:0]  opA, opB, op_out;
    wire   [3:0]  opcode;

    parameter AND_ID = 4'b0000, NAND = 4'b0001, NOR = 4'b0010, XOR = 4'b0011, ONE_CM = 4'b0100,
              ADD = 4'b0101, SUB = 4'b0110, NEGATE = 4'b0111, ARITH_LEFT = 4'b1000, ARITH_RIGHT = 4'b1001,
              ROTATE_LEFT = 4'b1010, ROTATE_RIGHT = 4'b1011, MULTIPLY = 4'b1100;

    multiplier_aep227 multi(clock, reset, enter, control[3], opA, opB, product, fin);

    alu_register_aep227 opcode_reg(clock, reset, control[0], {4'b0000, data_in[3:0]}, op_out);
    alu_register_aep227 operandA_reg(clock, reset, control[1], data_in, opA);
    alu_register_aep227 operandB_reg(clock, reset, control[2], data_in, opB);

    always@(posedge clock or negedge reset) begin //16-bit result "register"
        if(~reset)
            alu_out <= 16'd0;
        else if(update_display && opcode === MULTIPLY)
            alu_out <= product;
        else if(update_display)
            alu_out = combi_alu;
    end

    assign extend_A = {{8{opA[7]}}, opA};
    assign zerof_A  = {8'b0, opA};
    assign extend_B = {{8{opB[7]}}, opB};    
    assign zerof_B  = {8'b0, opB};   
    assign opcode = op_out[3:0];

    // assign opA2 = opA;//Debug signal
    // assign opB2 = opB;//Debug signal
    // assign op_out2 = op_out[3:0];//Debug signal

    always@(opcode or opA or opB) begin //Combinational ALU block
        case(opcode)
            AND_ID: combi_alu = {opA, opB} & 16'h7383;
            NAND:   combi_alu = {8'b0, ~(opA & opB)};
            NOR:    combi_alu = {8'b0, ~(opA | opB)};
            XOR:    combi_alu = {8'b0, opA ^ opB};
            ONE_CM: combi_alu = {8'b0, ~opA};
            ADD:    combi_alu = extend_A + extend_B;
            SUB:    combi_alu = extend_A - extend_B;
            NEGATE: combi_alu = ~(extend_A) + 1'b1;
            ARITH_LEFT:     combi_alu = extend_A << opB; //And now for the ugly code cause we aren't allowed to have nice operators
            ARITH_RIGHT:  begin
                          case(opB)
                            4'd0: combi_alu = extend_A;
                            4'd1: combi_alu = {{1{extend_A[15]}}, extend_A[15:1]};
                            4'd2: combi_alu = {{2{extend_A[15]}}, extend_A[15:2]};
                            4'd3: combi_alu = {{3{extend_A[15]}}, extend_A[15:3]};
                            4'd4: combi_alu = {{4{extend_A[15]}}, extend_A[15:4]};
                            4'd5: combi_alu = {{5{extend_A[15]}}, extend_A[15:5]};
                            4'd6: combi_alu = {{6{extend_A[15]}}, extend_A[15:6]};
                            4'd7: combi_alu = {{7{extend_A[15]}}, extend_A[15:7]};
                            4'd8: combi_alu = {{8{extend_A[15]}}, extend_A[15:8]};
                            4'd9: combi_alu = {{9{extend_A[15]}}, extend_A[15:9]};
                            4'd10: combi_alu = {{10{extend_A[15]}}, extend_A[15:10]};
                            4'd11: combi_alu = {{11{extend_A[15]}}, extend_A[15:11]};
                            4'd12: combi_alu = {{12{extend_A[15]}}, extend_A[15:12]};
                            4'd13: combi_alu = {{13{extend_A[15]}}, extend_A[15:13]};
                            4'd14: combi_alu = {{14{extend_A[15]}}, extend_A[15:14]};
                            4'd15: combi_alu = {{15{extend_A[15]}}, extend_A[15]};
                            default: combi_alu = 16'bxxxxxxxxxxxxxxxx;
                          endcase
                          end
            ROTATE_LEFT:  begin
                          case(opB)
                            4'd0: combi_alu = zerof_A;
                            4'd1: combi_alu = {zerof_A[14:0], zerof_A[15]};
                            4'd2: combi_alu = {zerof_A[13:0], zerof_A[15:14]};
                            4'd3: combi_alu = {zerof_A[12:0], zerof_A[15:13]};
                            4'd4: combi_alu = {zerof_A[11:0], zerof_A[15:12]};
                            4'd5: combi_alu = {zerof_A[10:0], zerof_A[15:11]};
                            4'd6: combi_alu = {zerof_A[9:0], zerof_A[15:10]};
                            4'd7: combi_alu = {zerof_A[8:0], zerof_A[15:9]};
                            4'd8: combi_alu = {zerof_A[7:0], zerof_A[15:8]};
                            4'd9: combi_alu = {zerof_A[6:0], zerof_A[15:7]};
                            4'd10: combi_alu = {zerof_A[5:0], zerof_A[15:6]};
                            4'd11: combi_alu = {zerof_A[4:0], zerof_A[15:5]};
                            4'd12: combi_alu = {zerof_A[3:0], zerof_A[15:4]};
                            4'd13: combi_alu = {zerof_A[2:0], zerof_A[15:3]};
                            4'd14: combi_alu = {zerof_A[1:0], zerof_A[15:2]};
                            4'd15: combi_alu = {zerof_A[0], zerof_A[15:1]};
                            default: combi_alu = 16'bxxxxxxxxxxxxxxxx;
                          endcase
                          end
            ROTATE_RIGHT: begin
                          case(opB)
                            4'd0: combi_alu = zerof_A;
                            4'd1: combi_alu = {zerof_A[0], zerof_A[15:1]};
                            4'd2: combi_alu = {zerof_A[1:0], zerof_A[15:2]};
                            4'd3: combi_alu = {zerof_A[2:0], zerof_A[15:3]};
                            4'd4: combi_alu = {zerof_A[3:0], zerof_A[15:4]};
                            4'd5: combi_alu = {zerof_A[4:0], zerof_A[15:5]};
                            4'd6: combi_alu = {zerof_A[5:0], zerof_A[15:6]};
                            4'd7: combi_alu = {zerof_A[6:0], zerof_A[15:7]};
                            4'd8: combi_alu = {zerof_A[7:0], zerof_A[15:8]};
                            4'd9: combi_alu = {zerof_A[8:0], zerof_A[15:9]};
                            4'd10: combi_alu = {zerof_A[9:0], zerof_A[15:10]};
                            4'd11: combi_alu = {zerof_A[10:0], zerof_A[15:11]};
                            4'd12: combi_alu = {zerof_A[11:0], zerof_A[15:12]};
                            4'd13: combi_alu = {zerof_A[12:0], zerof_A[15:13]};
                            4'd14: combi_alu = {zerof_A[13:0], zerof_A[15:14]};
                            4'd15: combi_alu = {zerof_A[14:0], zerof_A[15]};
                            default: combi_alu = 16'bxxxxxxxxxxxxxxxx;
                          endcase
                          end
            MULTIPLY: combi_alu = 16'bxxxxxxxxxxxxxxxx;//Output won't be chosen, so don't care
            default: combi_alu = 16'bxxxxxxxxxxxxxxxx;
        endcase
    end

endmodule