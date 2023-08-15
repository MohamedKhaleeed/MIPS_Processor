`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2023 09:26:49 PM
// Design Name: 
// Module Name: MIPS
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


module MIPS(
    input clk, reset_n,
    output [15:0] test_value
    );
    
    wire [31:0] pc_in, pc_out;
    program_counter PC(
        .clk(clk), 
        .reset_n(reset_n),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    
    wire [31:0] instr;
    instruction_memory IM(
        .pc(pc_out),
        .instr(instr)
    );
    
    wire MemtoReg, Memwrite, Branch, ALUsrc, RegDst, RegWrite, jump;
    wire [2:0] ALUControl;
    control_unit CU(
        .opcode(instr[31:26]), 
        .funct(instr[5:0]),
        .MemtoReg(MemtoReg), 
        .Memwrite(Memwrite), 
        .Branch(Branch), 
        .ALUsrc(ALUsrc), 
        .RegDst(RegDst), 
        .RegWrite(RegWrite), 
        .jump(jump),
        .ALUControl(ALUControl)
    );
    
    wire [31:0] RD1, RD2;
    wire [4:0] mux2_out;
    wire [31:0] Result;
    register_file RF(
        .clk(clk), 
        .reset_n(reset_n),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(instr[25:21]),
        .A2(instr[20:16]),
        .A3(mux2_out),
        .RD1(RD1),
        .RD2(RD2)
    );
    
    wire [31:0] signlmm;
    sign_extend SE(
        .instr(instr[15:0]),
        .signlmm(signlmm)
    );

    
    wire zero_flag;
    wire [31:0] mux3_out;
    wire [31:0] ALU_out;
    ALU alu(
        .A(RD1), 
        .B(mux3_out),
        .ALUControl(ALUControl),
        .zero_flag(zero_flag),
        .ALU_out(ALU_out)
    );
    
    wire [31:0] RD;
    data_memory DM(
        .clk(clk), 
        .reset_n(reset_n),
        .WE(Memwrite),
        .WD(RD2),
        .A(ALU_out),
        .RD(RD),
        .test_value(test_value)
    );
    
    wire [31:0] PCplus4;
    adder add_4(
        .A(pc_out),
        .B(4),
        .C(PCplus4)
    );
    
    wire [31:0] PCBranch;
    adder add(
        .A(signlmm << 2),
        .B(PCplus4),
        .C(PCBranch)
    );
    
    wire [27:0] SLT_out;
    shift_left_twice# (.n(28)) SLT(
        .in({2'b00, instr[25:0]}),
        .SLT_out(SLT_out)
    );
    
    wire [31:0] mux0_out;
    param_2x1_MUX#(.n(32)) mux0(
        .in1(PCplus4),
        .in2(PCBranch),
        .sel(Branch & zero_flag),
        .mux_out(mux0_out)
    );
    
    param_2x1_MUX#(.n(32)) mux1(
        .in1(mux0_out),
        .in2({PCplus4 [31:28], SLT_out}),
        .sel(jump),
        .mux_out(pc_in)
    );
    
    param_2x1_MUX#(.n(5)) mux2(
        .in1(instr[20:16]),
        .in2(instr[15:11]),
        .sel(RegDst),
        .mux_out(mux2_out)
    );
    
    param_2x1_MUX#(.n(32)) mux3(
        .in1(RD2),
        .in2(signlmm),
        .sel(ALUsrc),
        .mux_out(mux3_out)
    );
    
    param_2x1_MUX#(.n(32)) mux4(
        .in1(ALU_out),
        .in2(RD),
        .sel(MemtoReg),
        .mux_out(Result)
    );
    
endmodule
