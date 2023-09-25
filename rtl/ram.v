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

`timescale 1ns / 1ps

module ram(
    input clk,
    input [7:0] i_addr,
    input [7:0] i_data,
    input [7:0] r_addr,
    input write,
    input read,
    output reg [7:0] o_read,
    output reg notif,
    output reg notif2
    );

    reg [7:0] ram [255:0];
    
    always @(posedge clk) begin
       if (write == 1'b1)
       begin
	  notif2 <= 1;
	  ram[i_addr] <= i_data;
       end
       else
       begin
	  notif2 <= 0;
       end
       if (read == 1'b1)
       begin
	  notif <= 1;
          o_read <= ram[r_addr];
       end
       else
       begin
	  notif <= 0;
       end
    end
endmodule
