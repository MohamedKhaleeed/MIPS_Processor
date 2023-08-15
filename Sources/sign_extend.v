`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 08:15:40 PM
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(
    input [15:0] instr,
    output reg [31:0] signlmm
    );
    always@(*)begin
    if(instr[15])
        signlmm = {16'b1111111111111111, instr};
    else
        signlmm = {16'b0000000000000000, instr};
    end
endmodule
