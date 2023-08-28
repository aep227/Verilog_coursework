// Filename:    operand_select.v
// Author:      Addison Powell
// Date:        May 5, 2020
// Version:     1
// Description: Clock-driven module that cycles through preset values for operands A and B

module operand_select(input CLK,
                      output reg [31:0] opA,
                      output reg [31:0] opB);

    reg [1:0] op_count;

    always@(posedge CLK) begin
        case(op_count)
            2'd0: begin //Minimum value
                  opA <= 32'h00000000;
                  opB <= 32'h00000000;
                  op_count <= op_count + 1'b1; end
            2'd1: begin //Mid value 1
                  opA <= 32'h44444444;
                  opB <= 32'h44444444;
                  op_count <= op_count + 1'b1; end
            2'd2: begin //Mid value 2
                  opA <= 32'h77777777;
                  opB <= 32'h77777777;
                  op_count <= 2'd0; end
            2'd3: begin //Maximum value
                  opA <= 32'hFFFFFFFF;
                  opB <= 32'hFFFFFFFF;
                  op_count <= 2'd0; end
            default: op_count <= 2'd0;
        endcase
    end

endmodule