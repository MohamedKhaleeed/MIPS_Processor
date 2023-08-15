`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 10:37:07 AM
// Design Name: 
// Module Name: data_memory
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

 
module data_memory(
    input clk, reset_n,
    input WE,
    input [31:0] WD,
    input [31:0] A,
    output [31:0] RD,
    output [15:0] test_value
    );

    reg [31:0] RAM [0:99];
    integer i;
    
    always@(posedge clk, negedge reset_n)begin
        if(~reset_n)begin
            for(i = 0; i<100; i=i+1)
                RAM[i] <= 'b0;
        end
        else begin
            if(WE)
                RAM[A] <= WD;
        end     
    end
    
    assign RD = RAM[A];
    assign test_value = RAM[0][15:0];
endmodule
