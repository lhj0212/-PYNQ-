`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/09 11:27:53
// Design Name: 
// Module Name: IIR_Dir
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


module IIR_Dir(
    clk,            //AXIS_CLK
    clk_LPF,        //10M
    rst_n,
    din,
    data,
    dout,
    s_AXIS_tvalid,
    s_AXIS_tlast,
    s_AXIS_tready,
    current_state_moni,
    next_state_moni,
    count_moni,
    Q0_moni,
    Q1_moni,
    Q2_moni,
    Q3_moni,
    Q4_moni,
    Q5_moni,
    Q6_moni,
    Q7_moni,
    Q8_moni,
    Q9_moni,
    Q10_moni,
    Q11_moni
    
    );
input  signed   [31:0]  data;
input                   clk;
input                   clk_LPF;
input                   rst_n;
input  signed   [31:0]  din;
input                   s_AXIS_tvalid;
input                   s_AXIS_tlast;
input                   s_AXIS_tready;

output wire [3:0] current_state_moni;
output wire [3:0] next_state_moni;
output wire [4:0] count_moni;

output wire [15:0]  Q0_moni;
output wire [15:0]  Q1_moni;
output wire [15:0]  Q2_moni;
output wire [15:0]  Q3_moni;
output wire [15:0]  Q4_moni;
output wire [15:0]  Q5_moni;
output wire [15:0]  Q6_moni;
output wire [15:0]  Q7_moni;
output wire [15:0]  Q8_moni;
output wire [15:0]  Q9_moni;
output wire [15:0]  Q10_moni;
output wire [15:0]  Q11_moni;

assign Q0_moni  = Q0    +1'b1; 
assign Q1_moni  = Q1    +1'b1; 
assign Q2_moni  = Q2    +1'b1; 
assign Q3_moni  = Q3    +1'b1; 
assign Q4_moni  = Q4    +1'b1; 
assign Q5_moni  = Q5    +1'b1; 
assign Q6_moni  = Q6    +1'b1; 
assign Q7_moni  = Q7    +1'b1; 
assign Q8_moni  = Q8    +1'b1; 
assign Q9_moni  = Q9    +1'b1; 
assign Q10_moni = Q10   +1'b1;
assign Q11_moni = Q11   +1'b1;  
assign current_state_moni = current_state;
assign next_state_moni    = next_state;
assign count_moni         = count;

output signed   [47:0]  dout;

wire signed [47:0] Xout;
wire signed [31:0] Yin;
wire signed [47:0] Yout;
  
reg signed [15:0] Q0;  
reg signed [15:0] Q1;   
reg signed [15:0] Q2;   
reg signed [15:0] Q3; 
reg signed [15:0] Q4;   
reg signed [15:0] Q5;   
reg signed [15:0] Q6;   
reg signed [15:0] Q7;   
reg signed [15:0] Q8;   
reg signed [15:0] Q9;   
reg signed [15:0] Q10;   
reg signed [15:0] Q11;    
reg [4:0]count;
//²ÎÊýÉùÃ÷
parameter IDLE = 4'd0;
parameter S0 = 4'd1;
parameter S1 = 4'd2;

//ÄÚ²¿ÐÅºÅÉùÃ÷

reg[3:0] current_state;
reg[3:0] next_state;
reg[0:0] en;   //6¸öCLKÖ®ºó£»½øÈë¼ÆËãÄ£¿éµÄ Ê¹ÄÜ

//×´Ì¬¼Ä´æÆ÷
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

//´ÎÌ¬µÄ×éºÏÂß¼­
always @ (*) begin
    case(current_state)
        IDLE:
        begin
            if (s_AXIS_tvalid == 1) begin
                next_state = S0;
            end
            else begin
                next_state = IDLE;
            end
        end
        S0:
        begin
            if (s_AXIS_tvalid == 0) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
        end
        S1:
        begin
            if (count == 5'd14) begin
                next_state = IDLE;     
            end
            else
                next_state = S1;
        end
             
        default: ;
   endcase
end

always@(posedge clk or negedge rst_n)begin
if(~rst_n) begin
              Q0          <= 16'd0;
              Q1          <= 16'd0;
              Q2          <= 16'd0;
              Q3          <= 16'd0;
              Q4          <= 16'd0;
              Q5          <= 16'd0;
              Q6          <= 16'd0;
              Q7          <= 16'd0;
              Q8          <= 16'd0;
              Q9          <= 16'd0;
              Q10         <= 16'd0;
              Q11         <= 16'd0;   
              count       <= 5'd0;
              en          <= 1'd1;
           end
else begin
    case(next_state)
        S0:begin  
            case(count)
                0:begin
                    if(s_AXIS_tready == 1)begin
                        Q0 <=data[31:16];
                        Q1 <=data[15:0]; 
                        count <= count + 'd2;
                    end      
                    else;              
                end
                2:begin
                    if(s_AXIS_tready == 1)begin
                        Q2 <=data[31:16];
                        Q3 <=data[15:0]; 
                        count <= count + 'd2;
                    end
                    else;
                end
                4:begin
                    if(s_AXIS_tready == 1)begin
                        Q4 <=data[31:16];
                        Q5 <=data[15:0]; 
                        count <= count + 'd2;
                    end
                    else;
                end
                6:begin
                    if(s_AXIS_tready == 1)begin
                        Q6 <=data[31:16];
                        Q7 <=data[15:0]; 
                        count <= count + 'd2;
                    end
                    else;
                end
                8:begin
                    if(s_AXIS_tready == 1)begin
                        Q8 <=data[31:16];
                        Q9 <=data[15:0]; 
                        count <= count + 'd2;
                    end
                    else;
                end
                10:begin
                    if(s_AXIS_tready == 1)begin
                        Q10 <=data[31:16];
                        Q11 <=data[15:0]; 
                        count <= count + 'd2;
                    end
                    else;
                end
            default: count <= count;
            endcase
        end   
        S1:begin
            en <= 'd0;
            count <= count + 'd2;
        end   
        IDLE:begin
            count <= 'd0;
            en <= 'd1;
        end    
        endcase
    end
end



/*
clk_10M_gen clk_wiz
   (
    // Clock out ports
    .clk_out1(clk_10M),     // output clk_out1
//   .clk_out2(clk_200M),     // output clk_out2

   // Clock in ports
    .clk_in1(clk));      // input clk_in1  100M  
*/
  
 IIR_DirZero Zero(
    .clk(clk_LPF),
    .en(en),
    .rst_n(rst_n),
    .Xin(din),
    .data(data),
    .Xout(Xout),
    .Q0(  Q0),
    .Q1(  Q1),
    .Q2(  Q2),
    .Q3(  Q3)
    );

 
    IIR_DirPole Pole(
    .clk(clk_LPF),
    .en(en),
    .rst_n(rst_n),
    .Yin(Yin),
    .data(data),
    .Yout(Yout),
    .Q5(Q5), 
    .Q6(Q6), 
    .Q7(Q7), 
    .Q8(Q8), 
    .Q9(Q9), 
    .Q10(Q10),
    .Q11(Q11)    
    );

    wire signed [47:0] Ysum;
    assign Ysum = Xout - Yout;

    div_gen_0 div (
       .aclk(clk),                                      // input wire aclk
       .s_axis_divisor_tvalid(1'b1),    // input wire s_axis_divisor_tvalid
       .s_axis_divisor_tdata(Ysum),      // input wire [47 : 0] s_axis_divisor_tdata
       .s_axis_dividend_tvalid(1'b1),  // input wire s_axis_dividend_tvalid
       .s_axis_dividend_tdata(Q4),    // input wire [15 : 0] s_axis_dividend_tdata
     //  .m_axis_dout_tvalid(m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
       .m_axis_dout_tdata(Yin)            // output wire [63 : 0] m_axis_dout_tdata
);
    
    assign dout = Xout - Yout;
    
endmodule
