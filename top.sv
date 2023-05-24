module top ();
bit clk;
always #10 clk=~clk;


intf imips1(clk);

//mips
mips m(imips1.dut);

//instructionmemory
inst_memory M2 (imips1.im_m2);

//datamemory
data_mem M13 (imips1.dm_m13);

endmodule