set_units -time ns -capacitance pf -voltage v -resistance ohm

create_clock -name "controlRegisterClk" -period 10 -waveform {0.0 5.0} [get_ports PAD_controlRegisterClk]
create_clock -name "accumulatorClk" -period 1.0 -waveform {0.0 0.5} [get_ports PAD_accumulatorClk]
create_clock -name "serialClk" -period 3.0 -waveform {0.0 1.5} [get_ports PAD_serialClk]

set_clock_groups -asynchronous -group {controlRegisterClk accumulatorClk serialClk}
