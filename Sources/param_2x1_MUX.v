`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 09:20:45 PM
// Design Name: 
// Module Name: param_2x1_MUX
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


module param_2x1_MUX#(
    parameter n = 32)(
    input [n-1 : 0] in1, in2,
    input sel,
    output [n-1 : 0] mux_out
    );
    
    assign mux_out = sel? in2 : in1;
endmodule
