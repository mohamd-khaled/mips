interface intf (input bit clk);
logic [31:0] pc_1,pc_2;
logic [31:0] instr;
logic [31:0] pcplus4;
logic zero;
logic memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump;
logic [2:0] alucontrol;
logic [31:0] signimm;
logic [4:0] writereg40;
logic [31:0] result;
logic [31:0] rd1data,rd2data;
logic [31:0] aluresult;
logic [31:0] readdata;
logic [31:0] signshift;
logic [31:0] pcbranch;
logic [31:0] srcb;

//wires for instruction memory
logic [31:0] plus4;
assign  plus4 = 32'b100;
logic [15:0] sign_ex_in;
assign  sign_ex_in = instr[15:0];

//wires for countrol unit
logic [5:0] op;
assign  op = instr[31:26];
logic [5:0] funct;
assign  funct = instr[5:0];

//wires for register file
logic [4:0] a1;
assign  a1 = instr[25:21];
logic [4:0] a2;
assign  a2 = instr[20:16];
logic [4:0] mux_2nd_in;
assign  mux_2nd_in = instr[15:11];

clocking cb1 @(posedge clk);
    output instr,readdata;
endclocking


modport dut (input clk,instr,readdata, output pc_2,memwrite,aluresult,rd2data);
modport tb (input pc_2,memwrite,aluresult,rd2data ,clocking cb1);

//instruction memory
modport ff_m1 (input clk,pc_1, output pc_2);
modport im_m2 (input pc_2, output instr);
modport ls_m3 (input signimm, output signshift);
modport a_m4 (input pc_2,plus4, output pcplus4);
modport a_m5 (input pcplus4,signshift, output pcbranch);
modport se_m6 (input sign_ex_in, output signimm);
modport m_m7 (input pcplus4,pcbranch,pcsrc, output pc_1);


//countrol unit
modport cu_m8 (input op,funct, output zero,memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump,alucontrol);

//register file
modport rf_m9 (input clk,regwrite,a1,a2,writereg40,result, output rd1data,rd2data);
modport m_m10 (input a2,mux_2nd_in,regdst, output writereg40);

//alu
modport m_m11 (input rd2data,signimm,alusrc, output srcb);
modport ALU_m12 (input rd1data,srcb,alucontrol, output zero,aluresult);

//datamemory
modport dm_m13 (input clk,memwrite,aluresult,rd2data, output readdata);
modport m_m14 (input aluresult,readdata,memtoreg, output result);

endinterface