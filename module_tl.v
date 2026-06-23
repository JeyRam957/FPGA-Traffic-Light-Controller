`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 10:02:34
// Design Name: 
// Module Name: module_tl
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


module module_tl(
    input clk,
    input rst,
    input emergency_NS,
    input emergency_EW,

    output reg NS_R,
    output reg NS_Y,
    output reg NS_G,

    output reg EW_R,
    output reg EW_Y,
    output reg EW_G
);

parameter NS_GREEN  = 3'd0;
parameter NS_YELLOW = 3'd1;
parameter EW_GREEN  = 3'd2;
parameter EW_YELLOW = 3'd3;
parameter EM_NS     = 3'd4;
parameter EM_EW     = 3'd5;

reg [2:0] state;
reg [4:0] timer;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= NS_GREEN;
        timer <= 0;
    end
    else
    begin
        if(emergency_NS)
            state <= EM_NS;
        else if(emergency_EW)
            state <= EM_EW;
        else
        begin
            timer <= timer + 1;

            case(state)

            NS_GREEN:
                if(timer == 10)
                begin
                    state <= NS_YELLOW;
                    timer <= 0;
                end

            NS_YELLOW:
                if(timer == 3)
                begin
                    state <= EW_GREEN;
                    timer <= 0;
                end

            EW_GREEN:
                if(timer == 10)
                begin
                    state <= EW_YELLOW;
                    timer <= 0;
                end

            EW_YELLOW:
                if(timer == 3)
                begin
                    state <= NS_GREEN;
                    timer <= 0;
                end

            EM_NS:
                if(!emergency_NS)
                    state <= NS_GREEN;

            EM_EW:
                if(!emergency_EW)
                    state <= EW_GREEN;

            default:
                state <= NS_GREEN;

            endcase
        end
    end
end

always @(*)
begin

    NS_R = 0; NS_Y = 0; NS_G = 0;
    EW_R = 0; EW_Y = 0; EW_G = 0;

    case(state)

    NS_GREEN:
    begin
        NS_G = 1;
        EW_R = 1;
    end

    NS_YELLOW:
    begin
        NS_Y = 1;
        EW_R = 1;
    end

    EW_GREEN:
    begin
        NS_R = 1;
        EW_G = 1;
    end

    EW_YELLOW:
    begin
        NS_R = 1;
        EW_Y = 1;
    end

    EM_NS:
    begin
        NS_G = 1;
        EW_R = 1;
    end

    EM_EW:
    begin
        NS_R = 1;
        EW_G = 1;
    end

    endcase
end


endmodule
