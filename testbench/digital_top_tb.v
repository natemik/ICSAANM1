`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2023 01:54:53 PM
// Design Name: 
// Module Name: digital_top_tb
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


module digital_top_tb();

    // Control Register
    parameter CR_CLK_FREQ = 250e6;
    parameter CR_CLK_HALF_PERIOD = (1.0/(CR_CLK_FREQ) * 1e9)/2;
    
    reg [33-1:0] testCase;
    reg controlRegisterReset;
    reg controlRegisterEnable;
    reg controlRegisterDataIn;
    wire controlRegisterDataOut;
    reg controlRegisterClk;
    integer counter;
    
    initial begin
        testCase = 33'b000011111110010100111111111111111;
        counter = 0;
        controlRegisterClk = 0;
    
        // Toggle the clock 31 times
        repeat (33) begin
          #CR_CLK_HALF_PERIOD; // Wait for the specified half period
          controlRegisterClk = ~controlRegisterClk; // Toggle the clock
          #CR_CLK_HALF_PERIOD; // Wait for the specified half period
          controlRegisterClk = ~controlRegisterClk; // Toggle the clock
          counter = counter + 1;
        end
    
        // Stay 0 after 31 toggles
        controlRegisterClk = 0;
    end    
    always @ (posedge controlRegisterClk) begin
        controlRegisterDataIn = testCase[counter];
    end
    
    
    reg accumulatorReset;
//    reg accDataIn_InPhase;
//    reg accDataIn_Quadrature;
    reg SA_InPhase_Data;
    reg SA_Quad_Data;
    reg CML_InPhase_Data;
    reg CML_Quad_Data;
    reg SA_Data;
    reg accumulatorClk;
    reg serialClk;
    wire serialStart;
    wire serialOut_SA;
    wire serialOut_CML;
    parameter DATA_FREQ = 60e3;
    parameter CLK_FREQ = 1e9;
    parameter SERIAL_CLK_FREQ = 600e6;
    parameter DATA_HALF_PERIOD = (1.0/(DATA_FREQ) * 1e9)/2;
    parameter CLK_HALF_PERIOD = (1.0/(CLK_FREQ) * 1e9)/2;
    parameter SERIAL_CLK_HALF_PERIOD = (1.0/(SERIAL_CLK_FREQ) * 1e9)/2;
    initial begin
//        accDataIn_InPhase = 0;
//        accDataIn_Quadrature = 1;
        SA_InPhase_Data = 0;
        SA_Quad_Data = 1;
        CML_InPhase_Data = 0;
        CML_Quad_Data = 1;
        SA_Data = 1;
        accumulatorReset = 1;
        accumulatorClk = 0;
        serialClk = 0;
        
        // Wait for 1000 clock cycles, then de-assert reset
        repeat (1000) @ (posedge accumulatorClk);
        
        accumulatorReset = 0;
    end
    initial begin
        forever #DATA_HALF_PERIOD SA_InPhase_Data=~SA_InPhase_Data;
    end
    initial begin
        forever #DATA_HALF_PERIOD SA_Quad_Data=~SA_Quad_Data;
    end
    initial begin
        forever #DATA_HALF_PERIOD CML_InPhase_Data=~CML_InPhase_Data;
    end
    initial begin
        forever #DATA_HALF_PERIOD CML_Quad_Data=~CML_Quad_Data;
    end
    initial begin
        forever #DATA_HALF_PERIOD SA_Data=~SA_Data;
    end
    initial begin
        forever #CLK_HALF_PERIOD accumulatorClk=~accumulatorClk;
    end
    
    initial begin
        forever #SERIAL_CLK_HALF_PERIOD serialClk=~serialClk;
    end


    
    digital_top digital_top_0(
    .PAD_SRLatchOut(SRLatchOut),
    
    .PAD_controlRegisterDataIn(controlRegisterDataIn),
    .PAD_controlRegisterDataOut(controlRegisterDataOut),
    .PAD_controlRegisterClk(controlRegisterClk),
    
//    .SA_RFBS_EN(SA_RFBS_EN),
//    .CML_RFBS_EN(CML_RFBS_EN),
    .CONTROL_SA_RFBS_LF_EN(SA_RFBS_LF_EN),
    .CONTROL_CML_RFBS_LF_EN(CML_RFBS_LF_EN),
    
//    .HF_CML_RFBS_I_CLKSEL_PAD_ED(HF_CML_RFBS_I_CLKSEL_PAD_ED),
//    .HF_CML_RFBS_I_CLKSEL_OFF_ON(HF_CML_RFBS_I_CLKSEL_),
//    .HF_CML_RFBS_Q_CLKSEL_PAD_ED(HF_CML_RFBS_Q_CLKSEL_PAD_ED),
//    .HF_CML_RFBS_Q_CLKSEL_OFF_ON(HF_CML_RFBS_Q_CLKSEL_OFF_ON),
    
//    .HF_SA_RFBS_I_CLKSEL_PAD_ED(HF_SA_RFBS_I_CLKSEL_PAD_ED),
//    .HF_SA_RFBS_I_CLKSEL_OFF_ON(HF_SA_RFBS_I_CLKSEL_OFF_ON),
//    .HF_SA_RFBS_Q_CLKSEL_PAD_ED(HF_SA_RFBS_Q_CLKSEL_PAD_ED),
//    .HF_SA_RFBS_Q_CLKSEL_OFF_ON(HF_SA_RFBS_Q_CLKSEL_OFF_ON),
    
    .CONTROL_LF_CML_RFBS_I_CLKSEL_PAD_ED(LF_CML_RFBS_I_CLKSEL_PAD_ED),
    .CONTROL_LF_CML_RFBS_I_CLKSEL_OFF_ON(LF_CML_RFBS_I_CLKSEL_OFF_ON),
    .CONTROL_LF_CML_RFBS_Q_CLKSEL_PAD_ED(LF_CML_RFBS_Q_CLKSEL_PAD_ED),
    .CONTROL_LF_CML_RFBS_Q_CLKSEL_OFF_ON(LF_CML_RFBS_Q_CLKSEL_OFF_ON),
    
    .CONTROL_LF_SA_RFBS_I_CLKSEL_PAD_ED(LF_SA_RFBS_I_CLKSEL_PAD_ED),
    .CONTROL_LF_SA_RFBS_I_CLKSEL_OFF_ON(LF_SA_RFBS_I_CLKSEL_OFF_ON),
    .CONTROL_LF_SA_RFBS_Q_CLKSEL_PAD_ED(LF_SA_RFBS_Q_CLKSEL_PAD_ED),
    .CONTROL_LF_SA_RFBS_Q_CLKSEL_OFF_ON(LF_SA_RFBS_Q_CLKSEL_OFF_ON),
    
//    .HF_COMMON_TAIL_VBIAS_EN(),
    .CONTROL_LF_SA_S1_TAIL_VBIAS_EN(LF_SA_S1_TAIL_VBIAS_EN),
    .CONTROL_LF_CML_S1_TAIL_VBIAS_EN(LF_CML_S1_TAIL_VBIAS_EN),
    
    .CONTROL_LF_ED_OFF_ON(LF_ED_OFF_ON),
    
    // Accumulator inputs/outputs
//    .PAD_accumulatorReset(accumulatorReset),
//    .accDataIn_InPhase(accDataIn_InPhase),
//    .accDataIn_Quadrature(accDataIn_Quadrature),
    .SA_InPhase_Data(SA_InPhase_Data),
    .SA_Quad_Data(SA_Quad_Data),
    .CML_InPhase_Data(CML_InPhase_Data),
    .CML_Quad_Data(CML_Quad_Data),
    .SA_Data(SA_Data),
    .PAD_accumulatorClk(accumulatorClk),
    .PAD_serialClk(serialClk),
    .PAD_serialStart(serialStart),
    .PAD_serialOut(serialOut)
    );
endmodule
