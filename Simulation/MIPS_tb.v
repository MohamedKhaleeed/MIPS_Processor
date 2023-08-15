`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 04:34:48 AM
// Design Name: 
// Module Name: MIPS_tb
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


module MIPS_tb();
    reg clk;
    reg reset_n;
    wire [15:0] test_value;
    
    MIPS dut(
        .clk(clk),
        .reset_n(reset_n),
        .test_value(test_value)
    );
    
    localparam T = 10;
    always begin
        clk = 1'b0;
        #(T/2)
        clk = 1'b1;
        #(T/2);
    end
    
    initial begin
        reset_n = 0;
        #10
        reset_n = 1;
        #700;
        $finish();
    end
endmodule
