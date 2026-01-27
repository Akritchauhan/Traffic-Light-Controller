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



// other code
module traffic_light(
  input clk,
  input rst,
  output reg [1:0] ns,
  output reg [1:0] ew);
  
  parameter S0 = 2'b00,  // NS GREEN, EW RED
            S1 = 2'b01,  // NS YELLOW, EW RED
            S2 = 2'b10,  // NS RED, EW GREEN
            S3 = 2'b11;  // NS RED, EW YELLOW
  
  reg [1:0] state,nstate;
  
  always @(posedge clk)begin
    if(rst)
      state<=S0;
  else
    state<=nstate;
  end
  
  always @(*)begin
    case(state)
      S0:nstate=S1;
      S1:nstate=S2;
      S2:nstate=S3;
      S3:nstate=S0;
      default:nstate=S0;
    endcase
  end
  
  always @(*)begin
    ns = 2'b00;
    ew = 2'b00;

    case (state)
      S0: begin ns = 2'b10; ew = 2'b00; end   //00=green,01=yellow,10=red;
      S1: begin ns = 2'b01; ew = 2'b00; end
      S2: begin ns = 2'b00; ew = 2'b10; end
      S3: begin ns = 2'b00; ew = 2'b01; end
    endcase
  end

endmodule
      
