`timescale 1ns/1ps
/**
Lock module - This module enables the sharing of an memory-mapped device between two cores.
To acquire the lock, a core should write to LOCK_ADDR the value '1'.
If the lock is locked, LOCK_ADDR will return the address of the core that has the lock. Otherwise it'll return the number of cores that share the lock
Cores with lower index get priority
*/
module lock
(
    input logic rst_n,
    input logic clk,
    input logic [31:0] addr_in [0:N_CLIENTS - 1],
    input logic wr_en_in [0:N_CLIENTS - 1],
    input logic select_in[0:N_CLIENTS - 1],
    input logic [31:0] data_in[0:N_CLIENTS - 1],

    input logic [31:0] data_from_accel, // input from the accelerator
    output logic [31:0] data_to_accel,
    output logic [31:0] addr_o, // Address
    output logic wr_en_o, //Write enable
    output logic accel_select_o,

    output logic [31:0] data_out[0:N_CLIENTS - 1] // Output Data to cores
    );

    parameter logic [31:0] N_CLIENTS = 32'd2;
    parameter logic [31:0] LOCK_ADDR = 32'd84;

    logic [31:0] lock;
	logic lock_locked;

    int i, j;
	
	assign lock_locked = (lock < N_CLIENTS) ? 1'b1 : 1'b0;
	
	assign addr_o = lock_locked ? addr_in[lock] : 0;
	assign wr_en_o = lock_locked ? wr_en_in[lock] : 1'b0;
	assign accel_select_o = lock_locked ? select_in[lock] : 1'b0;
	assign data_to_accel = (wr_en_in[lock] && lock_locked) ? data_in[lock] : 0;

    // lock-CPUs
    always_comb begin 
        for (i = 0; i < N_CLIENTS; i= i + 1) begin
            if (lock == i)
                data_out[i] = addr_in[i] == LOCK_ADDR ? lock : data_from_accel;
            else
                data_out[i] = addr_in[i] == LOCK_ADDR ? lock : 32'h00000000;
        end
        
    end
	 
    // // lock-accelerator
    // always_comb begin
    //     if (lock != N_CLIENTS) begin 
    //         addr_o = addr_in[lock];
    //         wr_en_o = wr_en_in[lock];
    //         accel_select_o = select_in[lock];
    //     end
    //     else begin
    //         addr_o = 0;
    //         wr_en_o = 0;
    //         accel_select_o = 0;
    //     end
    // end
    
    // Lock logic
    always_ff @ (posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            lock <= N_CLIENTS;
        end
        else if (lock_locked) begin 
            lock <= (addr_in[lock] == LOCK_ADDR && wr_en_in[lock] && select_in[lock] && data_in[lock] == 32'h0000) ? N_CLIENTS : lock;  
        end
        else begin // (lock >= N_CLIENTS)
            lock <= lock;
            for (i = 0; i < N_CLIENTS; i = i + 1) begin 
                if (addr_in[i] == LOCK_ADDR && wr_en_in[i] && select_in[i] && data_in[i] == 32'h0001) begin
                    lock <= i;
                end
            end
        end
    end
endmodule