module testbench();
    reg clk, reset;

    initial begin
        clk = 0;
        reset = 1;
        #12 reset = 0;
    end

    always #10 clk = ~clk;

    mips mips(
        .clk(clk),
        .reset(reset)
    );

endmodule