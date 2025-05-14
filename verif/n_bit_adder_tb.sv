module n_bit_adder_tb;

    parameter WIDTH = 8;
    
    reg  [WIDTH-1:0] a, b;
    reg  cin, en, rst, clk;
    wire [WIDTH-1:0] s;
    wire c;

    integer i;

    // Instantiate the adder
    n_bit_adder #(WIDTH) dut (
        .s(s),
        .c(c),
        .a(a),
        .b(b),
        .cin(cin),
        .en(en),
        .rst(rst),
        .clk(clk)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize
        a   = 0;
        b   = 0;
        cin = 0;
        en  = 1;
        rst = 0;

        // Wait some time before starting
        #20;

        for (i = 0; i < 50; i = i + 1) begin
            @(posedge clk);
            a   = $random;
            b   = $random;
            cin = $random % 2;

            // Apply reset at iteration 40
            if (i == 40) begin
                rst = 1;
                @(posedge clk);
                rst = 0;
            end
        end

        // Finish after the loop
        #50;
        $finish;
    end
		initial begin
    		$dumpfile("dump.vcd"); 
    		$dumpvars;
		end
endmodule
