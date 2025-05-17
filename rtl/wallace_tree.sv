module wallace_tree #(parameter WIDTH = 10, CHANNELS = 6) (
    input wire [WIDTH-1:0] inputs [0:CHANNELS-1],
    output wire [WIDTH-1:0] Co, Sum
);
    integer input_wires = CHANNELS;
    integer stages = 0;
    while (input_wires > 3) begin
        moduls = input_wires / 3;
        pass_through_wires = input_wires % 3;
        input_wires = 2*moduls + pass_through_wires;
        stages = stages+1;
    end
    //input wires 
    wire [WIDTH-1:0] tree [0:stages][0:CHANNELS-1]
    
    //stage 0
    genvar k;
    generate
        for (k = 0; k < CHANNELS; k = k + 1) begin : ASSIGN_INPUTS
            assign tree[0][k] = inputs[k];
        end
    endgenerate

    genvar stage, i;
	generate
        input_wires = CHANNELS;
        stage = 0;
        while (input_wires > 3) begin
            moduls = input_wires / 3;
            pass_through_wires = input_wires % 3;
            input_wires = 2*moduls + pass_through_wires;

            for (i=0; i<3*moduls; i=i+3) begin : CSA
                csa32 n (.a(tree[stage][i+2]), .b(tree[stage][i+1]), .ci(tree[stage][i]), .so(tree[stage+1][i+1]), .co(tree[stage+1][i]));
            end
            stage = stage + 1;
        end
	endgenerate

    //last stage
    assign Co = tree[stages][1]
    assign Sum = tree[stages][0]
endmodule