module csa32 #(parameter N = 3) (
    input wire [N-1:0] A, B, C,
    output wire [N-1:0] Co, Sum
);
    genvar i;
	generate
		for (i = 0; i < N; i = i + 1) begin : Full_Adder
            sum1b n (.a(A[i]), .b(B[i]), .ci(C[i]), .so(Sum[i]), .co(Co[i]));
		end
	endgenerate
endmodule
