// Filename:    RCA.v
// Author:      Addison Powell
// Date:        May 4, 2020
// Version:     1
// Description: 32-bit Ripple Carry Adder

`timescale 1ns/1ns

module RCA(input [31:0] opA,
           input [31:0] opB,
           output [63:0] result);

    wire [31:0] cout;

    FA full_adder_0(opA[0], opB[0], 1'b0,   result[0], cout[0]);
    FA full_adder_1(opA[1], opB[1], cout[0], result[1], cout[1]);
    FA full_adder_2(opA[2], opB[2], cout[1], result[2], cout[2]);
    FA full_adder_3(opA[3], opB[3], cout[2], result[3], cout[3]);
    FA full_adder_4(opA[4], opB[4], cout[3], result[4], cout[4]);
    FA full_adder_5(opA[5], opB[5], cout[4], result[5], cout[5]);
    FA full_adder_6(opA[6], opB[6], cout[5], result[6], cout[6]);
    FA full_adder_7(opA[7], opB[7], cout[6], result[7], cout[7]);
    FA full_adder_8(opA[8], opB[8], cout[7], result[8], cout[8]);
    FA full_adder_9(opA[9], opB[9], cout[8], result[9], cout[9]);
    FA full_adder_10(opA[10], opB[10], cout[9],  result[10], cout[10]);
    FA full_adder_11(opA[11], opB[11], cout[10], result[11], cout[11]);
    FA full_adder_12(opA[12], opB[12], cout[11], result[12], cout[12]);
    FA full_adder_13(opA[13], opB[13], cout[12], result[13], cout[13]);
    FA full_adder_14(opA[14], opB[14], cout[13], result[14], cout[14]);
    FA full_adder_15(opA[15], opB[15], cout[14], result[15], cout[15]);
    FA full_adder_16(opA[16], opB[16], cout[15], result[16], cout[16]);
    FA full_adder_17(opA[17], opB[17], cout[16], result[17], cout[17]);
    FA full_adder_18(opA[18], opB[18], cout[17], result[18], cout[18]);
    FA full_adder_19(opA[19], opB[19], cout[18], result[19], cout[19]);
    FA full_adder_20(opA[20], opB[20], cout[19], result[20], cout[20]);
    FA full_adder_21(opA[21], opB[21], cout[20], result[21], cout[21]);
    FA full_adder_22(opA[22], opB[22], cout[21], result[22], cout[22]);
    FA full_adder_23(opA[23], opB[23], cout[22], result[23], cout[23]);
    FA full_adder_24(opA[24], opB[24], cout[23], result[24], cout[24]);
    FA full_adder_25(opA[25], opB[25], cout[24], result[25], cout[25]);
    FA full_adder_26(opA[26], opB[26], cout[25], result[26], cout[26]);
    FA full_adder_27(opA[27], opB[27], cout[26], result[27], cout[27]);
    FA full_adder_28(opA[28], opB[28], cout[27], result[28], cout[28]);
    FA full_adder_29(opA[29], opB[29], cout[28], result[29], cout[29]);
    FA full_adder_30(opA[30], opB[30], cout[29], result[30], cout[30]);
    FA full_adder_31(opA[31], opB[31], cout[30], result[31], cout[31]);

    assign result[32] = cout[31];
    assign result[63:33] = 31'd0;

endmodule