module ff(input logic clk,
input logic [31:0] d,
output logic [31:0] q);
always @(posedge clk)
q <= d;
endmodule