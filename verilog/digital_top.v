`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2023 09:59:39 PM
// Design Name: 
// Module Name: digital_top
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


module digital_top(
    PAD_SRLatchOut,

    PAD_controlRegisterDataIn,
    PAD_controlRegisterDataOut,
    PAD_controlRegisterClk,
    
    CONTROL_SA_RFBS_LF_DA_EN_I,
    CONTROL_SA_RFBS_LF_DA_EN_Q,

    CONTROL_CML_RFBS_LF_DA_EN_I,
    CONTROL_CML_RFBS_LF_DA_EN_Q,
    CONTROL_CML_RFBS_LF_CML_EN_I,
    CONTROL_CML_RFBS_LF_CML_EN_Q,
    
    
    CONTROL_LF_CML_RFBS_I_CLKSEL_PAD_ED,
    CONTROL_LF_CML_RFBS_I_CLKSEL_OFF_ON,
    CONTROL_LF_CML_RFBS_Q_CLKSEL_PAD_ED,
    CONTROL_LF_CML_RFBS_Q_CLKSEL_OFF_ON,
    
    CONTROL_LF_SA_RFBS_I_CLKSEL_PAD_ED,
    CONTROL_LF_SA_RFBS_I_CLKSEL_OFF_ON,
    CONTROL_LF_SA_RFBS_Q_CLKSEL_PAD_ED,
    CONTROL_LF_SA_RFBS_Q_CLKSEL_OFF_ON,
    
    CONTROL_LF_SA_S1_TAIL_VBIAS_EN,
    CONTROL_LF_CML_S1_TAIL_VBIAS_EN,
    
    CONTROL_LF_ED_OFF_ON,
    
    // Accumulator inputs/outputs
//    PAD_accumulatorReset,
    //accDataIn_InPhase,
    //accDataIn_Quadrature,
    
    SA_InPhase_Data,
    SA_Quad_Data,
    CML_InPhase_Data,
    CML_Quad_Data,
    SA_Data,
    
    PAD_accumulatorClk,
    sampleClk,
    PAD_serialClk,
    PAD_serialStart,
    PAD_serialOut
    );
    
    reg SRLatchOut;
    PDO24CDG SRLatchOut_pad(.I(SRLatchOut), .PAD(PAD_SRLatchOut));
    output PAD_SRLatchOut;

    PDIDGZ controlRegisterDataIn_pad(.C(controlRegisterDataIn), .PAD(PAD_controlRegisterDataIn));
    input PAD_controlRegisterDataIn;
    PDO24CDG controlRegisterDataOut_pad(.I(controlRegisterDataOut), .PAD(PAD_controlRegisterDataOut));
    output PAD_controlRegisterDataOut;
    PDIDGZ controlRegisterClk_pad(.C(controlRegisterClk), .PAD(PAD_controlRegisterClk));
    input PAD_controlRegisterClk;
    // Control Register signals
    output CONTROL_SA_RFBS_LF_DA_EN_I;
    output CONTROL_SA_RFBS_LF_DA_EN_Q;
    
    output CONTROL_CML_RFBS_LF_DA_EN_I;
    output CONTROL_CML_RFBS_LF_DA_EN_Q;
    output CONTROL_CML_RFBS_LF_CML_EN_I;
    output CONTROL_CML_RFBS_LF_CML_EN_Q;
    
    output CONTROL_LF_CML_RFBS_I_CLKSEL_PAD_ED;
    output CONTROL_LF_CML_RFBS_I_CLKSEL_OFF_ON;
    output CONTROL_LF_CML_RFBS_Q_CLKSEL_PAD_ED;
    output CONTROL_LF_CML_RFBS_Q_CLKSEL_OFF_ON;
    
    output CONTROL_LF_SA_RFBS_I_CLKSEL_PAD_ED;
    output CONTROL_LF_SA_RFBS_I_CLKSEL_OFF_ON;
    output CONTROL_LF_SA_RFBS_Q_CLKSEL_PAD_ED;
    output CONTROL_LF_SA_RFBS_Q_CLKSEL_OFF_ON;
    
    output CONTROL_LF_SA_S1_TAIL_VBIAS_EN;
    output CONTROL_LF_CML_S1_TAIL_VBIAS_EN;
    
    output CONTROL_LF_ED_OFF_ON;
    
    // Accumulator inputs
//    PDIDGZ accumulatorReset_pad (.C(accumulatorReset), .PAD(PAD_accumulatorReset));
//    input PAD_accumulatorReset;
//    input accDataIn_InPhase;
//    input accDataIn_Quadrature;


    input SA_InPhase_Data;
    input SA_Quad_Data;
    input CML_InPhase_Data;
    input CML_Quad_Data;
    input SA_Data;
    
    PDIDGZ accumulatorClk_pad(.C(accumulatorClk), .PAD(PAD_accumulatorClk));
    input PAD_accumulatorClk;
    output sampleClk;
    PDIDGZ serialClk_pad(.C(serialClk), .PAD(PAD_serialClk));
    input PAD_serialClk;
    PDO24CDG serialStart_pad(.I(serialStart), .PAD(PAD_serialStart));
    output PAD_serialStart;
    PDO24CDG serialOut_pad(.I(serialOut), .PAD(PAD_serialOut));
    output PAD_serialOut;
    
    wire SAMPLE_CLOCK_POLARITY;
    assign sampleClk = accumulatorClk ^ SAMPLE_CLOCK_POLARITY;
    assign accumulatorReset = controlRegisterClk == 1;
    
    wire [2:0] SR_LATCH_MUX_SEL;
    reg SR_LATCH_MUX_OUT;
    always @ (SA_InPhase_Data, SA_Quad_Data, CML_InPhase_Data, CML_Quad_Data, SA_Data, SR_LATCH_MUX_SEL) begin
        case(SR_LATCH_MUX_SEL)
            3'b000 : SR_LATCH_MUX_OUT = SA_InPhase_Data;
            3'b001 : SR_LATCH_MUX_OUT = SA_Quad_Data;
            3'b010 : SR_LATCH_MUX_OUT = CML_InPhase_Data;
            3'b011 : SR_LATCH_MUX_OUT = CML_Quad_Data;
            3'b100 : SR_LATCH_MUX_OUT = SA_Data;
            default : SR_LATCH_MUX_OUT = 1'b0;
        endcase
    end
    
    reg SA_InPhase_Data_flopped;
    reg SA_Quad_Data_flopped;
    reg CML_InPhase_Data_flopped;
    reg CML_Quad_Data_flopped;
    always @ (posedge accumulatorClk) begin
        SRLatchOut <= SR_LATCH_MUX_OUT;
        SA_InPhase_Data_flopped <= SA_InPhase_Data;
        SA_Quad_Data_flopped <= SA_Quad_Data;
        CML_InPhase_Data_flopped <= CML_InPhase_Data;
        CML_Quad_Data_flopped <= CML_Quad_Data;
    end
    
    wire [15:0] DSR;
    DigitalControlRegisters
         ControlRegisters_0 (.dataIn(controlRegisterDataIn), .dataOut(controlRegisterDataOut), .clk(controlRegisterClk),
        .DSR_0(DSR[0]),
        .DSR_1(DSR[1]),
        .DSR_2(DSR[2]),
        .DSR_3(DSR[3]),
        .DSR_4(DSR[4]),
        .DSR_5(DSR[5]),
        .DSR_6(DSR[6]),
        .DSR_7(DSR[7]),
        .DSR_8(DSR[8]),
        .DSR_9(DSR[9]),
        .DSR_10(DSR[10]),
        .DSR_11(DSR[11]),
        .DSR_12(DSR[12]),
        .DSR_13(DSR[13]),
        .DSR_14(DSR[14]),
        .DSR_15(DSR[15]),
        
        .SR_LATCH_MUX_SEL_2(SR_LATCH_MUX_SEL[2]),
        .SR_LATCH_MUX_SEL_1(SR_LATCH_MUX_SEL[1]),
        .SR_LATCH_MUX_SEL_0(SR_LATCH_MUX_SEL[0]),

        .SA_RFBS_LF_DA_EN_I(CONTROL_SA_RFBS_LF_DA_EN_I),
        .SA_RFBS_LF_DA_EN_Q(CONTROL_SA_RFBS_LF_DA_EN_Q),
    
        .CML_RFBS_LF_DA_EN_I(CONTROL_CML_RFBS_LF_DA_EN_I),
        .CML_RFBS_LF_DA_EN_Q(CONTROL_CML_RFBS_LF_DA_EN_Q),
        .CML_RFBS_LF_CML_EN_I(CONTROL_CML_RFBS_LF_CML_EN_I),
        .CML_RFBS_LF_CML_EN_Q(CONTROL_CML_RFBS_LF_CML_EN_Q),
   
        .LF_CML_RFBS_I_CLKSEL_PAD_ED(CONTROL_LF_CML_RFBS_I_CLKSEL_PAD_ED),
        .LF_CML_RFBS_I_CLKSEL_OFF_ON(CONTROL_LF_CML_RFBS_I_CLKSEL_OFF_ON),
        .LF_CML_RFBS_Q_CLKSEL_PAD_ED(CONTROL_LF_CML_RFBS_Q_CLKSEL_PAD_ED),
        .LF_CML_RFBS_Q_CLKSEL_OFF_ON(CONTROL_LF_CML_RFBS_Q_CLKSEL_OFF_ON),
        
        .LF_SA_RFBS_I_CLKSEL_PAD_ED(CONTROL_LF_SA_RFBS_I_CLKSEL_PAD_ED),
        .LF_SA_RFBS_I_CLKSEL_OFF_ON(CONTROL_LF_SA_RFBS_I_CLKSEL_OFF_ON),
        .LF_SA_RFBS_Q_CLKSEL_PAD_ED(CONTROL_LF_SA_RFBS_Q_CLKSEL_PAD_ED),
        .LF_SA_RFBS_Q_CLKSEL_OFF_ON(CONTROL_LF_SA_RFBS_Q_CLKSEL_OFF_ON),
        
        .LF_SA_S1_TAIL_VBIAS_EN(CONTROL_LF_SA_S1_TAIL_VBIAS_EN),
        .LF_CML_S1_TAIL_VBIAS_EN(CONTROL_LF_CML_S1_TAIL_VBIAS_EN),
        
        .LF_ED_OFF_ON(CONTROL_LF_ED_OFF_ON),
        
        .SAMPLE_CLOCK_POLARITY(SAMPLE_CLOCK_POLARITY)
        );
    
    AccumulatorSystem #(.ACC_WIDTH(16))
        AccumulatorSystem (.inputData_SA({SA_InPhase_Data_flopped, SA_Quad_Data_flopped}), .inputData_CML({CML_InPhase_Data_flopped, CML_Quad_Data_flopped}), .clk(accumulatorClk), .serialClk(serialClk), .reset(accumulatorReset), .DSRatio(DSR), .serialStart(serialStart), .serialOut(serialOut));

endmodule
