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
    (inputData_SA,
     inputData_CML,
     clk,
     serialClk,
     reset,
     DSRatio,
     serialStart,
     serialOut);
     
    input [1:0] inputData_SA;
    input [1:0] inputData_CML;
    input clk;
    input serialClk;
    input reset;
    input [ACC_WIDTH-1:0] DSRatio; // Down Sampling Ratio
    output serialStart;
    output serialOut;
    
    wire valid;
    wire accumulationReset;
    wire [ACC_WIDTH-1:0] outputData_SA_I;
    wire [ACC_WIDTH-1:0] outputData_SA_Q;
    wire [ACC_WIDTH-1:0] outputData_CML_I;
    wire [ACC_WIDTH-1:0] outputData_CML_Q;
    
    assign inputData_SA_Q = inputData_SA[1];
    assign inputData_SA_I = inputData_SA[0];
    assign inputData_CML_Q = inputData_CML[1];
    assign inputData_CML_I = inputData_CML[0];

    CounterSS #(.ACCUMULATIONS_WIDTH(ACC_WIDTH))
        CounterSS_0 (.downsamplingRatio(DSRatio), .clk(clk), .reset(reset), .valid(valid), .equal(accumulationReset));
        
    AccumulationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        AccSS_SA_I (.data(inputData_SA_I), .reset(reset), .clk(clk), .enable(accumulationReset), .out(outputData_SA_I));
        
    AccumulationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        AccSS_SA_Q (.data(inputData_SA_Q), .reset(reset), .clk(clk), .enable(accumulationReset), .out(outputData_SA_Q));
        
    AccumulationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        AccSS_CML_I (.data(inputData_CML_I), .reset(reset), .clk(clk), .enable(accumulationReset), .out(outputData_CML_I));
        
    AccumulationSS #(.ACC_DATA_WIDTH(ACC_WIDTH))
        AccSS_CML_Q (.data(inputData_CML_Q), .reset(reset), .clk(clk), .enable(accumulationReset), .out(outputData_CML_Q));
        
    SerializationSS #(.ACC_DATA_WIDTH(2*ACC_WIDTH))
        SerialSS_0 (.accumulatorValid(valid), .accumulatorData_SA({outputData_SA_I, outputData_SA_Q}), .accumulatorData_CML({outputData_CML_I, outputData_CML_Q}), .serialClk(serialClk), .reset(reset), .serialStart(serialStart), .serialOut(serialOut));
        
     
        
endmodule
