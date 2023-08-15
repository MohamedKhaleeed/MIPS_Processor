`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2023 02:32:50 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
    input clk, reset_n,
    //write ports
    input WE3,
    input [4:0] A3,
    input [31:0] WD3,
    //read ports
    input [4:0] A1, A2,
    output [31:0] RD1, RD2
    );
    
    reg [31:0] RAM [0:31];
    integer i;
    
    always@(posedge clk, negedge reset_n)begin
        if(~reset_n)begin
            for(i = 0; i<32; i=i+1)
                RAM[i] <= 'b0;
        end
        else begin
            if(WE3)
                RAM[A3] <= WD3;
        end     
    end
    
    assign RD1 = RAM[A1];
    assign RD2 = RAM[A2];
    
endmodule
