module csa32 #(parameter WIDTH = 3) (
    input wire [WIDTH-1:0] A, B, C,
    output wire [WIDTH-1:0] Co, Sum
);
    genvar i;
    generate
	for (i = 0; i < WIDTH; i = i + 1) begin : Full_Adder
            sum1b n (.a(A[i]), .b(B[i]), .ci(C[i]), .so(Sum[i]), .co(Co[i]));
	end
    endgenerate
endmodule
