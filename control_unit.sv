module control_unit(input logic [5:0] op, funct,
					input logic zero, 
					output logic memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump,
					output logic [2:0] alucontrol);

	logic branch;
	logic [1:0] aluop;
	
always@(*)
begin
	case(op)
	6'b000000: 
	begin 
		//Rtype
		regwrite <= 1'b1;
		regdst  <= 1'b1;
		alusrc <= 1'b0;
		branch <= 1'b0;
		memtoreg <= 1'b0;
		memwrite <= 1'b0;
		aluop <= 2'b10;
		jump <= 1'b0;
	end
	6'b100011:
	begin 
		// LW
		regwrite <= 1'b1;
		regdst  <= 1'b0;
		alusrc <= 1'b1;
		branch <= 1'b0;
		memtoreg <= 1'b0;
		memwrite <= 1'b1;
		aluop <= 2'b00;
		jump <= 1'b0;
	end 
	6'b101011:
	begin 
		// SW
		regwrite <= 1'b0;
		regdst  <= 1'bx;
		alusrc <= 1'b1;
		branch <= 1'b0;
		memtoreg <= 1'b1;
		memwrite <= 1'bx;
		aluop <= 2'b00;
		jump <= 1'b0;
	end
	6'b000100: 
	begin 
		// BEQ
		regwrite <= 1'b0;
		regdst  <= 1'bx;
		alusrc <= 1'b0;
		branch <= 1'b1;
		memtoreg <= 1'b0;
		memwrite <= 1'bx;
		aluop <= 2'b01;
		jump <= 1'b0;
	end
	6'b001000:
	begin 
		// ADDI
		regwrite <= 1'b1;
		regdst  <= 1'b0;
		alusrc <= 1'b1;
		branch <= 1'b0;
		memtoreg <= 1'b0;
		memwrite <= 1'b0;
		aluop <= 2'b00;
		jump <= 1'b0;
	end
	6'b000010:
	begin 
		// J
		regwrite <= 1'b0;
		regdst  <= 1'bx;
		alusrc <= 1'bx;
		branch <= 1'bx;
		memtoreg <= 1'b0;
		memwrite <= 1'bx;
		aluop <= 2'bxx;
		jump <= 1'b1;
	end
	default:begin 
		// illegal op
		regwrite <= 1'bx;
		regdst  <= 1'bx;
		alusrc <= 1'bx;
		branch <= 1'bx;
		memtoreg <= 1'bx;
		memwrite <= 1'bx;
		aluop <= 2'bxx;
		jump <= 1'bx;
	end 
	endcase
	case(aluop)
		2'b00: alucontrol <= 3'b010; //add (for lw/sw/addi)
		2'b01: alucontrol <= 3'b110; //sub (for beq)
		2'b10 :case(funct) // R-type instructions
					6'b100000: alucontrol <= 3'b010; // add
					6'b100010: alucontrol <= 3'b110; // sub
					6'b100100: alucontrol <= 3'b000; // and
					6'b100101: alucontrol <= 3'b001; // or
					6'b101010: alucontrol <= 3'b111; // slt
					default: alucontrol <= 3'bxxx; // ???
				endcase
		default : alucontrol <= 3'bxxx;
	endcase
end
	assign pcsrc = branch & zero;
endmodule