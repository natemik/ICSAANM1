`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2023 11:31:03 AM
// Design Name: 
// Module Name: DigitalControlRegisters
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


module DigitalControlRegisters(
//    enable,
    dataIn,
    dataOut,
    clk,
//    reset,
    
    DSR_0,
    DSR_1,
    DSR_2,
    DSR_3,
    DSR_4,
    DSR_5,
    DSR_6,
    DSR_7,
    DSR_8,
    DSR_9,
    DSR_10,
    DSR_11,
    DSR_12,
    DSR_13,
    DSR_14,
    DSR_15,
    
    SR_LATCH_MUX_SEL_2,
    SR_LATCH_MUX_SEL_1,
    SR_LATCH_MUX_SEL_0,

    SA_RFBS_LF_DA_EN_I,
    SA_RFBS_LF_DA_EN_Q,

    CML_RFBS_LF_DA_EN_I,
    CML_RFBS_LF_DA_EN_Q,
    CML_RFBS_LF_CML_EN_I,
    CML_RFBS_LF_CML_EN_Q,
    
    
    LF_CML_RFBS_I_CLKSEL_PAD_ED,
    LF_CML_RFBS_I_CLKSEL_OFF_ON,
    LF_CML_RFBS_Q_CLKSEL_PAD_ED,
    LF_CML_RFBS_Q_CLKSEL_OFF_ON,
    
    LF_SA_RFBS_I_CLKSEL_PAD_ED,
    LF_SA_RFBS_I_CLKSEL_OFF_ON,
    LF_SA_RFBS_Q_CLKSEL_PAD_ED,
    LF_SA_RFBS_Q_CLKSEL_OFF_ON,
    
    LF_SA_S1_TAIL_VBIAS_EN,
    LF_CML_S1_TAIL_VBIAS_EN,
    
    LF_ED_OFF_ON,
    
    SAMPLE_CLOCK_POLARITY
    );
    
//    input enable;
    input dataIn;
    output dataOut;
    input clk;
//    input reset;
    
    output DSR_0;
    output DSR_1;
    output DSR_2;
    output DSR_3;
    output DSR_4;
    output DSR_5;
    output DSR_6;
    output DSR_7;
    output DSR_8;
    output DSR_9;
    output DSR_10;
    output DSR_11;
    output DSR_12;
    output DSR_13;
    output DSR_14;
    output DSR_15;
    ShiftRegister DSR_15_SR (.dataIn(dataIn), .dataOut(DSR_15), .clk(clk));
    ShiftRegister DSR_14_SR (.dataIn(DSR_15), .dataOut(DSR_14), .clk(clk));
    ShiftRegister DSR_13_SR (.dataIn(DSR_14), .dataOut(DSR_13), .clk(clk));
    ShiftRegister DSR_12_SR (.dataIn(DSR_13), .dataOut(DSR_12), .clk(clk));
    ShiftRegister DSR_11_SR (.dataIn(DSR_12), .dataOut(DSR_11), .clk(clk));
    ShiftRegister DSR_10_SR (.dataIn(DSR_11), .dataOut(DSR_10), .clk(clk));
    ShiftRegister DSR_9_SR (.dataIn(DSR_10), .dataOut(DSR_9), .clk(clk));
    ShiftRegister DSR_8_SR (.dataIn(DSR_9), .dataOut(DSR_8), .clk(clk));
    ShiftRegister DSR_7_SR (.dataIn(DSR_8), .dataOut(DSR_7), .clk(clk));
    ShiftRegister DSR_6_SR (.dataIn(DSR_7), .dataOut(DSR_6), .clk(clk));
    ShiftRegister DSR_5_SR (.dataIn(DSR_6), .dataOut(DSR_5), .clk(clk));
    ShiftRegister DSR_4_SR (.dataIn(DSR_5), .dataOut(DSR_4), .clk(clk));
    ShiftRegister DSR_3_SR (.dataIn(DSR_4), .dataOut(DSR_3), .clk(clk));
    ShiftRegister DSR_2_SR (.dataIn(DSR_3), .dataOut(DSR_2), .clk(clk));
    ShiftRegister DSR_1_SR (.dataIn(DSR_2), .dataOut(DSR_1), .clk(clk));
    ShiftRegister DSR_0_SR (.dataIn(DSR_1), .dataOut(DSR_0), .clk(clk));
   
    output SR_LATCH_MUX_SEL_2;
    output SR_LATCH_MUX_SEL_1;
    output SR_LATCH_MUX_SEL_0;
    ShiftRegister SR_LATCH_MUX_SEL_2_SR (.dataIn(DSR_0), .dataOut(SR_LATCH_MUX_SEL_2), .clk(clk));
    ShiftRegister SR_LATCH_MUX_SEL_1_SR (.dataIn(SR_LATCH_MUX_SEL_2), .dataOut(SR_LATCH_MUX_SEL_1), .clk(clk));
    ShiftRegister SR_LATCH_MUX_SEL_0_SR (.dataIn(SR_LATCH_MUX_SEL_1), .dataOut(SR_LATCH_MUX_SEL_0), .clk(clk));
    
    output SA_RFBS_LF_DA_EN_I;
    output SA_RFBS_LF_DA_EN_Q;
    ShiftRegister SA_RFBS_LF_DA_EN_I_SR (.dataIn(SR_LATCH_MUX_SEL_0), .dataOut(SA_RFBS_LF_DA_EN_I), .clk(clk));
    ShiftRegister SA_RFBS_LF_DA_EN_Q_SR (.dataIn(SA_RFBS_LF_DA_EN_I), .dataOut(SA_RFBS_LF_DA_EN_Q), .clk(clk));
    
    output CML_RFBS_LF_DA_EN_I;
    output CML_RFBS_LF_DA_EN_Q;
    output CML_RFBS_LF_CML_EN_I;
    output CML_RFBS_LF_CML_EN_Q;
    ShiftRegister CML_RFBS_LF_DA_EN_I_SR (.dataIn(SA_RFBS_LF_DA_EN_Q), .dataOut(CML_RFBS_LF_DA_EN_I), .clk(clk));
    ShiftRegister CML_RFBS_LF_DA_EN_Q_SR (.dataIn(CML_RFBS_LF_DA_EN_I), .dataOut(CML_RFBS_LF_DA_EN_Q), .clk(clk));
    ShiftRegister CML_RFBS_LF_CML_EN_I_SR (.dataIn(CML_RFBS_LF_DA_EN_Q), .dataOut(CML_RFBS_LF_CML_EN_I), .clk(clk));
    ShiftRegister CML_RFBS_LF_CML_EN_Q_SR (.dataIn(CML_RFBS_LF_CML_EN_I), .dataOut(CML_RFBS_LF_CML_EN_Q), .clk(clk));
    
    output LF_CML_RFBS_I_CLKSEL_PAD_ED;
    output LF_CML_RFBS_I_CLKSEL_OFF_ON;
    output LF_CML_RFBS_Q_CLKSEL_PAD_ED;
    output LF_CML_RFBS_Q_CLKSEL_OFF_ON;
    ShiftRegister LF_CML_RFBS_I_CLKSEL_PAD_ED_SR (.dataIn(CML_RFBS_LF_CML_EN_Q), .dataOut(LF_CML_RFBS_I_CLKSEL_PAD_ED), .clk(clk));
    ShiftRegister LF_CML_RFBS_I_CLKSEL_OFF_ON_SR (.dataIn(LF_CML_RFBS_I_CLKSEL_PAD_ED), .dataOut(LF_CML_RFBS_I_CLKSEL_OFF_ON), .clk(clk));
    ShiftRegister LF_CML_RFBS_Q_CLKSEL_PAD_ED_SR (.dataIn(LF_CML_RFBS_I_CLKSEL_OFF_ON), .dataOut(LF_CML_RFBS_Q_CLKSEL_PAD_ED), .clk(clk));
    ShiftRegister LF_CML_RFBS_Q_CLKSEL_OFF_ON_SR (.dataIn(LF_CML_RFBS_Q_CLKSEL_PAD_ED), .dataOut(LF_CML_RFBS_Q_CLKSEL_OFF_ON), .clk(clk));
    
    output LF_SA_RFBS_I_CLKSEL_PAD_ED;
    output LF_SA_RFBS_I_CLKSEL_OFF_ON;
    output LF_SA_RFBS_Q_CLKSEL_PAD_ED;
    output LF_SA_RFBS_Q_CLKSEL_OFF_ON;
    ShiftRegister LF_SA_RFBS_I_CLKSEL_PAD_ED_SR (.dataIn(LF_CML_RFBS_Q_CLKSEL_OFF_ON), .dataOut(LF_SA_RFBS_I_CLKSEL_PAD_ED), .clk(clk));
    ShiftRegister LF_SA_RFBS_I_CLKSEL_OFF_ON_SR (.dataIn(LF_SA_RFBS_I_CLKSEL_PAD_ED), .dataOut(LF_SA_RFBS_I_CLKSEL_OFF_ON), .clk(clk));
    ShiftRegister LF_SA_RFBS_Q_CLKSEL_PAD_ED_SR (.dataIn(LF_SA_RFBS_I_CLKSEL_OFF_ON), .dataOut(LF_SA_RFBS_Q_CLKSEL_PAD_ED), .clk(clk));
    ShiftRegister LF_SA_RFBS_Q_CLKSEL_OFF_ON_SR (.dataIn(LF_SA_RFBS_Q_CLKSEL_PAD_ED), .dataOut(LF_SA_RFBS_Q_CLKSEL_OFF_ON), .clk(clk));
        
    output LF_SA_S1_TAIL_VBIAS_EN;
    output LF_CML_S1_TAIL_VBIAS_EN;
    ShiftRegister LF_SA_S1_TAIL_VBIAS_EN_SR (.dataIn(LF_SA_RFBS_Q_CLKSEL_OFF_ON), .dataOut(LF_SA_S1_TAIL_VBIAS_EN), .clk(clk));
    ShiftRegister LF_CML_S1_TAIL_VBIAS_EN_SR (.dataIn(LF_SA_S1_TAIL_VBIAS_EN), .dataOut(LF_CML_S1_TAIL_VBIAS_EN), .clk(clk));
    
    output LF_ED_OFF_ON;
    ShiftRegister LF_ED_OFF_ON_SR (.dataIn(LF_CML_S1_TAIL_VBIAS_EN), .dataOut(LF_ED_OFF_ON), .clk(clk));
    
    output SAMPLE_CLOCK_POLARITY;
    ShiftRegister SAMPLE_CLOCK_POLARITY_SR (.dataIn(LF_ED_OFF_ON), .dataOut(SAMPLE_CLOCK_POLARITY), .clk(clk));

    
    ShiftRegister DUMMY_OUT_SR (.dataIn(SAMPLE_CLOCK_POLARITY), .dataOut(dataOut), .clk(clk));
    
    
    
endmodule
