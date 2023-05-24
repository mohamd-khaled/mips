module test(intf.tb itb);

class transaction;
rand logic [31:0] instr;
rand logic [31:0] readdata;
endclass

transaction tr;

covergroup covport;
    cp1 : coverpoint tr.instr{bins instruction = {[$:0]};}
    cp2 : coverpoint tr.readdata{bins readdata = {[$:0]};}
    cross cp1, cp2;
endgroup

initial begin
    covport c1;
    c1 = new();
    tr = new();

    repeat (100) begin
        assert (tr.randomize);
        c1.sample();
        @itb.cb1;
    end
end

always @(itb.cb1)
begin
    if (itb.memwrite) begin
        if (itb.aluresult===84 & itb.rd2data===7) begin
            $display("Simulation succeeded");
        end 
        else if (itb.aluresult !==80) begin
            $display("Simulation failed");
        end
    end
end

endmodule