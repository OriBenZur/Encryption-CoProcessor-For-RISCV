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

    

	always_ff@(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            rc_out <= 0;
            key_out <= 0;
        end
        else if(i == 0) begin
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
	    return {s_box.s_box[word[31:24]],s_box.s_box[word[23:16]],s_box.s_box[word[15:8]], s_box.s_box[word[7:0]]};
    endfunction

endmodule