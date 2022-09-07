`timescale 1ns/1ps


module multiplier
(
	a,b, c
);

	input [7:0] a;
	input [7:0] b;
	output [7:0] c;
	
	assign c= a * b;

endmodule


// Module Declaration
module ai_accel
(
        rst_n		,  // Reset Neg
        clk,             // Clk
        addr		,  // Address
		  wr_en,		//Write enable
		  accel_select,
		  data_in,
		  ctr,
        data_out	   // Output Data
    );
	 
	 input rst_n;
	 input clk;
	 input [31:0] addr;
	 input wr_en;
	 input accel_select;
	 input [31:0] data_in;
	 output [31:0] data_out;
	 output [15:0] ctr;
	 
	 
	 reg [31:0] data_out;
 
	 reg go_bit;
	 wire go_bit_in;
	 reg done_bit;
	 wire done_bit_in;

	 reg [15:0] counter;
	 
	 reg [31:0] key[3:0];
	 reg [31:0] plaintext[3:0];
	 wire [31:0] w_cyphertext[3:0];
	 reg [31:0] cyphertext[3:0];

	 
	 reg [7:0] in1, in2;
	 wire[7:0] out;

	 assign ctr = counter;
	 
	 always @(addr[4:2], data_A, data_B, data_C, counter, done_bit, go_bit, counter) begin
		case(addr[4:2])
		3'b000: data_out = {done_bit, 30'b0, go_bit};
		3'b001: data_out = {16'b0, counter}; 
		3'b010: data_out = data_A;
		3'b011: data_out = data_B;
		3'b100: data_out = data_C;
		default: data_out = 32'b0;
		endcase
	 end
	 
	 assign go_bit_in = (wr_en & accel_select & (addr[4:2] == 3'b000));
	
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) go_bit <= 1'b0;
		else go_bit <=  go_bit_in ? 1'b1 : 1'b0;
		
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) begin
			counter <=16'b0;
			data_A <= 32'b0;
			data_B <= 32'b0;
		end
		else begin
			if (wr_en & accel_select) begin
				data_A <= (addr[4:2] == 3'b010) ? data_in : data_A;
				data_B <= (addr[4:2] == 3'b011) ? data_in : data_B;
			end
			else begin
				data_A <= data_A;
				data_B <= data_B;
			end
			counter <= go_bit_in? 16'h00 : done_bit_in ? counter : counter +16'h01;
		end
		
	 		
	 always @(data_A, counter) begin
		case(counter)
		16'b0: 	in1 = data_A[7:0];
		16'b1:	in1 = data_A[15:8];
		default: in1 = data_A[7:0];
		endcase
	 end
	
	  always @(data_B, counter) begin
		case(counter)
		32'b0: 	in2 = data_B[7:0];
		32'b1:	in2 = data_B[15:8];
		default: in2 = data_B[7:0];
		endcase
	 end
	 
	 
	 multiplier mul(.a(in1), .b(in2), .c(out));
	 
	wire [31:0] result_in;

	assign result_in = (counter==16'd0) ? {result[31:8], out} : 
							(counter==16'd1) ? {result[31:16], out, result[7:0]}:
							 result;
							 
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) result <=32'h0;
		else result <= result_in;
	 	 
	 assign data_C = result;
	 
	 assign done_bit_in = (counter == 16'd2);
	 
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) done_bit <= 1'b0;
		else done_bit <= go_bit_in ? 1'b0 : done_bit_in;
	 
endmodule