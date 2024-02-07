`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 01:27:15 PM
// Design Name: 
// Module Name: CounterSS
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


module CounterSS
    #(parameter ACCUMULATIONS_WIDTH = 16)
    (downsamplingRatio,
     clk,
     reset,
     valid,
     equal);
     
     input [ACCUMULATIONS_WIDTH-1:0] downsamplingRatio; // Down Sampling Ratio
     input clk;
     input reset;
     output reg valid;
     output equal;
     
     reg [ACCUMULATIONS_WIDTH-1:0] count;
     
     // Internal control signal to signify the Down Sampling Ratio is hit
     assign equal = (count == downsamplingRatio);
     
     always @ (posedge clk) begin
        if (reset) begin
            count = 0;
        end else if (equal) begin
            // If down sampling ratio hit, reset count to 1
            count = 1;
        end else begin
            count = count + 1;
        end
        valid = count <= 8;
     end
endmodule
