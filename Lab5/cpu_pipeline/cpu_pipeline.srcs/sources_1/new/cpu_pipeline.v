`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 16:34:33
// Design Name: 
// Module Name: cpu_pipeline
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


module cpu_pipeline
(
input clk,  // 时钟, 上升沿有效
input rst,   // 异步复位, 高电平有效
input [31:0] dbu_mem_rf_addr,   // DBU选择地址
output [31:0] dbu_rf_data,      // DBU选择地址的寄存器堆数据
output [31:0] dbu_mem_data,     // DBU选择地址的存储器数据
output [31:0] dbu_pc,           // PC
output [31:0] dbu_ir,           // IR
output [31:0] dbu_md,           // MD, 存储器中读出数据寄存器
output [31:0] dbu_a,            // A
output [31:0] dbu_b,            // B
output [31:0] dbu_alu_out,      // ALUOut
output [15:0] dbu_status
);



endmodule
