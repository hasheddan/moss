/*
Copyright 2020 The Moss Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// timescale is formatted as <time_unit> / <time_precision>
`timescale 1ns / 1ps

module top(
    input clk,
    input uart_txd_in,
    input [1:0] sw,
    output uart_rxd_out,
    output [3:0]led
    );

    wire [7:0] w_data;
    wire [7:0] r_data;
    wire [7:0] w_addr;
    wire [7:0] r_addr;
    wire write;

    ram ram(.clk(clk), .i_addr(w_addr), .r_addr(r_addr), .i_data(w_data), .write(write), .read(sw[0]), .o_read(r_data), .notif(led[2]), .notif2(led[1]));
    uart_rx uart_rx(.clk(clk), .in(uart_txd_in), .notif(led[3]), .data(w_data), .addr(w_addr), .send(write));
    uart_tx uart_tx(.clk(clk), .send(sw[0]), .data(r_data), .addr(r_addr), .notif(led[0]), .out(uart_rxd_out));

endmodule
