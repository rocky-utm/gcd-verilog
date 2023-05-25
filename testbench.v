module gcd_calc_tb();
reg t_clk, t_rst, t_start;
reg [7:0] t_P, t_Q;
wire [7:0] t_R;
wire t_done;


gcd_calc gcd_calc_inst(
.clk(t_clk),
.rst(t_rst),
.start(t_start),
.P(t_P),
.Q(t_Q),
.R(t_R),
.done(t_done)
);

always #10 t_clk = ~t_clk;

initial begin
    t_clk = 0;
    t_rst = 1;
    t_start = 0;
    t_P = 0;
    t_Q = 0;
end

initial begin
    #10 t_rst = 0;
    #10 t_rst = 1;

    #10 t_P = 8'b00000110;
        t_Q = 8'b00000100;
        t_start = 1;

end

initial
    $monitor("clk=%b rst=%b start=%b P=%b Q=%b R=%b done=%b", t_clk, t_rst, t_start, t_P, t_Q, t_R, t_done);
endmodule
