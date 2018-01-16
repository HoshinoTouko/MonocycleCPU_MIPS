/*
 * Module: Generatic.mux
 * Author: Touko
 * Create at 2017-11-15 09:58
 */
module mux(
    input wire[31:0] d0,
    input wire[31:0] d1,
    input wire signal,
    output wire[31:0] output_data
);

    assign output_data = signal ? d1 : d0;
    always@(*) begin
        // $display("d0: 0x%x, d1: 0x%x", d0, d1);
        // $display("Select 0x%x", output_data);
    end
endmodule