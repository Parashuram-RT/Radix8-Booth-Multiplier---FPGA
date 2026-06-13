`timescale 1ns / 1ps

module tb_radix8_booth_multiplier;

    // Testbench signals
    reg signed [31:0] multiplicand;
    reg signed [31:0] multiplier;
    wire signed [63:0] product;

    // Instantiate the DUT (Device Under Test)
    radix8_booth_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    initial begin
        // Display header
        $display("Time\tMultiplicand\tMultiplier\tProduct");
        $monitor("%0dns\t%d\t\t%d\t\t%d", $time, multiplicand, multiplier, product);

        // Test cases
		  
        
        multiplicand = -32'd8; multiplier = -32'd8; #10;    // -8 * -8 = 64
        multiplicand = 32'd25; multiplier = 32'd10; #10;    // 25 * 10 = 250
        multiplicand = -32'd100; multiplier = 32'd50; #10;  // -100 * 50 = -5000
        multiplicand = 32'd0;  multiplier = 32'd1234; #10;  // 0 * 1234 = 0

        #10;
        multiplicand = 32'd555; multiplier = -32'd20; #10;
		  
		  multiplicand =-32'd5; multiplier = -32'd20; #10;
        $finish;
    end

endmodule
