`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/23 22:12:56
// Design Name: 
// Module Name: register
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


module register
    # (parameter WIDTH = 4)
    (
    input [WIDTH-1 : 0] data,   // ��������
    input en,   // ʹ���ź�
    input rst,  // ��λ�ź�
    input clk,  // ʱ���ź�
    output reg [WIDTH-1: 0] r   // �������
    );
    
    always @(posedge clk or posedge rst)
    begin
        if(rst) r <= {WIDTH{1'b0}};
        else if(en) r <= data;
        else r <= r;
    end
    
endmodule
