`timescale 1ns / 1ps

module signals(
    input clk,
    input rst,
    input din,
    output reg [2:0] dout
);
    parameter idle=0;
    parameter Red=1;
    parameter Yellow=2;
    parameter Green=3;
    
    reg [1:0] state, nstate;
    reg [2:0] count;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state <= idle;
            count <= 0;
        end
        else begin
            state <= nstate;
            if(state == nstate)
                count <= count + 1;
            else
                count <= 0;
        end
    end

    always @(*) begin
        case(state)
            idle: begin
                dout = 3'b000;
                nstate = Red;
            end
            
            Red: begin
                dout = 3'b100;
                nstate = (din && count >= 3) ? Yellow : Red;
            end
            
            Yellow: begin
                dout = 3'b010;
                nstate = (din && count >= 1) ? Green : Yellow;
            end
            
            Green: begin
                dout = 3'b001;
                nstate = (din && count >= 5) ? Red : Green;
            end
            
            default: begin
                dout = 3'b000;
                nstate = idle;
            end
        endcase
    end
endmodule
