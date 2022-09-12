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
		
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) begin
			counter <=16'b0;
			for (i = 0; i < 4; i = i+1) begin
				key[i] <= 32'b0;
				plaintext[i] <= 32'b0;
			end
		end
		else begin
			if (wr_en & accel_select) begin
				for (i = 0; i < 4; i = i + 1) begin
					key[i] <= (addr[6:2] == i + 10) ? data_in : key[i];
					plaintext[i] <= (addr[6:2] == i + 14) ? data_in : plaintext[i];
				end
				// key[1] <= (addr[6:2] == 5'd003) ? data_in : key[1];
				// key[2] <= (addr[6:2] == 5'd004) ? data_in : key[2];
				// key[3] <= (addr[6:2] == 5'd005) ? data_in : key[3];
				// plaintext[1] <= (addr[6:2] == 5'd007) ? data_in : plaintext[1];
				// plaintext[2] <= (addr[6:2] == 5'd008) ? data_in : plaintext[2];
				// plaintext[3] <= (addr[6:2] == 5'd009) ? data_in : plaintext[3];
				// cyphertext[1] <= (addr[6:2] == 5'd011) ? data_in : cyphertext[1];
				// cyphertext[2] <= (addr[6:2] == 5'd012) ? data_in : cyphertext[2];
				// cyphertext[3] <= (addr[6:2] == 5'd013) ? data_in : cyphertext[3];
			end
			else begin
				for (i = 0; i < 4; i = i + 1) begin
					key[i] <= key[i];
					plaintext[i] <= plaintext[i];
				end
			end
			counter <= go_bit_in? 16'h00 : done_bit_in ? counter : counter +16'h01;
		end
		
	 		
	 always @(key, counter) begin
		case(counter)
		16'd0: 	in1 = key[0][7:0];
		16'd1:	in1 = key[0][15:8];
		16'd2: 	in1 = key[0][23:16];
		16'd3:	in1 = key[0][31:24];
		default: in1 = key[0][7:0];
		endcase
	 end
	
	  always @(plaintext, counter) begin
		case(counter)
		16'd0: 	in2 = plaintext[0][7:0];
		16'd1:	in2 = plaintext[0][15:8];
		16'd1:	in2 = plaintext[0][23:16];
		16'd1:	in2 = plaintext[0][31:24];
		default: in2 = plaintext[0][7:0];
		endcase
	 end
	 
	 
	 multiplier mul(.a(in1), .b(in2), .c(out));
	 
	reg [31:0] cyphertext_in[3:0];
	
	always @* begin
		case(counter[3:0])
		4'd0: cyphertext_in[0] = {cyphertext[0][31:8], out};
		4'd1: cyphertext_in[0] = {cyphertext[0][31:16], out, cyphertext[0][7:0]};
		4'd2: cyphertext_in[0] = {cyphertext[0][31:24], out, cyphertext[0][15:0]};
		4'd3: cyphertext_in[0] = {out, cyphertext[0][24:0]};
		default: cyphertext_in[0] = cyphertext_in[0];
		endcase
	end

//	assign cyphertext_in[0] = (counter != 16'd4) ? cyphertext[0] ^ (8'b11111111 << (8 * counter)) : cyphertext[0];
	 
							 
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) cyphertext[0] <= 32'h0;
		else cyphertext[0] <= cyphertext_in[0];
	 	 	 
	 assign done_bit_in = (counter == 16'd4);
	 
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) done_bit <= 1'b0;
		else done_bit <= go_bit_in ? 1'b0 : done_bit_in;
	 
endmodule