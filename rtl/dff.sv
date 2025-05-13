`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 12:26:27
// Design Name: 
// Module Name: dff
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


module dff #(parameter WIDTH = 1)(

    output reg [WIDTH-1:0] q,
    input wire [WIDTH-1:0] d,
    input wire en,
    input wire rst,
    input wire clk
);

    always @(posedge clk)
       if(rst == 1'b1)
          q <= 'b0;
       else 
          q <= d;
        
endmodule
