`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 01:27:15 PM
// Design Name: 
// Module Name: AccumulationSS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AccumulationSS
    #(parameter ACC_DATA_WIDTH = 16)
    (data,
     reset,
     clk,
     enable,
     out);
     
     input data;
     input reset;
     input clk;
     input enable;
     output reg [ACC_DATA_WIDTH-1:0] out;
     
     reg [ACC_DATA_WIDTH-1:0] outRegister; 
     
     always @ (posedge clk) begin
        if (reset | enable) begin
            out = outRegister;
            outRegister = data;
        end 
        else
            outRegister = outRegister + data;
     end
endmodule
