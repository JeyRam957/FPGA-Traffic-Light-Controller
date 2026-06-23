`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 10:04:33
// Design Name: 
// Module Name: tb
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


module tb;
reg clk;
reg rst;
reg emergency_NS;
reg emergency_EW;

wire NS_R, NS_Y, NS_G;
wire EW_R, EW_Y, EW_G;

module_tl uut(
    .clk(clk),
    .rst(rst),
    .emergency_NS(emergency_NS),
    .emergency_EW(emergency_EW),

    .NS_R(NS_R),
    .NS_Y(NS_Y),
    .NS_G(NS_G),

    .EW_R(EW_R),
    .EW_Y(EW_Y),
    .EW_G(EW_G)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    emergency_NS = 0;
    emergency_EW = 0;

    #20 rst = 0;

    #100 emergency_NS = 1;
    #50  emergency_NS = 0;

    #120 emergency_EW = 1;
    #50  emergency_EW = 0;

    #200 $stop;
end

endmodule
