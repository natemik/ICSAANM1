`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 11:08:46 AM
// Design Name: 
// Module Name: SerializationSS
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

module SerializationSS
    #(parameter ACC_DATA_WIDTH = 16)
    (accumulatorValid,
     accumulatorData_I,
     accumulatorData_Q,
     serialClk,
     reset,
     serialStart,
     serialOut);
     
     input accumulatorValid;
     input [ACC_DATA_WIDTH-1:0] accumulatorData_I;
     input [ACC_DATA_WIDTH-1:0] accumulatorData_Q;
     input serialClk;
     input reset;
     output reg serialStart;
     output reg serialOut;
     
     reg [(ACC_DATA_WIDTH*2)-1:0] serialRegister;
     reg [5:0] counter;
     reg inProgress;
     
     always @ (posedge serialClk) begin
        if (reset) begin
            serialStart = 0;
            serialOut = 0;
            inProgress = 0;
            counter = 0;
            serialRegister = 0;
        end else if (accumulatorValid && !inProgress) begin
            // Load accumulator output to serializer register 
            serialStart = 0;
            serialOut = 0;
            counter = 0;
            inProgress = 1;
            serialRegister = {accumulatorData_Q, accumulatorData_I};
        end else if (inProgress && counter == 0) begin
            // Once the register is loaded and is the first data output
            serialStart = 1;
            serialOut = serialRegister[counter];
            counter = counter + 1;
            inProgress = 1;
            serialRegister = serialRegister;
        end else if (counter > (ACC_DATA_WIDTH*2)-1) begin
            // If the counter is at one greater than the last bit to send, reset everything back to 0
            serialStart = 0;
            serialOut = 0;
            inProgress = 0;
            counter = 0;
            serialRegister = 0;
        end else if (inProgress) begin
            serialStart = 0;
            serialOut = serialRegister[counter];
            counter = counter + 1;
            inProgress = 1;
            serialRegister = serialRegister;
        end else begin
            serialStart = 0;
            serialOut = 0;
            counter = 0;
            inProgress = 0;
            serialRegister = 0;
        end
     end
endmodule