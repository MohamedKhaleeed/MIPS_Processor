`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 09:05:16 PM
// Design Name: 
// Module Name: shift_left_twice
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


module shift_left_twice#(
    parameter n = 4)(
    input [n-1 : 0] in,
    output [n-1 : 0] SLT_out 
    );
    
    assign SLT_out = (in<<2);
endmodule
