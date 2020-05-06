// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Thu Apr 23 23:39:45 2020
// Host        : DESKTOP-CK1FK5P running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               D:/VivadoProject/COD/Lab1/ALU/ALU.sim/sim_1/synth/func/xsim/sort_sim_func_synth.v
// Design      : sort
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CX01_1 = "3'b110" *) (* CX01_2 = "3'b100" *) (* CX01_3 = "3'b001" *) 
(* CX12_2 = "3'b101" *) (* CX12_3 = "3'b010" *) (* CX23_3 = "3'b011" *) 
(* HLT = "3'b111" *) (* LOAD = "3'b000" *) (* N = "4" *) 
(* NotValidForBitStream *)
module sort
   (s0,
    s1,
    s2,
    s3,
    done,
    x0,
    x1,
    x2,
    x3,
    clk,
    rst);
  output [3:0]s0;
  output [3:0]s1;
  output [3:0]s2;
  output [3:0]s3;
  output done;
  input [3:0]x0;
  input [3:0]x1;
  input [3:0]x2;
  input [3:0]x3;
  input clk;
  input rst;

  wire done;
  wire [3:0]s0;
  wire [3:0]s1;
  wire [3:0]s2;
  wire [3:0]s3;

  OBUFT done_OBUF_inst
       (.I(1'b0),
        .O(done),
        .T(1'b1));
  OBUFT \s0_OBUF[0]_inst 
       (.I(1'b0),
        .O(s0[0]),
        .T(1'b1));
  OBUFT \s0_OBUF[1]_inst 
       (.I(1'b0),
        .O(s0[1]),
        .T(1'b1));
  OBUFT \s0_OBUF[2]_inst 
       (.I(1'b0),
        .O(s0[2]),
        .T(1'b1));
  OBUFT \s0_OBUF[3]_inst 
       (.I(1'b0),
        .O(s0[3]),
        .T(1'b1));
  OBUFT \s1_OBUF[0]_inst 
       (.I(1'b0),
        .O(s1[0]),
        .T(1'b1));
  OBUFT \s1_OBUF[1]_inst 
       (.I(1'b0),
        .O(s1[1]),
        .T(1'b1));
  OBUFT \s1_OBUF[2]_inst 
       (.I(1'b0),
        .O(s1[2]),
        .T(1'b1));
  OBUFT \s1_OBUF[3]_inst 
       (.I(1'b0),
        .O(s1[3]),
        .T(1'b1));
  OBUFT \s2_OBUF[0]_inst 
       (.I(1'b0),
        .O(s2[0]),
        .T(1'b1));
  OBUFT \s2_OBUF[1]_inst 
       (.I(1'b0),
        .O(s2[1]),
        .T(1'b1));
  OBUFT \s2_OBUF[2]_inst 
       (.I(1'b0),
        .O(s2[2]),
        .T(1'b1));
  OBUFT \s2_OBUF[3]_inst 
       (.I(1'b0),
        .O(s2[3]),
        .T(1'b1));
  OBUFT \s3_OBUF[0]_inst 
       (.I(1'b0),
        .O(s3[0]),
        .T(1'b1));
  OBUFT \s3_OBUF[1]_inst 
       (.I(1'b0),
        .O(s3[1]),
        .T(1'b1));
  OBUFT \s3_OBUF[2]_inst 
       (.I(1'b0),
        .O(s3[2]),
        .T(1'b1));
  OBUFT \s3_OBUF[3]_inst 
       (.I(1'b0),
        .O(s3[3]),
        .T(1'b1));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
