`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2023 01:24:09 AM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] A, B,
    input [2:0] ALUControl,
    output zero_flag,
    output [31: 0] ALU_out
    );
    reg [31: 0] c;
    always@(*)begin
        c = 32'bx;
        casex(ALUControl)
            3'b000: c = A & B;
            3'b001: c = A | B;
            3'b010: c = A + B;
            3'b100: c = A - B;
            3'b101: c = A * B;
            3'b110: c = (A < B);
            default: c = 32'bx;
        endcase
    end
    assign zero_flag = (ALU_out == 0);
    assign ALU_out = c;
endmodule
