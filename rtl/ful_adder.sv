module full_adder(
    output wire c, s,    
    input wire a, b, cin
);

    wire t;
    
    assign t = a^b;
    assign c = (cin & t) | (a & b);
    assign s = t^cin;
    
endmodule
