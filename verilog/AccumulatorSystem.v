`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2023 03:11:59 PM
// Design Name: 
// Module Name: AccumulatorSystem
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


module AccumulatorSystem
    #(parameter ACC_WIDTH = 16)
    (inputData_I,
     inputData_Q,
     clk,
     serialClk,
     reset,
     DSRatio,
     serialStart,
     serialOut);
     
    input inputData_I;
    input inputData_Q;
    input clk;
    input serialClk;
    input reset;
    input [ACC_WIDTH-1:0] DSRatio; // Down Sampling Ratio
    output serialStart;
    output serialOut;
    
    wire valid;
    wire accumulationReset;
    wire [ACC_WIDTH-1:0] outputData_I;
    wire [ACC_WIDTH-1:0] outputData_Q;

    CounterSS #(.ACCUMULATIONS_WIDTH(ACC_WIDTH))
        CounterSS_0 (.downsamplingRatio(DSRatio), .clk(clk), .reset(reset), .valid(valid), .equal(accumulationReset));
        
    AccumulationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        AccSS_I (.data(inputData_I), .reset(reset), .clk(clk), .enable(accumulationReset), .out(outputData_I));
        
    AccumulationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        AccSS_Q (.data(inputData_Q), .reset(reset), .clk(clk), .enable(accumulationReset), .out(outputData_Q));
        
    SerializationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        SerialSS_0 (.accumulatorValid(valid), .accumulatorData_I(outputData_I), .accumulatorData_Q(outputData_Q), .serialClk(serialClk), .reset(reset), .serialStart(serialStart), .serialOut(serialOut));
        
     
        
endmodule
