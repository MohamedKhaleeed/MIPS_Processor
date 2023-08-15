`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 03:29:43 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [5:0] opcode, funct,
    output reg MemtoReg, Memwrite, Branch, ALUsrc, RegDst, RegWrite, jump,
    output [2:0] ALUControl
    );
    
    reg [1:0] ALUOp;
    reg [2:0] ALUControl_reg;
    always@(*)begin
        MemtoReg = 1'b0;
        Memwrite = 1'b0;
        Branch = 1'b0;
        ALUsrc = 1'b0;
        RegDst = 1'b0;
        RegWrite = 1'b0;
        jump = 1'b0;
        ALUOp = 2'b00;
        case(opcode)
            6'b10_0011:begin
               RegWrite = 1'b1;
               ALUsrc = 1'b1;
               MemtoReg = 1'b1;
            end
            
            6'b10_1011:begin
               Memwrite = 1'b1;
               ALUsrc = 1'b1;
               MemtoReg = 1'b1;
            end
            
            6'b00_0000:begin
               RegWrite = 1'b1;
               RegDst = 1'b1;
               ALUOp = 2'b10;
            end
            
            6'b00_1000:begin
               RegWrite = 1'b1;
               ALUsrc = 1'b1;
            end
            
            6'b00_0100:begin
               Branch = 1'b1;
               ALUOp = 2'b01;
            end
            
            6'b00_0010:begin
               jump = 1'b1;
            end
            
            default:begin
                MemtoReg = 1'b0;
                Memwrite = 1'b0;
                Branch = 1'b0;
                ALUsrc = 1'b0;
                RegDst = 1'b0;
                RegWrite = 1'b0;
                jump = 1'b0;
                ALUOp = 2'b00;
            end
        endcase
    end
    
    always@(*)begin
        ALUControl_reg = 3'b010;
        casex({ALUOp, funct})
            8'b00xxxxxx:
                ALUControl_reg = 3'b010;
            8'b01xxxxxx:
                ALUControl_reg = 3'b100;
            8'b1010_0000:
                ALUControl_reg = 3'b010;
            8'b1010_0010:
                ALUControl_reg = 3'b100;
            8'b1010_1010:
                ALUControl_reg = 3'b110;
            8'b1001_1100:
                ALUControl_reg = 3'b101;
            default:
                ALUControl_reg = 3'b010;
        endcase
    end

    assign ALUControl = ALUControl_reg;
endmodule
