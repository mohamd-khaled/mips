module ALU (
    input logic [31:0] srcA, srcB,
    input  logic [2:0] alucontrol ,
    output logic        zero,
    output logic [31:0] aluresult
);
always @(*)
begin
case(alucontrol)
3'b010: begin aluresult <= srcA + srcB; zero <= 1'b0; end
3'b110: begin aluresult <= srcA - srcB; zero <= 1'b0; end
3'b000: begin aluresult <= srcA & srcB; zero <= 1'b0; end
3'b001: begin aluresult <= srcA | srcB; zero <= 1'b0; end
3'b111: begin
    if(srcA>srcB)
    begin
    aluresult <= 32'b0;
    zero <= 1'b1;
    end
    else
    begin
    aluresult <= 1'd1;
    zero <= 1'b0;
    end
end
endcase
end
endmodule