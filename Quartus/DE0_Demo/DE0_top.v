// --------------------------------------------------------------------
// Copyright (c) 2009 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE0 Button Debounce
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
// Ver:| Author : Allen Wang  | Mod. Date : 2010/07/27 | Changes Made:
// --------------------------------------------------------------------

//`include "../../src/top.v"


module DE0_top
	(
		////////////////////	Clock Input	 	////////////////////	 
		MAX10_CLK1_50,						//	50 MHz
		MAX10_CLK2_50_2,						//	50 MHz
		////////////////////	Push Button		////////////////////
		ORG_KEY,						//	Pushbutton[2:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[9:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		LEDR							//	LED Red[9:0]
	);

////////////////////////	Clock Input	 	////////////////////////
input			MAX10_CLK1_50;				//	50 MHz
input			MAX10_CLK2_50_2;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	[1:0]	ORG_KEY;				//	Pushbutton[2:0]
////////////////////////	DPDT Switch		////////////////////////
input	[9:0]	SW;						//	Toggle Switch[9:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5

////////////////////////////	LED		////////////////////////////
output 	[9:0]	LEDR;					//	LED Red[9:0]





//==================================================================
//  REG/WIRE declarations
//==================================================================
//assign LEDR = 10'b1010101010;
//wire  [9:0] led;

wire	[1:0]	ORG_KEY;         		// Button 

wire            reset_n;        		// Reset
wire            BUTTON[0:1];		// Button after debounce

wire    		counter_1;      		// Counter for Button[1]
wire    		counter_2;      		// Counter for Button[2]

wire    [3:0] 	 iDIG_0;        		// 7SEG 0 
wire    [3:0] 	 iDIG_1;         		// 7SEG 1
wire    [3:0]   iDIG_2;
wire    [3:0]   iDIG_3;
wire    [3:0]   iDIG_4;
wire    [3:0]   iDIG_5;
wire    [3:0] 	 iDIG_0_o;        		// 7SEG 0 
wire    [3:0] 	 iDIG_1_o;         		// 7SEG 1
wire    [3:0]   iDIG_2_o;
wire    [3:0]   iDIG_3_o;
wire    [3:0]   iDIG_4_o;
wire    [3:0]   iDIG_5_o;

reg       		out_BUTTON_1;   		// Button1 Register output
reg       		out_BUTTON_2;   		// Button2 Register output

reg            virtual_clk;       // Virtual clock to slow the processor
wire           clock_to_core;
wire           clock_to_mem;
wire 	[15:0]	ctr;

reg [21:0] count_reg = 0;
reg out_10hz = 0;
reg clk_delay = 0;
//==================================================================
//  Structural coding
//==================================================================

PLL PLL_instance(
	.inclk0(MAX10_CLK1_50),
	.c0(PLL_1MHzclock));

TestPLL MemPLL(
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clock_to_mem )
	);


// This is BUTTON[0] Debounce Circuit //
button_debouncer	button_debouncer_inst0(
	.clk     (PLL_1MHzclock),
	.rst_n   (1'b1),
	.data_in (ORG_KEY[0]),
	.data_out(BUTTON[0])			
	);
	
// This is BUTTON[1] Debounce Circuit //
button_debouncer	button_debouncer_inst1(
	.clk     (PLL_1MHzclock),
	.rst_n   (1'b1),
	.data_in (ORG_KEY[1]),
	.data_out(BUTTON[1])			
	);
	
//// This is BUTTON[2] Debounce Circuit // ~Ori
//button_debouncer	button_debouncer_inst2(
//	.clk     (PLL_1MHzclock),
//	.rst_n   (1'b1),
//	.data_in (ORG_BUTTON[2]),
//	.data_out(BUTTON[2])			
//	);

// This is SEG0 Display//
SEG7_LUT	SEG0(
				 .oSEG   (HEX0),
				 .oSEG_DP(),
				 .iDIG   (iDIG_0)
				 );
				 
// This is SEG1 Display//
SEG7_LUT	SEG1(
				 .oSEG   (HEX1),
				 .oSEG_DP(),
				 .iDIG   (iDIG_1)
				 );
				 
// This is SEG2 Display//
SEG7_LUT	SEG2(
				 .oSEG   (HEX2),
				 .oSEG_DP(),
				 .iDIG   (iDIG_2)
				 );
				 
// This is SEG3 Display//				 
SEG7_LUT	SEG3(
				 .oSEG   (HEX3),
				 .oSEG_DP(),
				 .iDIG   (iDIG_3)
				  );	
				  
// This is SEG3 Display//				 
SEG7_LUT	SEG4(
				 .oSEG   (HEX4),
				 .oSEG_DP(),
				 .iDIG   (iDIG_4)
				  );
				  
				  // This is SEG3 Display//				 
SEG7_LUT	SEG5(
				 .oSEG   (HEX5),
				 .oSEG_DP(),
				 .iDIG   (iDIG_5)
				  );


// `ifdef CUSTOM_DEFINE
// 		  parameter ADDR_WIDTH = `MEM_ADDR_WIDTH;
// 		  parameter I_ADDR_WIDTH = `I_MEM_ADDR_WIDTH;
//         parameter DATA_WIDTH = `REG_DATA_WIDTH;
//         parameter TRANSFER_WIDTH = `MEM_TRANSFER_WIDTH;
// `else
		parameter ADDR_WIDTH = 11;
		parameter I_ADDR_WIDTH = 15;
        parameter DATA_WIDTH = 32;
        parameter TRANSFER_WIDTH = 4;
// `endif

    wire we_mem_data[0:1];
    wire [ADDR_WIDTH-1 : 0] addr_mem_data[0:1];
    wire [DATA_WIDTH-1 : 0] val_mem_data_write[0:1];
    wire [DATA_WIDTH-1 : 0] val_mem_data_read[0:1];
	wire [DATA_WIDTH-1 : 0] val_mem_data_read_ram[0:1];
    wire [I_ADDR_WIDTH-1 : 0] addr_mem_prog[0:1];
	//wire [ADDR_WIDTH-1 : 0] addr_mem_prog;
    wire [DATA_WIDTH-1 : 0] val_mem_prog[0:1];
    wire  [TRANSFER_WIDTH-1:0] write_transfer[0:1];
	wire PLL_1MHzclock;
	wire cpu_encryptor_select[0:1];
	wire [31:0] lock_data_out[0:1];
	 
	 
	// Encryptor wires
	wire [ADDR_WIDTH-1:0] encryptor_addr_in;
	wire [DATA_WIDTH-1:0] encryptor_data_in;
	wire [DATA_WIDTH-1:0] encryptor_data_out;
	wire encryptor_select;
	wire encryptor_we_mem_data;



//assign val_mem_data_read = val_mem_data_read_ram;

core #(.MEM_ADDR_WIDTH(ADDR_WIDTH), .I_MEM_ADDR_WIDTH(I_ADDR_WIDTH)) core0(
        .clk (clock_to_core),
        .rst_n (reset_n),
        .we_mem_data_o (we_mem_data[0]),
        .addr_mem_data_o (addr_mem_data[0]),
        .val_mem_data_read_i (val_mem_data_read[0]),
        .val_mem_data_write_o (val_mem_data_write[0]),
        .addr_mem_prog_o (addr_mem_prog[0]),
        .val_mem_prog_i (val_mem_prog[0]),
        .write_transfer_mem_data_o (write_transfer[0])
    );
	 
core #(.INIT_SP(32'd512), .MEM_ADDR_WIDTH(ADDR_WIDTH), .I_MEM_ADDR_WIDTH(I_ADDR_WIDTH)) core1(
        .clk (clock_to_core),
        .rst_n (reset_n),
        .we_mem_data_o (we_mem_data[1]),
        .addr_mem_data_o (addr_mem_data[1]),
        .val_mem_data_read_i (val_mem_data_read[1]),
        .val_mem_data_write_o (val_mem_data_write[1]),
        .addr_mem_prog_o (addr_mem_prog[1]),
        .val_mem_prog_i (val_mem_prog[1]),
        .write_transfer_mem_data_o (write_transfer[1])
    );

`define CORE_INDEX_ADDR 32'h020
reg [DATA_WIDTH-1:0] i;

always@* begin 
	for (i = 0; i < 2; i = i + 1) begin
		if (cpu_encryptor_select[i])
			val_mem_data_read[i] = lock_data_out[i];
		else if (addr_mem_data[0] == `CORE_INDEX_ADDR)
			val_mem_data_read[i] = i;
		else
			val_mem_data_read[i] = val_mem_data_read_ram[i];
	end
end

//set LOAD_MEMS to true to load mems

`define MEM

`ifdef MEM

new_ram	mem_data_max10 (
	.address_a(addr_mem_data[0][ADDR_WIDTH-1 : 2]),
	.address_b(addr_mem_data[1][ADDR_WIDTH-1 : 2]),
	.byteena_a(write_transfer[0]),
	.byteena_b(write_transfer[1]),
	.clock(clock_to_mem),
	.data_a(val_mem_data_write[0]),
	.data_b(val_mem_data_write[1]),
	.wren_a(we_mem_data[0]),
	.wren_b(we_mem_data[1]),
	.q_a(val_mem_data_read_ram[0]),
	.q_b(val_mem_data_read_ram[1])
	);

`else

dataMem mem_data_de0 (
        .rst_n		(reset_n)			,  // Reset Neg
        .clk		(clock_to_core)	,
        .we			(we_mem_data)	,  // Write Enable
        .addr		(addr_mem_data)	,  // Address
        .data_in	(val_mem_data_write),  //  Data in
        .data_out   (val_mem_data_read_ram),  //data out
        .write_transfer_i (write_transfer) // write Byte mask
    );
`endif



	

`ifdef MEM

new_prog_mem	new_prog_mem_inst (
	.address_a ( addr_mem_prog[0][I_ADDR_WIDTH-1:2] ),
	.address_b ( addr_mem_prog[1][I_ADDR_WIDTH-1:2] ),
	.clock ( clock_to_mem ),
	.q_a ( val_mem_prog[0] ),
	.q_b ( val_mem_prog[1] )
	);
	 
`else
progMem mem_prog_de0 (
        .rst_n (reset_n)		,  // Reset Neg
        .clk (clock_to_core),             // Clk
        .addr (addr_mem_prog)		,  // Address - This is the problem
        .data_out (val_mem_prog)	   // Output Data
    );

`endif


// assign iDIG_0    = SW[2] ? iDIG_0_o : addr_mem_prog[0][3:0];
// assign iDIG_1    = SW[2] ? iDIG_1_o : addr_mem_prog[0][7:4];
// assign iDIG_2    = SW[2] ? iDIG_2_o : addr_mem_prog[0][11:8]; 
// assign iDIG_3    = SW[2] ? iDIG_3_o : addr_mem_prog[0][I_ADDR_WIDTH-1:12];
// assign iDIG_4    = SW[2] ? iDIG_4_o : 4'h0;
// assign iDIG_5    = SW[2] ? iDIG_5_o : clock_to_core ? 4'b1 : 4'b0;

always@* begin 
	case(SW[8:2])
	6'd1: begin 
		iDIG_0 = addr_mem_prog[SW[9]][3:0];
		iDIG_1 = addr_mem_prog[SW[9]][7:4];
		iDIG_2 = addr_mem_prog[SW[9]][11:8];
		iDIG_3 = addr_mem_prog[SW[9]][I_ADDR_WIDTH-1:12];
		iDIG_4 = 4'h0;
		iDIG_5 = (clock_to_core ? 4'b1 : 4'b0);
	end
	6'd2: begin 
		iDIG_0 = val_mem_data_write[SW[9]][3:0];
		iDIG_1 = val_mem_data_write[SW[9]][7:4];
		iDIG_2 = val_mem_data_write[SW[9]][11:8]; 
		iDIG_3 = val_mem_data_write[SW[9]][15:12];
		iDIG_4 = val_mem_data_write[SW[9]][19:16];
		iDIG_5 = val_mem_data_write[SW[9]][23:20];
	end
	6'd3: begin 
		iDIG_0 = val_mem_prog[SW[9]][3:0];
		iDIG_1 = val_mem_prog[SW[9]][7:4];
		iDIG_2 = val_mem_prog[SW[9]][11:8]; 
		iDIG_3 = val_mem_prog[SW[9]][15:12];
		iDIG_4 = val_mem_prog[SW[9]][19:16];
		iDIG_5 = val_mem_prog[SW[9]][23:20];
	end
	6'd4: begin 
		iDIG_0 = addr_mem_data[SW[9]][3:0];
		iDIG_1 = addr_mem_data[SW[9]][7:4];
		iDIG_2 = addr_mem_data[SW[9]][ADDR_WIDTH-1:8]; 
		iDIG_3 = {3'b0, we_mem_data[SW[9]]};
		iDIG_4 = write_transfer[SW[9]];
		iDIG_5 = (clock_to_core ? 4'b1 : 4'b0);
	end
	6'd5: begin 
		iDIG_0 = val_mem_data_read[SW[9]][3:0];
		iDIG_1 = val_mem_data_read[SW[9]][7:4];
		iDIG_2 = val_mem_data_read[SW[9]][11:8]; 
		iDIG_3 = val_mem_data_read[SW[9]][15:12];
		iDIG_4 = val_mem_data_read[SW[9]][19:16];
		iDIG_5 = val_mem_data_read[SW[9]][23:20];
	end
	default: begin
		iDIG_0 = iDIG_0_o;
		iDIG_1 = iDIG_1_o;
		iDIG_2 = iDIG_2_o;
		iDIG_3 = iDIG_3_o;
		iDIG_4 = iDIG_4_o;
		iDIG_5 = iDIG_5_o;
	end
	endcase
end

// assign iDIG_0    = SW[2] ? addr_mem_prog[0][3:0] 				:	val_mem_data_write[0][3:0];
// assign iDIG_1    = SW[2] ? addr_mem_prog[0][7:4] 				: 	val_mem_data_write[0][7:4];
// assign iDIG_2    = SW[2] ? addr_mem_prog[0][11:8] 				: 	val_mem_data_write[0][11:8]; 
// assign iDIG_3    = SW[2] ? addr_mem_prog[0][I_ADDR_WIDTH-1:12]	: 	val_mem_data_write[0][15:12];
// assign iDIG_4    = SW[2] ? 4'h0 								: 	val_mem_data_write[0][19:16];
// assign iDIG_5    = SW[2] ? (clock_to_core ? 4'b1 : 4'b0) 		: 	val_mem_data_write[0][23:20];

assign reset_n   = BUTTON[0]; 
assign clock_to_core = (SW[0] ?  (SW[1])? out_10hz:PLL_1MHzclock :virtual_clk);	 		 

//====================================================================
// After debounce output with register
//====================================================================

always @ (posedge PLL_1MHzclock )
	begin
//		out_BUTTON_2 <= BUTTON[2]; ~Ori
		out_BUTTON_1 <= BUTTON[1];
	end

	
always @ (negedge out_BUTTON_1 )
	begin
		if (virtual_clk) virtual_clk = 1'b0;
		else virtual_clk = 1'b1;
	end

`define LEDS_ADDR_START 32'h010
`define LEDS_ADDR_LAST  32'h014
wire leds_select;

assign leds_select = (addr_mem_data[1]>=`LEDS_ADDR_START) & (addr_mem_data[1]<=`LEDS_ADDR_LAST);

leds_mgmt leds_mgmt_display
(
        .rst_n(reset_n)		,
        .clk(clock_to_core),
        .addr(addr_mem_data[0]),
		  .wr_en(we_mem_data[0]),
		  .select(leds_select),
		  .data_in(val_mem_data_write[0]),
        .leds_out(LEDR),
		  .sevseg0(iDIG_0_o),
		  .sevseg1(iDIG_1_o),
		  .sevseg2(iDIG_2_o),
		  .sevseg3(iDIG_3_o),
		  .sevseg4(iDIG_4_o),
		  .sevseg5(iDIG_5_o)
    );

// generate 100 Hz from 50 MHz



always @(posedge PLL_1MHzclock or negedge reset_n) begin
    if (!reset_n) begin
        count_reg <= 0;
        out_10hz <= 0;
    end else begin
        if (count_reg < 599999) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 0;
            out_10hz <= ~out_10hz;
        end
    end
end


`define ENCRYPTOR_ADDR_START 32'h024
`define ENCRYPTOR_ADDR_LAST  32'h05E
assign cpu_encryptor_select = '{(addr_mem_data[0]>=`ENCRYPTOR_ADDR_START) & (addr_mem_data[0]<=`ENCRYPTOR_ADDR_LAST), (addr_mem_data[1]>=`ENCRYPTOR_ADDR_START) & (addr_mem_data[1]<=`ENCRYPTOR_ADDR_LAST)};


lock #(.N_CLIENTS(32'd2), .LOCK_ADDR(32'h5C)) encryptor_lock
(
	.rst_n(reset_n),
    .clk(clock_to_core),
    .addr_in(addr_mem_data),
    .wr_en_in(we_mem_data),
    .select_in(cpu_encryptor_select),
    .data_in(val_mem_data_write),

    .data_from_accel(encryptor_data_out), // input from the accelerator
    .data_to_accel(encryptor_data_in), // input from the accelerator
    .addr_o(encryptor_addr_in),
    .wr_en_o(encryptor_we_mem_data), //Write enable
    .accel_select_o(encryptor_select), 

    .data_out(lock_data_out) // Output Data // fix
);


encryptor #(.ENCRYPTOR_ADDR(`ENCRYPTOR_ADDR_START)) encryption_CoProcessor
(
	.rst_n(reset_n),
	.clk(clock_to_core),
	.addr(encryptor_addr_in),
	.data_in(encryptor_data_in),
	.data_out(encryptor_data_out),
	.accel_select(encryptor_select),
	.wr_en(encryptor_we_mem_data),
	.ctr(ctr)
    );
endmodule