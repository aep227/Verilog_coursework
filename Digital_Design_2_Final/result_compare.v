// Filename:    result_compare.v
// Author:      Addison Powell
// Date:        May 5, 2020
// Version:     0.1
// Description: Clock-driven comparator module used to determine correct function of the selected module
//              Needs to remain sync'd with operand_select to compare correct values
//              Multiple drivers of op_count means this won't synthesize. Need to fix this

module result_compare(input CLK,
                      input [1:0] SW,
                      input [63:0] result,
                      output reg [3:0] hex_display);

    reg [1:0] op_count;

    always@(posedge CLK) begin
        case(SW)
            2'd0: begin //Ripple Carry Adder
                case(op_count)
                    2'd0: begin //Operands = 32'h00000000
                            if(result == 64'd0)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd1: begin //Operands = 32'h44444444
                            if(result == 64'd2290649224)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'h77777777
                            if(result == 64'd4008636142)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'hFFFFFFFF
                            if(result == 64'd8589934590)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    default: hex_display <= 4'd0;
                endcase
            end
            2'd1: begin //Carry Lookahead Adder
                case(op_count)
                    2'd0: begin //Operands = 32'h00000000
                            if(result == 64'd0)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd1: begin //Operands = 32'h44444444
                            if(result == 64'd2290649224)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'h77777777
                            if(result == 64'd4008636142)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'hFFFFFFFF
                            if(result == 64'd8589934590)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    default: hex_display <= 4'd0;
                endcase
            end
            2'd2: begin //Combinational Multiplier
                case(op_count)
                    2'd0: begin //Operands = 32'h00000000
                            if(result == 64'd0)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd1: begin //Operands = 32'h44444444
                            if(result == 64'd1311768466852950544)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'h77777777
                            if(result == 64'd4017290929737161041)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'hFFFFFFFF
                            if(result == 64'd18446744065119617025)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    default: hex_display <= 4'd0;
                endcase
            end
            2'd3: begin //Shift-and-Add Multiplier
                case(op_count)
                    2'd0: begin //Operands = 32'h00000000
                            if(result == 64'd0)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd1: begin //Operands = 32'h44444444
                            if(result == 64'd1311768466852950544)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'h77777777
                            if(result == 64'd4017290929737161041)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    2'd3: begin //Operands = 32'hFFFFFFFF
                            if(result == 64'd18446744065119617025)
                                hex_display <= 4'd1;
                            else
                                hex_display <= 4'd0;
                        end
                    default: hex_display <= 4'd0;
                endcase
            end
            default: hex_display <= 4'd0;
        endcase

        if(op_count < 4)
            op_count <= op_count + 1'b1;
        else
            op_count <= 2'd0;
        
    end

    always@(SW) begin //Reset op_count when switches are changed. This re-syncs the operands with the clk
        op_count = 2'd0;
    end

endmodule