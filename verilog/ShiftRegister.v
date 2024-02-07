`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2023 11:11:08 AM
// Design Name: 
// Module Name: ShiftRegister
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


module ShiftRegister(
//    enable,
    dataIn,
    dataOut,
    clk);
//    reset);
    
//    input enable;
    input dataIn;
    output reg dataOut;
    input clk;
//    input reset;
    
    always @ (posedge clk) begin
//        if (reset) begin
//            dataOut = 0;
//        end else if (enable) begin
//            dataOut = dataIn;
//        end else 
            dataOut = dataIn;
    end 
endmodule
