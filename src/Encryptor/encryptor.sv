`timescale 1ns/1ps

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
	logic [13:0] round_counter;
	byte rc, rc_d;
	
	logic [31:0] key[3:0];
	logic [31:0] key_o;
	logic [31:0] plaintext[3:0];
	logic [31:0] cyphertext[3:0];
	integer i;
	// logic [31:0] cyphertext_in[3:0];

	
	// logic [7:0] in1, in2;
	// logic[7:0] out;

	assign ctr = counter;
	assign round_counter = counter / 4;
	assign go_bit_in = (wr_en & accel_select & (addr[6:2] == 5'd0008));
	
	key_expander key_scheduler
	(
		.rst_n(rst_n), // Reset Neg
		.clk(clk), // Clk
		.i(counter),
		.key_i_1(key[3]),
		.key_N_i(key[0]),
		.rc_i(rc_d),
		.rc_out(rc),
		.key_out(key_o)
	);
	
	// always_ff@(addr[6:2], key, plaintext, cyphertext, counter, done_bit, go_bit, counter) begin
	always_comb begin
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
	

	always@(posedge clk or negedge rst_n) begin
	if(~rst_n) go_bit <= 1'b0;
	else go_bit <=  go_bit_in ? 1'b1 : 1'b0;
	end
	
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			counter <= 16'b0;
			rc_d <= 0;
			for (i = 0; i < 4; i = i+1) begin
				key[i] <= 32'b0;
				plaintext[i] <= 32'b0;
			end
		end
		else begin
			counter <= go_bit_in? 16'h00 : done_bit_in ? counter : counter +16'h01;
			rc_d <= rc_d;
			for (i = 0; i < 4; i = i + 1) begin
				plaintext[i] <= plaintext[i];
				key[i] <= key[i];
			end
			if (wr_en & accel_select) begin
				for (i = 0; i < 4; i = i + 1) begin
					key[i] <= (addr[6:2] == i + 10) ? data_in : key[i];
					plaintext[i] <= (addr[6:2] == i + 14) ? data_in : plaintext[i];
				end
			end
			else if (counter > 0) begin
				for (i = 1; i < 4; i = i + 1) key[i-1] <= key[i];
				key[3] <= key_o;
				rc_d <= rc;
			end
		end
	end
	

	always@(posedge clk or negedge rst_n) begin
	if (~rst_n)
		for (i = 0; i < 4; i = i + 1) cyphertext[i] <= 0;
	else if (counter % 4 != 0);
	else if (round_counter == 0)
		for (i = 0; i < 4; i = i + 1) cyphertext[i] <= plaintext[i] ^ key[i];
	else if (round_counter < 10) begin
		cyphertext[0] <= A0[cyphertext[0][7:0]]^A1[cyphertext[1][15:8]]^A2[cyphertext[2][23:16]]^A3[cyphertext[3][31:24]]^key[0];
		cyphertext[1] <= A0[cyphertext[1][7:0]]^A1[cyphertext[2][15:8]]^A2[cyphertext[3][23:16]]^A3[cyphertext[0][31:24]]^key[1];
		cyphertext[2] <= A0[cyphertext[2][7:0]]^A1[cyphertext[3][15:8]]^A2[cyphertext[0][15:8]]^A3[cyphertext[1][31:24]]^key[2];
		cyphertext[3] <= A0[cyphertext[3][7:0]]^A1[cyphertext[0][15:8]]^A2[cyphertext[1][23:16]]^A3[cyphertext[2][31:24]]^key[3];
	end
	else begin//if (round_counter == 10) begin
		cyphertext[0] <= (s_box[cyphertext[0][7:0]] << 24) ^ {8'b0, (s_box[cyphertext[1][15:8]] << 16)} ^ {16'b0, (s_box[cyphertext[2][23:16]] << 8)} ^ {24'b0, s_box[cyphertext[3][31:24]]} ^ key[0];
		cyphertext[1] <= (s_box[cyphertext[1][7:0]] << 24) ^ {8'b0, (s_box[cyphertext[2][15:8]] << 16)} ^ {16'b0, (s_box[cyphertext[3][23:16]] << 8)} ^ {24'b0, s_box[cyphertext[0][31:24]]} ^ key[1];
		cyphertext[2] <= (s_box[cyphertext[2][7:0]] << 24) ^ {8'b0, (s_box[cyphertext[3][15:8]] << 16)} ^ {16'b0, (s_box[cyphertext[0][15:8]] << 8)} ^ {24'b0, s_box[cyphertext[1][31:24]]} ^ key[2];
		cyphertext[3] <= (s_box[cyphertext[3][7:0]] << 24) ^ {8'b0, (s_box[cyphertext[0][15:8]] << 16)} ^ {16'b0, (s_box[cyphertext[1][23:16]] << 8)} ^ {24'b0, s_box[cyphertext[2][31:24]]} ^ key[3];
	end
	end
	

	// always_comb begin
	// case(counter[3:0])
	// 	4'd0: cyphertext_in[0] = {cyphertext[0][31:8], out};
	// 	4'd1: cyphertext_in[0] = {cyphertext[0][31:16], out, cyphertext[0][7:0]};
	// 	4'd2: cyphertext_in[0] = {cyphertext[0][31:24], out, cyphertext[0][15:0]};
	// 	4'd3: cyphertext_in[0] = {out, cyphertext[0][23:0]};
	// 	default: cyphertext_in[0] = cyphertext_in[0];
	// 	endcase
	// end	 
							
	// always_ff@(posedge clk or negedge rst_n)
	// 	if(~rst_n) cyphertext[0] <= 32'h0;
	// 	else cyphertext[0] <= cyphertext_in[0];
			
	assign done_bit_in = (counter == 16'd48);
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n) done_bit <= 1'b0;
		else done_bit <= go_bit_in ? 1'b0 : done_bit_in;


localparam byte s_box [0:255] = '{
    8'h63, 8'h7C, 8'h77, 8'h7B, 8'hF2, 8'h6B, 8'h6F, 8'hC5, 8'h30, 8'h01, 8'h67, 8'h2B, 8'hFE, 8'hD7, 8'hAB, 8'h76,
    8'hCA, 8'h82, 8'hC9, 8'h7D, 8'hFA, 8'h59, 8'h47, 8'hF0, 8'hAD, 8'hD4, 8'hA2, 8'hAF, 8'h9C, 8'hA4, 8'h72, 8'hC0,
    8'hB7, 8'hFD, 8'h93, 8'h26, 8'h36, 8'h3F, 8'hF7, 8'hCC, 8'h34, 8'hA5, 8'hE5, 8'hF1, 8'h71, 8'hD8, 8'h31, 8'h15,
    8'h04, 8'hC7, 8'h23, 8'hC3, 8'h18, 8'h96, 8'h05, 8'h9A, 8'h07, 8'h12, 8'h80, 8'hE2, 8'hEB, 8'h27, 8'hB2, 8'h75,
    8'h09, 8'h83, 8'h2C, 8'h1A, 8'h1B, 8'h6E, 8'h5A, 8'hA0, 8'h52, 8'h3B, 8'hD6, 8'hB3, 8'h29, 8'hE3, 8'h2F, 8'h84,
    8'h53, 8'hD1, 8'h00, 8'hED, 8'h20, 8'hFC, 8'hB1, 8'h5B, 8'h6A, 8'hCB, 8'hBE, 8'h39, 8'h4A, 8'h4C, 8'h58, 8'hCF,
    8'hD0, 8'hEF, 8'hAA, 8'hFB, 8'h43, 8'h4D, 8'h33, 8'h85, 8'h45, 8'hF9, 8'h02, 8'h7F, 8'h50, 8'h3C, 8'h9F, 8'hA8,
    8'h51, 8'hA3, 8'h40, 8'h8F, 8'h92, 8'h9D, 8'h38, 8'hF5, 8'hBC, 8'hB6, 8'hDA, 8'h21, 8'h10, 8'hFF, 8'hF3, 8'hD2,
    8'hCD, 8'h0C, 8'h13, 8'hEC, 8'h5F, 8'h97, 8'h44, 8'h17, 8'hC4, 8'hA7, 8'h7E, 8'h3D, 8'h64, 8'h5D, 8'h19, 8'h73,
    8'h60, 8'h81, 8'h4F, 8'hDC, 8'h22, 8'h2A, 8'h90, 8'h88, 8'h46, 8'hEE, 8'hB8, 8'h14, 8'hDE, 8'h5E, 8'h0B, 8'hDB,
    8'hE0, 8'h32, 8'h3A, 8'h0A, 8'h49, 8'h06, 8'h24, 8'h5C, 8'hC2, 8'hD3, 8'hAC, 8'h62, 8'h91, 8'h95, 8'hE4, 8'h79,
    8'hE7, 8'hC8, 8'h37, 8'h6D, 8'h8D, 8'hD5, 8'h4E, 8'hA9, 8'h6C, 8'h56, 8'hF4, 8'hEA, 8'h65, 8'h7A, 8'hAE, 8'h08,
    8'hBA, 8'h78, 8'h25, 8'h2E, 8'h1C, 8'hA6, 8'hB4, 8'hC6, 8'hE8, 8'hDD, 8'h74, 8'h1F, 8'h4B, 8'hBD, 8'h8B, 8'h8A,
    8'h70, 8'h3E, 8'hB5, 8'h66, 8'h48, 8'h03, 8'hF6, 8'h0E, 8'h61, 8'h35, 8'h57, 8'hB9, 8'h86, 8'hC1, 8'h1D, 8'h9E,
    8'hE1, 8'hF8, 8'h98, 8'h11, 8'h69, 8'hD9, 8'h8E, 8'h94, 8'h9B, 8'h1E, 8'h87, 8'hE9, 8'hCE, 8'h55, 8'h28, 8'hDF,
    8'h8C, 8'hA1, 8'h89, 8'h0D, 8'hBF, 8'hE6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2D, 8'h0F, 8'hB0, 8'h54, 8'hBB, 8'h16
    };

localparam int A0 [0:255] = '{
	32'hc66363a5, 32'hf87c7c84, 32'hee777799, 32'hf67b7b8d, 32'hfff2f20d, 32'hd66b6bbd, 32'hde6f6fb1, 32'h91c5c554,
	32'h60303050, 32'h02010103, 32'hce6767a9, 32'h562b2b7d, 32'he7fefe19, 32'hb5d7d762, 32'h4dababe6, 32'hec76769a,
	32'h8fcaca45, 32'h1f82829d, 32'h89c9c940, 32'hfa7d7d87, 32'heffafa15, 32'hb25959eb, 32'h8e4747c9, 32'hfbf0f00b,
	32'h41adadec, 32'hb3d4d467, 32'h5fa2a2fd, 32'h45afafea, 32'h239c9cbf, 32'h53a4a4f7, 32'he4727296, 32'h9bc0c05b,
	32'h75b7b7c2, 32'he1fdfd1c, 32'h3d9393ae, 32'h4c26266a, 32'h6c36365a, 32'h7e3f3f41, 32'hf5f7f702, 32'h83cccc4f,
	32'h6834345c, 32'h51a5a5f4, 32'hd1e5e534, 32'hf9f1f108, 32'he2717193, 32'habd8d873, 32'h62313153, 32'h2a15153f,
	32'h0804040c, 32'h95c7c752, 32'h46232365, 32'h9dc3c35e, 32'h30181828, 32'h379696a1, 32'h0a05050f, 32'h2f9a9ab5,
	32'h0e070709, 32'h24121236, 32'h1b80809b, 32'hdfe2e23d, 32'hcdebeb26, 32'h4e272769, 32'h7fb2b2cd, 32'hea75759f,
	32'h1209091b, 32'h1d83839e, 32'h582c2c74, 32'h341a1a2e, 32'h361b1b2d, 32'hdc6e6eb2, 32'hb45a5aee, 32'h5ba0a0fb,
	32'ha45252f6, 32'h763b3b4d, 32'hb7d6d661, 32'h7db3b3ce, 32'h5229297b, 32'hdde3e33e, 32'h5e2f2f71, 32'h13848497,
	32'ha65353f5, 32'hb9d1d168, 32'h00000000, 32'hc1eded2c, 32'h40202060, 32'he3fcfc1f, 32'h79b1b1c8, 32'hb65b5bed,
	32'hd46a6abe, 32'h8dcbcb46, 32'h67bebed9, 32'h7239394b, 32'h944a4ade, 32'h984c4cd4, 32'hb05858e8, 32'h85cfcf4a,
	32'hbbd0d06b, 32'hc5efef2a, 32'h4faaaae5, 32'hedfbfb16, 32'h864343c5, 32'h9a4d4dd7, 32'h66333355, 32'h11858594,
	32'h8a4545cf, 32'he9f9f910, 32'h04020206, 32'hfe7f7f81, 32'ha05050f0, 32'h783c3c44, 32'h259f9fba, 32'h4ba8a8e3,
	32'ha25151f3, 32'h5da3a3fe, 32'h804040c0, 32'h058f8f8a, 32'h3f9292ad, 32'h219d9dbc, 32'h70383848, 32'hf1f5f504,
	32'h63bcbcdf, 32'h77b6b6c1, 32'hafdada75, 32'h42212163, 32'h20101030, 32'he5ffff1a, 32'hfdf3f30e, 32'hbfd2d26d,
	32'h81cdcd4c, 32'h180c0c14, 32'h26131335, 32'hc3ecec2f, 32'hbe5f5fe1, 32'h359797a2, 32'h884444cc, 32'h2e171739,
	32'h93c4c457, 32'h55a7a7f2, 32'hfc7e7e82, 32'h7a3d3d47, 32'hc86464ac, 32'hba5d5de7, 32'h3219192b, 32'he6737395,
	32'hc06060a0, 32'h19818198, 32'h9e4f4fd1, 32'ha3dcdc7f, 32'h44222266, 32'h542a2a7e, 32'h3b9090ab, 32'h0b888883,
	32'h8c4646ca, 32'hc7eeee29, 32'h6bb8b8d3, 32'h2814143c, 32'ha7dede79, 32'hbc5e5ee2, 32'h160b0b1d, 32'haddbdb76,
	32'hdbe0e03b, 32'h64323256, 32'h743a3a4e, 32'h140a0a1e, 32'h924949db, 32'h0c06060a, 32'h4824246c, 32'hb85c5ce4,
	32'h9fc2c25d, 32'hbdd3d36e, 32'h43acacef, 32'hc46262a6, 32'h399191a8, 32'h319595a4, 32'hd3e4e437, 32'hf279798b,
	32'hd5e7e732, 32'h8bc8c843, 32'h6e373759, 32'hda6d6db7, 32'h018d8d8c, 32'hb1d5d564, 32'h9c4e4ed2, 32'h49a9a9e0,
	32'hd86c6cb4, 32'hac5656fa, 32'hf3f4f407, 32'hcfeaea25, 32'hca6565af, 32'hf47a7a8e, 32'h47aeaee9, 32'h10080818,
	32'h6fbabad5, 32'hf0787888, 32'h4a25256f, 32'h5c2e2e72, 32'h381c1c24, 32'h57a6a6f1, 32'h73b4b4c7, 32'h97c6c651,
	32'hcbe8e823, 32'ha1dddd7c, 32'he874749c, 32'h3e1f1f21, 32'h964b4bdd, 32'h61bdbddc, 32'h0d8b8b86, 32'h0f8a8a85,
	32'he0707090, 32'h7c3e3e42, 32'h71b5b5c4, 32'hcc6666aa, 32'h904848d8, 32'h06030305, 32'hf7f6f601, 32'h1c0e0e12,
	32'hc26161a3, 32'h6a35355f, 32'hae5757f9, 32'h69b9b9d0, 32'h17868691, 32'h99c1c158, 32'h3a1d1d27, 32'h279e9eb9,
	32'hd9e1e138, 32'hebf8f813, 32'h2b9898b3, 32'h22111133, 32'hd26969bb, 32'ha9d9d970, 32'h078e8e89, 32'h339494a7,
	32'h2d9b9bb6, 32'h3c1e1e22, 32'h15878792, 32'hc9e9e920, 32'h87cece49, 32'haa5555ff, 32'h50282878, 32'ha5dfdf7a,
	32'h038c8c8f, 32'h59a1a1f8, 32'h09898980, 32'h1a0d0d17, 32'h65bfbfda, 32'hd7e6e631, 32'h844242c6, 32'hd06868b8,
	32'h824141c3, 32'h299999b0, 32'h5a2d2d77, 32'h1e0f0f11, 32'h7bb0b0cb, 32'ha85454fc, 32'h6dbbbbd6, 32'h2c16163a
	};

localparam int A1 [0:255] = '{
	32'ha5c66363, 32'h84f87c7c, 32'h99ee7777, 32'h8df67b7b, 32'h0dfff2f2, 32'hbdd66b6b, 32'hb1de6f6f, 32'h5491c5c5,
	32'h50603030, 32'h03020101, 32'ha9ce6767, 32'h7d562b2b, 32'h19e7fefe, 32'h62b5d7d7, 32'he64dabab, 32'h9aec7676,
	32'h458fcaca, 32'h9d1f8282, 32'h4089c9c9, 32'h87fa7d7d, 32'h15effafa, 32'hebb25959, 32'hc98e4747, 32'h0bfbf0f0,
	32'hec41adad, 32'h67b3d4d4, 32'hfd5fa2a2, 32'hea45afaf, 32'hbf239c9c, 32'hf753a4a4, 32'h96e47272, 32'h5b9bc0c0,
	32'hc275b7b7, 32'h1ce1fdfd, 32'hae3d9393, 32'h6a4c2626, 32'h5a6c3636, 32'h417e3f3f, 32'h02f5f7f7, 32'h4f83cccc,
	32'h5c683434, 32'hf451a5a5, 32'h34d1e5e5, 32'h08f9f1f1, 32'h93e27171, 32'h73abd8d8, 32'h53623131, 32'h3f2a1515,
	32'h0c080404, 32'h5295c7c7, 32'h65462323, 32'h5e9dc3c3, 32'h28301818, 32'ha1379696, 32'h0f0a0505, 32'hb52f9a9a,
	32'h090e0707, 32'h36241212, 32'h9b1b8080, 32'h3ddfe2e2, 32'h26cdebeb, 32'h694e2727, 32'hcd7fb2b2, 32'h9fea7575,
	32'h1b120909, 32'h9e1d8383, 32'h74582c2c, 32'h2e341a1a, 32'h2d361b1b, 32'hb2dc6e6e, 32'heeb45a5a, 32'hfb5ba0a0,
	32'hf6a45252, 32'h4d763b3b, 32'h61b7d6d6, 32'hce7db3b3, 32'h7b522929, 32'h3edde3e3, 32'h715e2f2f, 32'h97138484,
	32'hf5a65353, 32'h68b9d1d1, 32'h00000000, 32'h2cc1eded, 32'h60402020, 32'h1fe3fcfc, 32'hc879b1b1, 32'hedb65b5b,
	32'hbed46a6a, 32'h468dcbcb, 32'hd967bebe, 32'h4b723939, 32'hde944a4a, 32'hd4984c4c, 32'he8b05858, 32'h4a85cfcf,
	32'h6bbbd0d0, 32'h2ac5efef, 32'he54faaaa, 32'h16edfbfb, 32'hc5864343, 32'hd79a4d4d, 32'h55663333, 32'h94118585,
	32'hcf8a4545, 32'h10e9f9f9, 32'h06040202, 32'h81fe7f7f, 32'hf0a05050, 32'h44783c3c, 32'hba259f9f, 32'he34ba8a8,
	32'hf3a25151, 32'hfe5da3a3, 32'hc0804040, 32'h8a058f8f, 32'had3f9292, 32'hbc219d9d, 32'h48703838, 32'h04f1f5f5,
	32'hdf63bcbc, 32'hc177b6b6, 32'h75afdada, 32'h63422121, 32'h30201010, 32'h1ae5ffff, 32'h0efdf3f3, 32'h6dbfd2d2,
	32'h4c81cdcd, 32'h14180c0c, 32'h35261313, 32'h2fc3ecec, 32'he1be5f5f, 32'ha2359797, 32'hcc884444, 32'h392e1717,
	32'h5793c4c4, 32'hf255a7a7, 32'h82fc7e7e, 32'h477a3d3d, 32'hacc86464, 32'he7ba5d5d, 32'h2b321919, 32'h95e67373,
	32'ha0c06060, 32'h98198181, 32'hd19e4f4f, 32'h7fa3dcdc, 32'h66442222, 32'h7e542a2a, 32'hab3b9090, 32'h830b8888,
	32'hca8c4646, 32'h29c7eeee, 32'hd36bb8b8, 32'h3c281414, 32'h79a7dede, 32'he2bc5e5e, 32'h1d160b0b, 32'h76addbdb,
	32'h3bdbe0e0, 32'h56643232, 32'h4e743a3a, 32'h1e140a0a, 32'hdb924949, 32'h0a0c0606, 32'h6c482424, 32'he4b85c5c,
	32'h5d9fc2c2, 32'h6ebdd3d3, 32'hef43acac, 32'ha6c46262, 32'ha8399191, 32'ha4319595, 32'h37d3e4e4, 32'h8bf27979,
	32'h32d5e7e7, 32'h438bc8c8, 32'h596e3737, 32'hb7da6d6d, 32'h8c018d8d, 32'h64b1d5d5, 32'hd29c4e4e, 32'he049a9a9,
	32'hb4d86c6c, 32'hfaac5656, 32'h07f3f4f4, 32'h25cfeaea, 32'hafca6565, 32'h8ef47a7a, 32'he947aeae, 32'h18100808,
	32'hd56fbaba, 32'h88f07878, 32'h6f4a2525, 32'h725c2e2e, 32'h24381c1c, 32'hf157a6a6, 32'hc773b4b4, 32'h5197c6c6,
	32'h23cbe8e8, 32'h7ca1dddd, 32'h9ce87474, 32'h213e1f1f, 32'hdd964b4b, 32'hdc61bdbd, 32'h860d8b8b, 32'h850f8a8a,
	32'h90e07070, 32'h427c3e3e, 32'hc471b5b5, 32'haacc6666, 32'hd8904848, 32'h05060303, 32'h01f7f6f6, 32'h121c0e0e,
	32'ha3c26161, 32'h5f6a3535, 32'hf9ae5757, 32'hd069b9b9, 32'h91178686, 32'h5899c1c1, 32'h273a1d1d, 32'hb9279e9e,
	32'h38d9e1e1, 32'h13ebf8f8, 32'hb32b9898, 32'h33221111, 32'hbbd26969, 32'h70a9d9d9, 32'h89078e8e, 32'ha7339494,
	32'hb62d9b9b, 32'h223c1e1e, 32'h92158787, 32'h20c9e9e9, 32'h4987cece, 32'hffaa5555, 32'h78502828, 32'h7aa5dfdf,
	32'h8f038c8c, 32'hf859a1a1, 32'h80098989, 32'h171a0d0d, 32'hda65bfbf, 32'h31d7e6e6, 32'hc6844242, 32'hb8d06868,
	32'hc3824141, 32'hb0299999, 32'h775a2d2d, 32'h111e0f0f, 32'hcb7bb0b0, 32'hfca85454, 32'hd66dbbbb, 32'h3a2c1616
	};


localparam int A2 [0:255] = '{
	32'h63a5c663, 32'h7c84f87c, 32'h7799ee77, 32'h7b8df67b, 32'hf20dfff2, 32'h6bbdd66b, 32'h6fb1de6f, 32'hc55491c5,
	32'h30506030, 32'h01030201, 32'h67a9ce67, 32'h2b7d562b, 32'hfe19e7fe, 32'hd762b5d7, 32'habe64dab, 32'h769aec76,
	32'hca458fca, 32'h829d1f82, 32'hc94089c9, 32'h7d87fa7d, 32'hfa15effa, 32'h59ebb259, 32'h47c98e47, 32'hf00bfbf0,
	32'hadec41ad, 32'hd467b3d4, 32'ha2fd5fa2, 32'hafea45af, 32'h9cbf239c, 32'ha4f753a4, 32'h7296e472, 32'hc05b9bc0,
	32'hb7c275b7, 32'hfd1ce1fd, 32'h93ae3d93, 32'h266a4c26, 32'h365a6c36, 32'h3f417e3f, 32'hf702f5f7, 32'hcc4f83cc,
	32'h345c6834, 32'ha5f451a5, 32'he534d1e5, 32'hf108f9f1, 32'h7193e271, 32'hd873abd8, 32'h31536231, 32'h153f2a15,
	32'h040c0804, 32'hc75295c7, 32'h23654623, 32'hc35e9dc3, 32'h18283018, 32'h96a13796, 32'h050f0a05, 32'h9ab52f9a,
	32'h07090e07, 32'h12362412, 32'h809b1b80, 32'he23ddfe2, 32'heb26cdeb, 32'h27694e27, 32'hb2cd7fb2, 32'h759fea75,
	32'h091b1209, 32'h839e1d83, 32'h2c74582c, 32'h1a2e341a, 32'h1b2d361b, 32'h6eb2dc6e, 32'h5aeeb45a, 32'ha0fb5ba0,
	32'h52f6a452, 32'h3b4d763b, 32'hd661b7d6, 32'hb3ce7db3, 32'h297b5229, 32'he33edde3, 32'h2f715e2f, 32'h84971384,
	32'h53f5a653, 32'hd168b9d1, 32'h00000000, 32'hed2cc1ed, 32'h20604020, 32'hfc1fe3fc, 32'hb1c879b1, 32'h5bedb65b,
	32'h6abed46a, 32'hcb468dcb, 32'hbed967be, 32'h394b7239, 32'h4ade944a, 32'h4cd4984c, 32'h58e8b058, 32'hcf4a85cf,
	32'hd06bbbd0, 32'hef2ac5ef, 32'haae54faa, 32'hfb16edfb, 32'h43c58643, 32'h4dd79a4d, 32'h33556633, 32'h85941185,
	32'h45cf8a45, 32'hf910e9f9, 32'h02060402, 32'h7f81fe7f, 32'h50f0a050, 32'h3c44783c, 32'h9fba259f, 32'ha8e34ba8,
	32'h51f3a251, 32'ha3fe5da3, 32'h40c08040, 32'h8f8a058f, 32'h92ad3f92, 32'h9dbc219d, 32'h38487038, 32'hf504f1f5,
	32'hbcdf63bc, 32'hb6c177b6, 32'hda75afda, 32'h21634221, 32'h10302010, 32'hff1ae5ff, 32'hf30efdf3, 32'hd26dbfd2,
	32'hcd4c81cd, 32'h0c14180c, 32'h13352613, 32'hec2fc3ec, 32'h5fe1be5f, 32'h97a23597, 32'h44cc8844, 32'h17392e17,
	32'hc45793c4, 32'ha7f255a7, 32'h7e82fc7e, 32'h3d477a3d, 32'h64acc864, 32'h5de7ba5d, 32'h192b3219, 32'h7395e673,
	32'h60a0c060, 32'h81981981, 32'h4fd19e4f, 32'hdc7fa3dc, 32'h22664422, 32'h2a7e542a, 32'h90ab3b90, 32'h88830b88,
	32'h46ca8c46, 32'hee29c7ee, 32'hb8d36bb8, 32'h143c2814, 32'hde79a7de, 32'h5ee2bc5e, 32'h0b1d160b, 32'hdb76addb,
	32'he03bdbe0, 32'h32566432, 32'h3a4e743a, 32'h0a1e140a, 32'h49db9249, 32'h060a0c06, 32'h246c4824, 32'h5ce4b85c,
	32'hc25d9fc2, 32'hd36ebdd3, 32'hacef43ac, 32'h62a6c462, 32'h91a83991, 32'h95a43195, 32'he437d3e4, 32'h798bf279,
	32'he732d5e7, 32'hc8438bc8, 32'h37596e37, 32'h6db7da6d, 32'h8d8c018d, 32'hd564b1d5, 32'h4ed29c4e, 32'ha9e049a9,
	32'h6cb4d86c, 32'h56faac56, 32'hf407f3f4, 32'hea25cfea, 32'h65afca65, 32'h7a8ef47a, 32'haee947ae, 32'h08181008,
	32'hbad56fba, 32'h7888f078, 32'h256f4a25, 32'h2e725c2e, 32'h1c24381c, 32'ha6f157a6, 32'hb4c773b4, 32'hc65197c6,
	32'he823cbe8, 32'hdd7ca1dd, 32'h749ce874, 32'h1f213e1f, 32'h4bdd964b, 32'hbddc61bd, 32'h8b860d8b, 32'h8a850f8a,
	32'h7090e070, 32'h3e427c3e, 32'hb5c471b5, 32'h66aacc66, 32'h48d89048, 32'h03050603, 32'hf601f7f6, 32'h0e121c0e,
	32'h61a3c261, 32'h355f6a35, 32'h57f9ae57, 32'hb9d069b9, 32'h86911786, 32'hc15899c1, 32'h1d273a1d, 32'h9eb9279e,
	32'he138d9e1, 32'hf813ebf8, 32'h98b32b98, 32'h11332211, 32'h69bbd269, 32'hd970a9d9, 32'h8e89078e, 32'h94a73394,
	32'h9bb62d9b, 32'h1e223c1e, 32'h87921587, 32'he920c9e9, 32'hce4987ce, 32'h55ffaa55, 32'h28785028, 32'hdf7aa5df,
	32'h8c8f038c, 32'ha1f859a1, 32'h89800989, 32'h0d171a0d, 32'hbfda65bf, 32'he631d7e6, 32'h42c68442, 32'h68b8d068,
	32'h41c38241, 32'h99b02999, 32'h2d775a2d, 32'h0f111e0f, 32'hb0cb7bb0, 32'h54fca854, 32'hbbd66dbb, 32'h163a2c16
	};

localparam int A3 [0:255] = '{
	32'h6363a5c6, 32'h7c7c84f8, 32'h777799ee, 32'h7b7b8df6, 32'hf2f20dff, 32'h6b6bbdd6, 32'h6f6fb1de, 32'hc5c55491,
	32'h30305060, 32'h01010302, 32'h6767a9ce, 32'h2b2b7d56, 32'hfefe19e7, 32'hd7d762b5, 32'hababe64d, 32'h76769aec,
	32'hcaca458f, 32'h82829d1f, 32'hc9c94089, 32'h7d7d87fa, 32'hfafa15ef, 32'h5959ebb2, 32'h4747c98e, 32'hf0f00bfb,
	32'hadadec41, 32'hd4d467b3, 32'ha2a2fd5f, 32'hafafea45, 32'h9c9cbf23, 32'ha4a4f753, 32'h727296e4, 32'hc0c05b9b,
	32'hb7b7c275, 32'hfdfd1ce1, 32'h9393ae3d, 32'h26266a4c, 32'h36365a6c, 32'h3f3f417e, 32'hf7f702f5, 32'hcccc4f83,
	32'h34345c68, 32'ha5a5f451, 32'he5e534d1, 32'hf1f108f9, 32'h717193e2, 32'hd8d873ab, 32'h31315362, 32'h15153f2a,
	32'h04040c08, 32'hc7c75295, 32'h23236546, 32'hc3c35e9d, 32'h18182830, 32'h9696a137, 32'h05050f0a, 32'h9a9ab52f,
	32'h0707090e, 32'h12123624, 32'h80809b1b, 32'he2e23ddf, 32'hebeb26cd, 32'h2727694e, 32'hb2b2cd7f, 32'h75759fea,
	32'h09091b12, 32'h83839e1d, 32'h2c2c7458, 32'h1a1a2e34, 32'h1b1b2d36, 32'h6e6eb2dc, 32'h5a5aeeb4, 32'ha0a0fb5b,
	32'h5252f6a4, 32'h3b3b4d76, 32'hd6d661b7, 32'hb3b3ce7d, 32'h29297b52, 32'he3e33edd, 32'h2f2f715e, 32'h84849713,
	32'h5353f5a6, 32'hd1d168b9, 32'h00000000, 32'heded2cc1, 32'h20206040, 32'hfcfc1fe3, 32'hb1b1c879, 32'h5b5bedb6,
	32'h6a6abed4, 32'hcbcb468d, 32'hbebed967, 32'h39394b72, 32'h4a4ade94, 32'h4c4cd498, 32'h5858e8b0, 32'hcfcf4a85,
	32'hd0d06bbb, 32'hefef2ac5, 32'haaaae54f, 32'hfbfb16ed, 32'h4343c586, 32'h4d4dd79a, 32'h33335566, 32'h85859411,
	32'h4545cf8a, 32'hf9f910e9, 32'h02020604, 32'h7f7f81fe, 32'h5050f0a0, 32'h3c3c4478, 32'h9f9fba25, 32'ha8a8e34b,
	32'h5151f3a2, 32'ha3a3fe5d, 32'h4040c080, 32'h8f8f8a05, 32'h9292ad3f, 32'h9d9dbc21, 32'h38384870, 32'hf5f504f1,
	32'hbcbcdf63, 32'hb6b6c177, 32'hdada75af, 32'h21216342, 32'h10103020, 32'hffff1ae5, 32'hf3f30efd, 32'hd2d26dbf,
	32'hcdcd4c81, 32'h0c0c1418, 32'h13133526, 32'hecec2fc3, 32'h5f5fe1be, 32'h9797a235, 32'h4444cc88, 32'h1717392e,
	32'hc4c45793, 32'ha7a7f255, 32'h7e7e82fc, 32'h3d3d477a, 32'h6464acc8, 32'h5d5de7ba, 32'h19192b32, 32'h737395e6,
	32'h6060a0c0, 32'h81819819, 32'h4f4fd19e, 32'hdcdc7fa3, 32'h22226644, 32'h2a2a7e54, 32'h9090ab3b, 32'h8888830b,
	32'h4646ca8c, 32'heeee29c7, 32'hb8b8d36b, 32'h14143c28, 32'hdede79a7, 32'h5e5ee2bc, 32'h0b0b1d16, 32'hdbdb76ad,
	32'he0e03bdb, 32'h32325664, 32'h3a3a4e74, 32'h0a0a1e14, 32'h4949db92, 32'h06060a0c, 32'h24246c48, 32'h5c5ce4b8,
	32'hc2c25d9f, 32'hd3d36ebd, 32'hacacef43, 32'h6262a6c4, 32'h9191a839, 32'h9595a431, 32'he4e437d3, 32'h79798bf2,
	32'he7e732d5, 32'hc8c8438b, 32'h3737596e, 32'h6d6db7da, 32'h8d8d8c01, 32'hd5d564b1, 32'h4e4ed29c, 32'ha9a9e049,
	32'h6c6cb4d8, 32'h5656faac, 32'hf4f407f3, 32'heaea25cf, 32'h6565afca, 32'h7a7a8ef4, 32'haeaee947, 32'h08081810,
	32'hbabad56f, 32'h787888f0, 32'h25256f4a, 32'h2e2e725c, 32'h1c1c2438, 32'ha6a6f157, 32'hb4b4c773, 32'hc6c65197,
	32'he8e823cb, 32'hdddd7ca1, 32'h74749ce8, 32'h1f1f213e, 32'h4b4bdd96, 32'hbdbddc61, 32'h8b8b860d, 32'h8a8a850f,
	32'h707090e0, 32'h3e3e427c, 32'hb5b5c471, 32'h6666aacc, 32'h4848d890, 32'h03030506, 32'hf6f601f7, 32'h0e0e121c,
	32'h6161a3c2, 32'h35355f6a, 32'h5757f9ae, 32'hb9b9d069, 32'h86869117, 32'hc1c15899, 32'h1d1d273a, 32'h9e9eb927,
	32'he1e138d9, 32'hf8f813eb, 32'h9898b32b, 32'h11113322, 32'h6969bbd2, 32'hd9d970a9, 32'h8e8e8907, 32'h9494a733,
	32'h9b9bb62d, 32'h1e1e223c, 32'h87879215, 32'he9e920c9, 32'hcece4987, 32'h5555ffaa, 32'h28287850, 32'hdfdf7aa5,
	32'h8c8c8f03, 32'ha1a1f859, 32'h89898009, 32'h0d0d171a, 32'hbfbfda65, 32'he6e631d7, 32'h4242c684, 32'h6868b8d0,
	32'h4141c382, 32'h9999b029, 32'h2d2d775a, 32'h0f0f111e, 32'hb0b0cb7b, 32'h5454fca8, 32'hbbbbd66d, 32'h16163a2c
	};
endmodule