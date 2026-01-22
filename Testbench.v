`timescale 1ns / 1ps

module tb_signals();
    reg clk, rst, din;
    wire [2:0] dout;
    
    signals dut(clk, rst, din, dout);
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $monitor("Time=%0tns clk=%b rst=%b din=%b dout=%b",
                 $time, clk, rst, din, dout);
        
        rst = 1;
        din = 0;
        #20 rst = 0;
        
        #40 din = 1;
        #20 din = 0;
        #60 din = 1;
        #100 din = 0;
        #80 din = 1;
        
        #200 $finish;
    end
endmodule
