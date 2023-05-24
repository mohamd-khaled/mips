module mips (intf.dut u1);

intf imips();

//instruction memory
ff M1 (imips.ff_m1);
left_shift M3 (imips.ls_m3);
adder M4 (imips.a_m4);
adder M5 (imips.a_m5);
sign_extend M6 (imips.se_m6);
mux2 M7 (imips.m_m7);

//countrol unit
control_unit M8 (imips.cu_m8);

//register file
regfile M9 (imips.rf_m9);
mux2 M10 (imips.m_m10);

//alu
mux2 M11 (imips.m_m11);
ALU M12 (imips.ALU_m12);

//datamemory
mux2 M14 (imips.m_m14);

endmodule