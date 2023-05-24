module data_mem(input logic clk, we,
               input logic [31:0] a, wd,
               output logic [31:0] rd);

logic [31:0] RAM[63:0];
assign rd = RAM[a[31:0]];

always @(posedge clk)
begin
     if (we) 
          RAM[a[31:0]] <= wd;
end
endmodule