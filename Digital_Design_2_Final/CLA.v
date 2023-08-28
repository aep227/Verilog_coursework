// Filename:    CLA.v
// Author:      Addison Powell
// Date:        May 5, 2020
// Version:     1
// Description: 32-bit Carry Lookahead Adder

`timescale 1ns/1ns

module CLA(input  [31:0] opA,
           input  [31:0] opB,
           output [63:0] result);

     reg  [31:0] P, G;
     reg  [32:0] C;
     wire [31:0] cout;

     //Create Propagate/Generate signals
     always@(opA or opB) begin
          P <= #6 opA | opB;
          G <= #6 opA & opB;
     end

     //Create Carry signals: C[i+1] = G[i] | P[i] & C[i]
     always@(P or G) begin
          #6; //All carry bits computed in constant time as Sum of Products
          C[0]  = 1'b0; //No carry in
          C[1]  = G[0]  | P[0] &  C[0];
          C[2]  = G[1]  | P[1] &  C[1];
          C[3]  = G[2]  | P[2] &  C[2];
          C[4]  = G[3]  | P[3] &  C[3];
          C[5]  = G[4]  | P[4] &  C[4];
          C[6]  = G[5]  | P[5] &  C[5];
          C[7]  = G[6]  | P[6] &  C[6];
          C[8]  = G[7]  | P[7] &  C[7];
          C[9]  = G[8]  | P[8] &  C[8];
          C[10] = G[9]  | P[9] &  C[9];
          C[11] = G[10] | P[10] & C[10];
          C[12] = G[11] | P[11] & C[11];
          C[13] = G[12] | P[12] & C[12];
          C[14] = G[13] | P[13] & C[13];
          C[15] = G[14] | P[14] & C[14];
          C[16] = G[15] | P[15] & C[15];
          C[17] = G[16] | P[16] & C[16];
          C[18] = G[17] | P[17] & C[17];
          C[19] = G[18] | P[18] & C[18];
          C[20] = G[19] | P[19] & C[19];
          C[21] = G[20] | P[20] & C[20];
          C[22] = G[21] | P[21] & C[21];
          C[23] = G[22] | P[22] & C[22];
          C[24] = G[23] | P[23] & C[23];
          C[25] = G[24] | P[24] & C[24];
          C[26] = G[25] | P[25] & C[25];
          C[27] = G[26] | P[26] & C[26];
          C[28] = G[27] | P[27] & C[27];
          C[29] = G[28] | P[28] & C[28];
          C[30] = G[29] | P[29] & C[29];
          C[31] = G[30] | P[30] & C[30];
          C[32] = G[31] | P[31] & C[31];
     end

     FA full_adder_0 (opA[0],  opB[0],  C[0],  result[0],  cout[0]);
     FA full_adder_1 (opA[1],  opB[1],  C[1],  result[1],  cout[1]);
     FA full_adder_2 (opA[2],  opB[2],  C[2],  result[2],  cout[2]);
     FA full_adder_3 (opA[3],  opB[3],  C[3],  result[3],  cout[3]);
     FA full_adder_4 (opA[4],  opB[4],  C[4],  result[4],  cout[4]);
     FA full_adder_5 (opA[5],  opB[5],  C[5],  result[5],  cout[5]);
     FA full_adder_6 (opA[6],  opB[6],  C[6],  result[6],  cout[6]);
     FA full_adder_7 (opA[7],  opB[7],  C[7],  result[7],  cout[7]);
     FA full_adder_8 (opA[8],  opB[8],  C[8],  result[8],  cout[8]);
     FA full_adder_9 (opA[9],  opB[9],  C[9],  result[9],  cout[9]);
     FA full_adder_10(opA[10], opB[10], C[10], result[10], cout[10]);
     FA full_adder_11(opA[11], opB[11], C[11], result[11], cout[11]);
     FA full_adder_12(opA[12], opB[12], C[12], result[12], cout[12]);
     FA full_adder_13(opA[13], opB[13], C[13], result[13], cout[13]);
     FA full_adder_14(opA[14], opB[14], C[14], result[14], cout[14]);
     FA full_adder_15(opA[15], opB[15], C[15], result[15], cout[15]);
     FA full_adder_16(opA[16], opB[16], C[16], result[16], cout[16]);
     FA full_adder_17(opA[17], opB[17], C[17], result[17], cout[17]);
     FA full_adder_18(opA[18], opB[18], C[18], result[18], cout[18]);
     FA full_adder_19(opA[19], opB[19], C[19], result[19], cout[19]);
     FA full_adder_20(opA[20], opB[20], C[20], result[20], cout[20]);
     FA full_adder_21(opA[21], opB[21], C[21], result[21], cout[21]);
     FA full_adder_22(opA[22], opB[22], C[22], result[22], cout[22]);
     FA full_adder_23(opA[23], opB[23], C[23], result[23], cout[23]);
     FA full_adder_24(opA[24], opB[24], C[24], result[24], cout[24]);
     FA full_adder_25(opA[25], opB[25], C[25], result[25], cout[25]);
     FA full_adder_26(opA[26], opB[26], C[26], result[26], cout[26]);
     FA full_adder_27(opA[27], opB[27], C[27], result[27], cout[27]);
     FA full_adder_28(opA[28], opB[28], C[28], result[28], cout[28]);
     FA full_adder_29(opA[29], opB[29], C[29], result[29], cout[29]);
     FA full_adder_30(opA[30], opB[30], C[30], result[30], cout[30]);
     FA full_adder_31(opA[31], opB[31], C[31], result[31], cout[31]);

     assign result[32] = C[32];
     assign result[63:33] = 31'd0;

endmodule