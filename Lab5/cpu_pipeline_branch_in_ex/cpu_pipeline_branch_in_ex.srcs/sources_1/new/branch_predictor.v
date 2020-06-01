`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 23:26:00
// Design Name: 
// Module Name: branch_predictor
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


module branch_predictor
#(
parameter HIGH = 5    // cache地址最高位
)
(
input clk,
input rst,
input [5:0] im_instr_opcode,
input [HIGH:0] EX_MEM_lowpc,
input EX_MEM_is_branch,
input EX_MEM_ZF,
output shall_branch
);

localparam BEQ_op = 6'b000100;
localparam CACHE_SIZE = {2'b10, {HIGH{1'b0}}}; // 根据 HIGH 判断缓存大小
reg [1:0] cache[CACHE_SIZE-1:0];
integer i;

assign shall_branch = cache[EX_MEM_lowpc] >= 2'b10 && im_instr_opcode == BEQ_op ? 1'b1 : 1'b0;

always @(posedge clk, posedge rst) begin
    if(rst) begin
        for(i = 0; i < CACHE_SIZE; i = i + 1) begin
            cache[i] <= 2'b10;
        end
    end
    else if(EX_MEM_is_branch) begin
        case(EX_MEM_ZF)
            1'b0: cache[EX_MEM_lowpc] <= cache[EX_MEM_lowpc] == 2'b00 ? 2'b00 : cache[EX_MEM_lowpc] - 1;
            1'b1: cache[EX_MEM_lowpc] <= cache[EX_MEM_lowpc] == 2'b11 ? 2'b11 : cache[EX_MEM_lowpc] + 1;
            default: cache[EX_MEM_lowpc] <= 2'b01;
        endcase
    end
end

endmodule
