`timescale 1ns/1ps
`include "aes_lookups.hv"


module multiplier
(
	input logic [7:0] a,
	input logic [7:0] b,
	output logic [7:0] c
);
	assign c= a * b;

endmodule


// Module Declaration
module encryptor
(
	input logic rst_n, // Reset Neg
	input logic clk, // Clk
	input logic [31:0] addr, // Address
	input logic wr_en, //Write enable
	input logic accel_select,
	input logic [31:0] data_in,
	output logic [31:0] data_out, // Output Data
	output logic [15:0] ctr
    );
	
	logic go_bit;
	logic go_bit_in;
	logic done_bit;
	logic done_bit_in;

	logic [15:0] counter;
	
	logic [31:0] key[3:0];
	logic [31:0] expanded_key[3:0];
	logic [31:0] plaintext[3:0];
	logic [31:0] cyphertext[3:0];

	
	logic [7:0] in1, in2;
	logic[7:0] out;

	assign ctr = counter;
	
	integer i;
	
	always @(addr[6:2], key, plaintext, cyphertext, counter, done_bit, go_bit, counter) begin
	case(addr[6:2])
	5'd008: data_out = {done_bit, 30'b0, go_bit};
	5'd009: data_out = {16'b0, counter}; 
	5'd010: data_out = key[0];
	5'd011: data_out = key[1];
	5'd012: data_out = key[2];
	5'd013: data_out = key[3];
	5'd014: data_out = plaintext[0];
	5'd015: data_out = plaintext[1];
	5'd016: data_out = plaintext[2];
	5'd017: data_out = plaintext[3];
	5'd018: data_out = cyphertext[0];
	5'd019: data_out = cyphertext[1];
	5'd020: data_out = cyphertext[2];
	5'd021: data_out = cyphertext[3];
	default: data_out = 32'b0;
	endcase
	end
	
	assign go_bit_in = (wr_en & accel_select & (addr[6:2] == 5'd0008));

	always @(posedge clk or negedge rst_n)
	if(~rst_n) go_bit <= 1'b0;
	else go_bit <=  go_bit_in ? 1'b1 : 1'b0;
	
	always @(posedge clk or negedge rst_n) begin
	counter <= go_bit_in? 16'h00 : done_bit_in ? counter : counter +16'h01;
	if(~rst_n) begin
		counter <= 16'b0;
		for (i = 0; i < 4; i = i+1) begin
			key[i] <= 32'b0;
			plaintext[i] <= 32'b0;
		end
	end
	else if (wr_en & accel_select) begin
		for (i = 0; i < 4; i = i + 1) begin
			key[i] <= (addr[6:2] == i + 10) ? data_in : key[i];
			plaintext[i] <= (addr[6:2] == i + 14) ? data_in : plaintext[i];
		end
	end
	else begin
		for (i = 0; i < 4; i = i + 1) begin
			key[i] <= key[i];
			plaintext[i] <= plaintext[i];
		end
	end
	end
	
		
	always @(key, counter) begin
		case(counter)
		16'd0: 	in1 <= key[0][7:0];
		16'd1:	in1 <= key[0][15:8];
		16'd2: 	in1 <= key[0][23:16];
		16'd3:	in1 <= key[0][31:24];
		default: in1 <= key[0][7:0];
		endcase
	end

	always@(plaintext, counter) begin
		case(counter)
		16'd0: 	in2 <= plaintext[0][7:0];
		16'd1:	in2 <= plaintext[0][15:8];
		16'd2:	in2 <= plaintext[0][23:16];
		16'd3:	in2 <= plaintext[0][31:24];
		default: in2 <= plaintext[0][7:0];
		endcase
	end
	
	
	multiplier mul(.a(in1), .b(in2), .c(out));
	
	logic [31:0] cyphertext_in[3:0];

	always_comb begin
	case(counter[3:0])
		4'd0: cyphertext_in[0] = {cyphertext[0][31:8], out};
		4'd1: cyphertext_in[0] = {cyphertext[0][31:16], out, cyphertext[0][7:0]};
		4'd2: cyphertext_in[0] = {cyphertext[0][31:24], out, cyphertext[0][15:0]};
		4'd3: cyphertext_in[0] = {out, cyphertext[0][23:0]};
		default: cyphertext_in[0] = cyphertext_in[0];
		endcase
	end	 
							
	always @(posedge clk or negedge rst_n)
		if(~rst_n) cyphertext[0] <= 32'h0;
		else cyphertext[0] <= cyphertext_in[0];
			
	assign done_bit_in = (counter == 16'd4);
	
	always @(posedge clk or negedge rst_n)
		if(~rst_n) done_bit <= 1'b0;
		else done_bit <= go_bit_in ? 1'b0 : done_bit_in;
	 
endmodule