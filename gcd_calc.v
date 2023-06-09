module gcd_calc(
    input clk, rst, start,
    input [7:0] P, Q,
    output reg [7:0] R,
    output reg done
);

reg [7:0] p, q, r;
reg [2:0] s;

parameter
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100;

always @ (posedge clk, negedge rst)
    if (!rst) begin
        R = 0;
        done <= 0;
        s <= S0;
    end
    else begin
        case (s)
            S0: begin
                p <= P;
                q <= Q;
                r <= 8'b00000000;
                done <= 0;
                if (start) s <= S1;
            end
            S1: begin
                if (p == q) s <= S4;
                else if (q > p) s <= S2;
                else s <= S3;
            end
            S2: begin
                p <= q;
                q <= p;
                s <= S1;
            end
            S3: begin
                p <= p - q;
                s <= S1;
            end
            S4: begin
                r <= p;
                done <= 1;
                if (!start) s <= S0;
            end
            default: s <= S0;
        endcase
    end

assign R = r;

endmodule
