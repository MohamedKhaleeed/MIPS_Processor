`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2023 02:25:24 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input clk, reset_n,
    input [31:0] pc_in,
    output [31:0] pc_out
    );
    reg [31:0] Q_reg, Q_next;
    
    always@(posedge clk, negedge reset_n)begin
        if(~reset_n)
            Q_reg <= 32'b0;
        else
            Q_reg <= Q_next;
    end
    
    always@(*)begin
        Q_next = pc_in;
    end
    
    assign pc_out = Q_reg;
endmodule
