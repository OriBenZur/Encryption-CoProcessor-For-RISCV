`timescale 1ns/1ps
/**
Queue module - This module holds a queue for each core, and forwards queue entries to the accelerator.
Each cores queue is full when the QUEUE_ADDR == 1
A core marks that it finished filling this entry by writing 1 to QUEUE_ADDR
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
    output logic accelerator_rst_n,

    output logic [31:0] data_out[0:N_CLIENTS - 1] // Output Data to cores
    );

    parameter logic [31:0] N_CLIENTS = 32'd2;
    parameter logic [31:0] QUEUE_ADDR = 32'd84;

    logic [31:0] lock;
	logic lock_locked, lock_locked_d;

    int i;
	
	assign lock_locked = (lock < N_CLIENTS) ? 1'b1 : 1'b0;
	
	assign addr_o = lock_locked ? addr_in[lock] : 32'h0;
	assign wr_en_o = lock_locked ? wr_en_in[lock] : 1'b0;
	assign accel_select_o = lock_locked ? select_in[lock] : 1'b0;
	assign data_to_accel = (wr_en_in[lock] && lock_locked) ? data_in[lock] : 32'h0;

    // lock-CPUs
    always_comb begin 
        for (i = 0; i < N_CLIENTS; i= i + 1) begin
            if (lock == i)
                data_out[i] = addr_in[i] == QUEUE_ADDR ? lock : data_from_accel;
            else
                data_out[i] = addr_in[i] == QUEUE_ADDR ? lock : 32'h00000000;
        end
        
    end

    
    // Lock logic
    always_ff @ (posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            lock <= N_CLIENTS;
            lock_locked_d <= 0;
        end
        else if (lock_locked) begin 
            lock <= (addr_in[lock] == QUEUE_ADDR && wr_en_in[lock] && select_in[lock] && data_in[lock] == 32'h0000) ? N_CLIENTS : lock;  
        end
        else begin // (lock >= N_CLIENTS)
            lock <= lock;
            for (i = 0; i < N_CLIENTS; i = i + 1) begin 
                if (addr_in[i] == QUEUE_ADDR && wr_en_in[i] && select_in[i] && data_in[i] == 32'h0001) begin
                    lock <= i;
                end
            end
        end
        lock_locked_d <= lock_locked;
        accelerator_rst_n <= ~lock_locked & lock_locked_d;
    end
endmodule