module regfile(input logic clk,
                input logic we3,
                input logic [4:0] a1, a2, a3,
                input logic [31:0] wd3,
                output logic [31:0] rd1, rd2);

logic [31:0] rf[31:0];

always  @(posedge clk)
begin
    if (we3) 
        begin rf[a3] <= wd3; end
    else 
    begin
        if  (a1 != 0)
            rd1 <=  rf[a1];
        else
            rd1 <= 0;
        if (a2 != 0)
            rd2 <= rf[a2];
        else
            rd2 <= 0;
    end
end
endmodule