`timescale 1ns/1ps
module radix8_booth_multiplier (
    input  signed [31:0] multiplicand,
    input  signed [31:0] multiplier,
    output reg signed [63:0] product
);
    integer k;
    reg signed [63:0] A;
    reg signed [35:0] M;          // multiplier + guard bits
    reg [3:0] booth_bits;
    reg signed [63:0] partial;

    always @(*) begin
        // sign-extend both operands
        A = {{32{multiplicand[31]}}, multiplicand};
        M = {multiplier, 3'b0};   // three guard bits for radix-8
        product = 0;

        // 32-bit multiplier → ceil(32/3)=11 groups
        for (k = 0; k < 11; k = k + 1) begin
            booth_bits = M[3:0];
            partial = 0;

            case (booth_bits)
                4'b0000, 4'b1111: partial = 0;
                4'b0001, 4'b0010: partial =  A;          // +1*A
                4'b0011, 4'b0100: partial =  (A <<< 1);  // +2*A
                4'b0101, 4'b0110: partial =  (A <<< 1) + A; // +3*A
                4'b0111:           partial =  (A <<< 2);  // +4*A
                4'b1000:           partial = -(A <<< 2);  // -4*A
                4'b1001, 4'b1010:  partial = -((A <<< 1) + A); // -3*A
                4'b1011, 4'b1100:  partial = -(A <<< 1);  // -2*A
                4'b1101, 4'b1110:  partial = -A;          // -1*A
            endcase

            product = product + (partial <<< (3 * k - 2));

            M = M >>> 3;
        end
    end
endmodule