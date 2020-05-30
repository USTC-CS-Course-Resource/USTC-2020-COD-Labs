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
input [31:0] DBU_mem_rf_addr,   // DBU选择地址
output [31:0] DBU_rf_data,      // DBU选择地址的寄存器堆数据
output [31:0] DBU_mem_data,     // DBU选择地址的存储器数据
output [31:0] DBU_PC,           // PC
output [31:0] DBU_IF_ID_IR,
output [31:0] DBU_IF_ID_NPC,
output [31:0] DBU_ID_EX_A,
output [31:0] DBU_ID_EX_B,
output [31:0] DBU_ID_EX_IMM,      
output [31:0] DBU_ID_EX_IR,
output [31:0] DBU_EX_MEM_Y,
output [31:0] DBU_EX_MEM_B,
output [4:0] DBU_EX_MEM_WA,
output [31:0] DBU_MEM_WB_MDR,
output [31:0] DBU_MEM_WB_Y,
output [4:0] DBU_MEM_WB_WA,
output [15:0] DBU_status
);

// 控制信号
//// 控制单元
wire pc_we;
wire [1:0] pc_src;

//// 转发控制器
wire [1:0] alu_a_src;
wire [1:0] alu_b_src;

// 寄存器
//// PC
reg [31:0] PC;
//// IF/ID段
reg [31:0] IF_ID_NPC;
reg [31:0] IF_ID_IR;
//// ID/EX段
reg [1:0] ID_EX_WB;
reg [1:0] ID_EX_M;
reg [3:0] ID_EX_EX;
reg [31:0] ID_EX_NPC;
reg [31:0] ID_EX_A;
reg [31:0] ID_EX_B;
reg [31:0] ID_EX_IMM;
reg [31:0] ID_EX_IR;
//// EX/MEM
reg [1:0] EX_MEM_WB;
reg [1:0] EX_MEM_M;
reg [31:0] EX_MEM_NPC;
reg EX_MEM_ZF;
reg [31:0] EX_MEM_Y;
reg [31:0] EX_MEM_B;
reg [4:0] EX_MEM_WA;
//// MEM/WB
reg [1:0] MEM_WB_WB;
reg [31:0] MEM_WB_MDR;
reg [31:0] MEM_WB_Y;
reg [4:0] MEM_WB_WA;

// 连线
wire [31:0] WB_wb_data;
wire [31:0] ID_instr_imm;
wire [27:0] ID_instr_25_0_sll_2;
wire [31:0] mem_out_rd;
wire [1:0] ctrl_m;
wire [1:0] ctrl_wb;
wire [3:0] ctrl_ex;

// 传输数据给 DBU
assign DBU_PC = PC;
assign DBU_IF_ID_IR = IF_ID_IR;
assign DBU_IF_ID_NPC = IF_ID_NPC;

assign DBU_ID_EX_A = ID_EX_A;
assign DBU_ID_EX_B = ID_EX_B;
assign DBU_ID_EX_IMM = ID_EX_IMM;
assign DBU_ID_EX_IR = ID_EX_IR;

assign DBU_EX_MEM_Y = EX_MEM_Y;
assign DBU_EX_MEM_B = EX_MEM_B;
assign DBU_EX_MEM_WA = EX_MEM_WA;

assign DBU_MEM_WB_MDR = MEM_WB_MDR;
assign DBU_MEM_WB_Y = MEM_WB_Y;
assign DBU_MEM_WB_WA = MEM_WB_WA;


// IF 段
wire [31:0] im_instr;
instr_mem_256x32 mem_instr(.a(PC >> 2),
                           .spo(im_instr));

always @(posedge clk, posedge rst) begin
    if(rst) begin
        IF_ID_NPC <= 32'h0000_0000;
        IF_ID_IR <= 32'h0000_0000;
    end
    else begin
        IF_ID_NPC <= PC + 4;
        IF_ID_IR <= im_instr;
    end
end

// ID段
assign ID_instr_imm = {{16{IF_ID_IR[15]}}, IF_ID_IR[15:0]};
assign ID_instr_25_0_sll_2 = IF_ID_IR << 2;
//// 寄存器文件
register_file register_file(.clk(clk),
                            .rst(rst),
                            .ra1(IF_ID_IR[25:21]),
                            .rd1(rf_rd1),
                            .ra2(IF_ID_IR[20:16]),
                            .rd2(rf_rd2),
                            .dbu_ra(DBU_mem_rf_addr),
                            .dbu_rd(DBU_rf_data),
                            .we(MEM_WB_WB[0]),
                            .wa(MEM_WB_WA),
                            .wd(WB_wb_data));
//// ID/EX 段间寄存器                
always @(posedge clk, posedge rst) begin
    if(rst) begin 
        // 控制信号
        ID_EX_WB <= 32'h0000_0000;
        ID_EX_M <= 32'h0000_0000;
        ID_EX_EX <= 32'h0000_0000;
        // NPC
        ID_EX_NPC <= 32'h0000_0000;
        // A, B, IMM, IR
        ID_EX_A <= 32'h0000_0000;
        ID_EX_B <= 32'h0000_0000;
        ID_EX_IMM <= 32'h0000_0000;
        ID_EX_IR <= 32'h0000_0000;
    end
    else begin
        // 控制信号
        ID_EX_WB <= ctrl_wb;
        ID_EX_M <= ctrl_m;
        ID_EX_EX <= ctrl_ex;
        // NPC
        ID_EX_NPC <= IF_ID_NPC;
        // A, B, IMM, IR
        ID_EX_A <= rf_rd1;
        ID_EX_B <= rf_rd2;
        ID_EX_IMM <= ID_instr_imm;
        ID_EX_IR <= IF_ID_IR;
    end
end

//// 控制单元
control_unit ctrl_unit(.opcode(IF_ID_IR[31:26]),
                       .WB(ctrl_wb),
                       .M(ctrl_m),
                       .EX(ctrl_ex),
                       .pc_src(pc_src));

//// 跳转指令等的PC赋值
assign pc_we = 1'b1;
always @(posedge clk, posedge rst) begin
    if(rst) begin
        PC <= 32'h0000_0000;
    end
    else begin
        if(pc_we) begin
            case(pc_src)
                2'b00: PC <= PC + 4;
                2'b01: PC <= IF_ID_NPC + (ID_instr_imm << 2);
                2'b10: PC <= {IF_ID_NPC[31: 28], ID_instr_25_0_sll_2};
                default: PC <= PC;
            endcase
        end
        else PC <= PC;
    end
end


// EX段
reg [31:0] alu_a;
reg [31:0] alu_b;
wire [2:0] alu_m;
wire [31:0] alu_y;

assign alu_a_src = 2'b00;
assign alu_b_src = 2'b01;

always @(*) begin
    case(alu_a_src)
        2'b00: alu_a = ID_EX_A;
        2'b10: alu_a = WB_wb_data;
        2'b11: alu_a = EX_MEM_Y;
        default: alu_a = ID_EX_A;
    endcase
    case(alu_b_src)
        2'b00: alu_b = ID_EX_B;
        2'b01: alu_b = ID_EX_IMM;
        2'b10: alu_b = WB_wb_data;
        2'b11: alu_b = EX_MEM_Y;
        default: alu_b = ID_EX_A;
    endcase
end
alu_control alu_control(.funct(ID_EX_IR[5:0]),
                        .alu_op(ID_EX_EX[2:1]),
                        .alu_m(alu_m));
ALU ALU(.y(alu_y),
        .zf(alu_zf),
        .cf(alu_cf),
        .of(alu_of),
        .a(alu_a),
        .b(alu_b),
        .m(alu_m));
 
 always @(posedge clk, posedge rst) begin
    if(rst) begin
        // 控制信号
        EX_MEM_WB <= 32'h0000_0000;
        EX_MEM_M <= 32'h0000_0000;
        // ALU 的 ZF 和 Y
        EX_MEM_ZF <= 32'h0000_0000;
        EX_MEM_Y <= 32'h0000_0000;
        EX_MEM_B <= 32'h0000_0000;
        EX_MEM_WA <= 32'h0000_0000;
    end
    else begin
        // 控制信号
        EX_MEM_WB <= ID_EX_WB;
        EX_MEM_M <= ID_EX_M;
        // ALU 的 ZF 和 Y
        EX_MEM_ZF <= alu_zf;
        EX_MEM_Y <= alu_y;
        EX_MEM_B <= ID_EX_B;
        EX_MEM_WA <= ID_EX_EX[0] == 1'b0 ? ID_EX_IR[20:16] : ID_EX_IR[15:11];
    end
end

// MEM段
data_mem_256x32 data_mem(.a(EX_MEM_Y),
                         .d(EX_MEM_B),
                         .dpra(DBU_mem_rf_addr),
                         .clk(clk),
                         .we(EX_MEM_M[1]),
                         .spo(mem_out_rd),
                         .dpo(DBU_mem_data));
always @(posedge clk, posedge rst) begin
    if(rst) begin 
        MEM_WB_WB <= 32'h0000_0000;
        MEM_WB_MDR <= 32'h0000_0000;
        MEM_WB_Y <= 32'h0000_0000;
        MEM_WB_WA <= 5'h00000;
    end
    else begin
        MEM_WB_WB <= EX_MEM_WB;
        MEM_WB_MDR <= mem_out_rd;
        MEM_WB_Y <= EX_MEM_Y;
        MEM_WB_WA <= EX_MEM_WA;
    end
end

// WB段
assign WB_wb_data = MEM_WB_WB[1] == 1'b0 ? MEM_WB_Y : MEM_WB_MDR;

// 转发控制器
 

endmodule
