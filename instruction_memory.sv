module inst_memory(input logic [31:0] Address,
                    output logic [31:0] Instruction);

	
logic [31:0] RAM[63:0];
initial
$readmemh("memfile.dat", RAM);
assign Instruction = RAM[Address]; 

endmodule