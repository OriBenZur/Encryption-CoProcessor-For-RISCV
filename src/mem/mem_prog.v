`timescale 1ns/1ps
 
 
`ifdef CUSTOM_DEFINE
    `include "../defines.vh"
`endif 

// Module Declaration
module progMem
	`ifdef CUSTOM_DEFINE 
		#(parameter ADDR_WIDTH = `I_MEM_ADDR_WIDTH,
        parameter DATA_WIDTH = `I_MEM_DATA_WIDTH,
        parameter MEM_DEPTH = `I_MEM_DEPTH) 
	`else
		#(parameter ADDR_WIDTH = 11,
        parameter DATA_WIDTH = 32,
        parameter MEM_DEPTH = 2048) 
	`endif
	(
        rst_n,  		// Reset Neg
        clk,    		// Clk
        addr,   		// Address
        data_out	   // Output Data
    );
	
	// Inputs
	input rst_n; 
	input clk;
	//input [14:0]	addr;
	input [ADDR_WIDTH-1:0]	addr[1:0];

	// Outputs
	output [DATA_WIDTH-1:0] data_out[1:0];
	
	// Internal
	//reg [DATA_WIDTH-1:0] progArray[0:8191]; 
	reg [DATA_WIDTH-1:0] progArray[0:MEM_DEPTH-1]; 

		
	wire [31:0] d_out [1:0] = '{progArray[addr[0] >> 2], progArray[addr[1] >> 2]};
	
	//`define BIG_END_IMG
	
	`ifdef BIG_END_IMG
	assign data_out = d_out;
	`else
	assign data_out = '{{d_out[0][7:0], d_out[0][15:8], d_out[0][23:16], d_out[0][31:24]}, {d_out[1][7:0], d_out[1][15:8], d_out[1][23:16], d_out[1][31:24]}};
	`endif
	
	always @ (posedge clk or negedge rst_n)
	begin : MEM_READ
		integer j;
		if ( !rst_n ) begin
			//for (j=0; j < MEM_DEPTH; j=j+1) begin
			//	progArray[j] <= 0; //reset array
			//end
			`ifdef LOAD_MEMS
				// Load memory
				//$readmemb("../../data/programMem_b.mem", progArray, 0, 10);
				//$readmemh("../../data/programMem_h.mem", progArray);
				  $readmemh("./test.hex", progArray);
				//$readmemh("C:/SysGCC/risc-v/bin/test.hex", progArray);  		
				//$readmemh("../../data/programMem_h_complete.mem", progArray, 0, 342);
			`endif
		end
	end
	
	
endmodule
	
	
	
 