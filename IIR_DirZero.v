`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/09 11:27:53
// Design Name: 
// Module Name: IIR_DirZero
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


module IIR_DirZero(
    clk,
    rst_n,
    Xin,
    Xout,
    data,
    Q0,
    Q1,
    Q2,
    Q3,
    en
    );
    input [1:0] en;
    input signed [15:0] Q0;
    input signed [15:0] Q1;
    input signed [15:0] Q2;
    input signed [15:0] Q3;
    input [31:0] data;
    input clk;
    input rst_n;
    input signed [31:0] Xin;
    output signed [47:0] Xout;


    reg signed [31:0] Xin_reg [6:0];
    reg [3:0] i,j;
    
    
    always @(posedge clk or negedge en or negedge rst_n) begin : proc_
        if((~en)&&(~rst_n)) begin
            Xin_reg[0] = 32'd0;
            Xin_reg[1] = 32'd0;
            Xin_reg[2] = 32'd0;
            Xin_reg[3] = 32'd0;
            Xin_reg[4] = 32'd0;
            Xin_reg[5] = 32'd0;
            Xin_reg[6] = 32'd0;
        end 
        else begin
            Xin_reg[6] <= Xin_reg[5];
            Xin_reg[5] <= Xin_reg[4];
            Xin_reg[4] <= Xin_reg[3];
            Xin_reg[3] <= Xin_reg[2];
            Xin_reg[2] <= Xin_reg[1];
            Xin_reg[1] <= Xin_reg[0];
            Xin_reg[0] <= Xin;            
        end
    end

    wire signed [32:0] Add_reg[3:0];  //33bits 转成有符号型
    assign Add_reg[0] = {Xin[31],Xin}  +  {Xin_reg[6][31], Xin_reg[6]};
    assign Add_reg[1] = {Xin_reg[0][31],Xin_reg[0]} + {Xin_reg[5][31],Xin_reg[5]};
    assign Add_reg[2] = {Xin_reg[1][31],Xin_reg[1]} + {Xin_reg[4][31],Xin_reg[4]};
    assign Add_reg[3] = {Xin_reg[2][31],Xin_reg[2]} + {Xin_reg[3][31],Xin_reg[3]};

    wire signed [47:0] Mult_wire[3:0];  //48bits

   

//   assign Qb[0] =  16'd7;   //4+2+1      ; 2,1,0       ;47-32-2   47-32-1   47-32-0
//   assign Qb[1] =  16'd31;  //16+8+4+2+1 ; 4,3,2,1,0   ;15-4   15-3  15-2  15-1  15
//   assign Qb[2] =  16'd70;  //64+4+2     ; 6,2,1       ;15-6   15-2  15-1
//   assign Qb[3] =  16'd102; //64+32+4+2  ; 6,5,2,1


//    assign Mult_wire[0] = {{13{Add_reg[0][32]}} , Add_reg[0], 2'd0} + 
//                         {{14{Add_reg[0][32]}} , Add_reg[0], 1'd0} +
//                         {{15{Add_reg[0][32]}} , Add_reg[0]};

//    assign Mult_wire[1] = {{11{Add_reg[1][32]}} , Add_reg[1], 4'd0} + 
//                         {{12{Add_reg[1][32]}} , Add_reg[1], 3'd0} +
//                         {{13{Add_reg[1][32]}} , Add_reg[1], 2'd0} +
//                         {{14{Add_reg[1][32]}} , Add_reg[1], 1'd0} +
//                         {{15{Add_reg[1][32]}} , Add_reg[1]} 
//                         ;

//    assign Mult_wire[2] =  {{9{Add_reg[2][32]}} , Add_reg[2], 6'd0} + 
//                         {{13{Add_reg[2][32]}} , Add_reg[2], 2'd0} +
//                         {{14{Add_reg[2][32]}} , Add_reg[2], 1'd0} 
//                         ;

//    assign Mult_wire[3] =  {{9{Add_reg[3][32]}} , Add_reg[3], 6'd0} + 
//                         {{10{Add_reg[3][32]}} , Add_reg[3], 5'd0} +
//                         {{13{Add_reg[3][32]}} , Add_reg[3], 2'd0} +
//                         {{14{Add_reg[3][32]}} , Add_reg[3], 1'd0} 
//                         ;

//    reg signed [47:0] Mult_reg[3:0];
//    always @(posedge clk)begin
//        Mult_reg[0] <= Mult_wire[0];
//        Mult_reg[1] <= Mult_wire[1];
//        Mult_reg[2] <= Mult_wire[2];
//        Mult_reg[3] <= Mult_wire[3];
//    end

    assign Xout =  Mult_wire[0] +  Mult_wire[1] +  Mult_wire[2] +  Mult_wire[3];

mult_zero mult_zero_1 (
  .CLK(clk),  // input wire CLK
  .A(Add_reg[0]),      // input wire [32 : 0] A
  .B(Q0),      // input wire [11 : 0] B
  .P(Mult_wire[0])      // output wire [47 : 0] P
);

mult_zero mult_zero_2 (
  .CLK(clk),  // input wire CLK
  .A(Add_reg[1]),      // input wire [32 : 0] A
  .B(Q1),      // input wire [11 : 0] B
  .P(Mult_wire[1])      // output wire [47 : 0] P
);

mult_zero mult_zero_3 (
  .CLK(clk),  // input wire CLK
  .A(Add_reg[2]),      // input wire [32 : 0] A
  .B(Q2),      // input wire [11 : 0] B
  .P(Mult_wire[2])      // output wire [47 : 0] P
);

mult_zero mult_zero_4 (
  .CLK(clk),  // input wire CLK
  .A(Add_reg[3]),      // input wire [32 : 0] A
  .B(Q3),      // input wire [11 : 0] B
  .P(Mult_wire[3])      // output wire [47 : 0] P
);


endmodule
