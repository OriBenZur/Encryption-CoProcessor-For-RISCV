// This module calculates the expanded key for 128-bit AES algorithem
module key_expander
(
    input logic rst_n, // Reset Neg
	input logic clk, // Clk
    input byte i,
	input logic [31:0] key_i_1,
	input logic [31:0] key_N_i,
    input byte rc_i,
    output byte rc_out,
    output logic [31:0] key_out
	// output logic [31:0] expanded_key[EXPANDED_KEY_SIZE - 1:0]
	);

    int counter;
    parameter int KEY_SIZE = 4;
    localparam int DEFAULT_KEY_SIZE = 4;
    localparam int DEFAULT_NUM_OF_ROUNDS = 11;
    localparam int NUM_OF_ROUNDS = DEFAULT_NUM_OF_ROUNDS + KEY_SIZE - DEFAULT_KEY_SIZE;
    localparam int EXPANDED_KEY_SIZE = 4 * DEFAULT_NUM_OF_ROUNDS;

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

    

	always@(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            rc_out <= 0;
            key_out <= 0;
        end
        else if(i < 4) begin
            rc_out <= 1;
            key_out <= key_i_1;
        end
        else begin
            rc_out <= (i+1) % KEY_SIZE == 0 ? ((rc_i < 8'h80) ? rc_i << 1 : ((rc_i << 1) ^ 9'h11b)) : rc_out;
            if (i % KEY_SIZE == 0) key_out <= key_N_i ^ subWord(rotWord(key_i_1)) ^ (rc_i << 24);
            else if (i >= KEY_SIZE && KEY_SIZE > 6 && i % KEY_SIZE == 4) key_out <= key_N_i ^ subWord(key_i_1);
            else key_out <= key_N_i ^ key_i_1;
        end
        // else if (counter == 0) begin
        //     for (i = 1; i < NUM_OF_ROUNDS; i = i + 1) begin
        //         rc[i] = (rc[i-1] < 8'h80) ? rc[i-1] << 1 : ((rc[i-1] << 1) ^ 9'h11b);
        //     end
        //     counter = counter + 1;
        // end
        // else if (counter == 1) begin
        //     for (i = 0; i < EXPANDED_KEY_SIZE; i = i + 1) begin 
        //         if (i < KEY_SIZE) expanded_key[i] = key[i];
        //         else if (i % KEY_SIZE == 0) expanded_key[i] = expanded_key[i - KEY_SIZE] ^ subWord(rotWord(expanded_key[i-1])) ^ (rc[i / 4] << 24);
        //         else if (i >= KEY_SIZE && KEY_SIZE > 6 && i % KEY_SIZE == 4) expanded_key[i] = expanded_key[i - KEY_SIZE] ^ subWord(expanded_key[i - 1]);
        //         else expanded_key[i] = expanded_key[i - KEY_SIZE] ^ expanded_key[i - 1];
        //     end
        //     counter = counter + 1;
        //     done = 1;
        // end
    end
	 
	function int rotWord(int word);
	    return {word[23:0], word[31:24]};
    endfunction

	function int subWord(int word);
	    return {s_box[word[31:24]],s_box[word[23:16]],s_box[word[15:8]], s_box[word[7:0]]};
    endfunction

endmodule