`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 11:50:56
// Design Name: 
// Module Name: n_bit_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module n_bit_adder #(parameter WIDTH = 8) (

    output wire [WIDTH-1:0] s,
    output wire c,            
    input wire [WIDTH-1:0] a, b, 
    input wire cin,              
    input wire en,
    input wire rst,
    input wire clk

);

    wire [WIDTH-1:0] a_d [WIDTH:0]; /* The WIDTH array element is the results at the end of the pipeline */
    wire [WIDTH-1:0] b_d [WIDTH-1:0]; /* Not all of the bits are used */
    wire             c_d [WIDTH:0]; /* The WIDTH array element is the results at the end of the pipeline */ 

    assign a_d[0] = a;
    assign b_d[0] = b;
    assign c_d[0] = cin;
    
    genvar i, j;
    generate
        for(i = 0; i < WIDTH; i = i+1) begin: comp_gen
            /* For each pipeline stage in a pipelined adder */
            wire [WIDTH-1:0] a_q;
            wire [WIDTH-1:i] b_q;
            wire c_q;
            wire s_i;
            
            /* A total of 2*WIDTH-i+1 Registers are needed per stage*/
            dff #(WIDTH)   a_dff(a_q, a_d[i], en, rst, clk);
            dff #(WIDTH-i) b_dff(b_q, b_d[i][WIDTH-1:i], en, rst, clk);
            dff #(1)       c_dff(c_q, c_d[i], en, rst, clk);
            
            /* And a Full Adder */
            full_adder u_add(c_d[i+1], s_i, a_q[i], b_q[i], c_q);
            
            /* For all other bits of A except the current bit copy from a_q */
            for(j=0; j < WIDTH; j = j+1) begin: comp_a_d
                if(j == i) 
                    assign a_d[i+1][j] = s_i;
                else
                    assign a_d[i+1][j] = a_q[j];
            end
            
            if( i != WIDTH-1)
                assign b_d[i+1][WIDTH-1:i+1] = b_q[WIDTH-1:i+1]; /* Don't copy the current bit */
        end
    endgenerate
   
    assign s = a_d[WIDTH];
    assign c = c_d[WIDTH];
endmodule
