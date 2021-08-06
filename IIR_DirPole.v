`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/09 11:27:53
// Design Name: 
// Module Name: IIR_DirPole
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


module IIR_DirPole(
    clk,
    rst_n,
    Yin,
    Yout,
    data,
    Q5,
    Q6,
    Q7,
    Q8,
    Q9,
    Q10,
    Q11,
    en
    );
    input        [1: 0] en;
    input signed [15:0] Q5;
    input signed [15:0] Q6;
    input signed [15:0] Q7;
    input signed [15:0] Q8;
    input signed [15:0] Q9;
    input signed [15:0] Q10;
    input signed [15:0] Q11;
    input        [31:0] data;
    input clk;
    input rst_n;
    input signed [31:0] Yin;
    output wire signed [47:0] Yout;
     reg signed [31:0] Yin_reg[6:0];

     

    always @(posedge clk or negedge en or negedge rst_n) begin : proc_
        if((~en)&&(~rst_n)) begin
            Yin_reg[0] <= 32'd0;
            Yin_reg[1] <= 32'd0;
            Yin_reg[2] <= 32'd0;
            Yin_reg[3] <= 32'd0;
            Yin_reg[4] <= 32'd0;
            Yin_reg[5] <= 32'd0;
            Yin_reg[6] <= 32'd0;
        end 
        else begin
            Yin_reg[6] <= Yin_reg[5];
            Yin_reg[5] <= Yin_reg[4];
            Yin_reg[4] <= Yin_reg[3];
            Yin_reg[3] <= Yin_reg[2];
            Yin_reg[2] <= Yin_reg[1];
            Yin_reg[1] <= Yin_reg[0];
            Yin_reg[0] <= Yin;
        end
    end

 

//    assign Qa[0]  =  16'd923;   //512+256+128+16+8+2+1                (9,8,7,4,3,1,0)
//    assign Qa[1]  = -16'd1651;  //1024+512+64+32+16+2+1               10,9,6,5,4,1,0
//    assign Qa[2]  =  16'd2047;  //1024+512+256+128+64+32+16+8+4+2+1   10,9,8,7,6,5,4,3,2,1,0
//    assign Qa[3]  = -16'd1434;  //1024+256+128+16+8+2                 10,8,7,4,3,1
//    assign Qa[4]  =  16'd715;   //512+128+64+8+2+1                    9,7,6,3,1,0
//    assign Qa[5]  = -16'd216;   //128+64+16+8                         7,6,4,3
//    assign Qa[6]  =  16'd40;    //32+8                                5,3
//    assign Qa[7]  = -16'd3;     //2+1                                 1,0
                    

   wire signed [47:0] Mult_wire[6:0];


////Yin_reg[0] * Qa[1]
//  assign Mult_wire[0] = { {6{Yin_reg[0][31]}} , Yin_reg[0], 10'd0} + 
//                       { {7{Yin_reg[0][31]}} , Yin_reg[0], 9'd0} +
//                       {{10{Yin_reg[0][31]}} , Yin_reg[0], 6'd0} +
//                       {{11{Yin_reg[0][31]}} , Yin_reg[0], 5'd0} +
//                       {{12{Yin_reg[0][31]}} , Yin_reg[0], 4'd0} +
//                       {{15{Yin_reg[0][31]}} , Yin_reg[0], 1'd0} +
//                       {{16{Yin_reg[0][31]}} , Yin_reg[0]};

////Yin_reg[1] * Qa[2]
//  assign Mult_wire[1] = { {6{Yin_reg[1][31]}} , Yin_reg[1], 10'd0} + 
//                       { {7{Yin_reg[1][31]}} , Yin_reg[1], 9'd0} +
//                       { {8{Yin_reg[1][31]}} , Yin_reg[1], 8'd0} +
//                       { {9{Yin_reg[1][31]}} , Yin_reg[1], 7'd0} +
//                       {{10{Yin_reg[1][31]}} , Yin_reg[1], 6'd0} +
//                       {{11{Yin_reg[1][31]}} , Yin_reg[1], 5'd0} +
//                       {{12{Yin_reg[1][31]}} , Yin_reg[1], 4'd0} +
//                       {{13{Yin_reg[1][31]}} , Yin_reg[1], 3'd0} +
//                       {{14{Yin_reg[1][31]}} , Yin_reg[1], 2'd0} +
//                       {{15{Yin_reg[1][31]}} , Yin_reg[1], 1'd0} +
//                       {{16{Yin_reg[1][31]}} , Yin_reg[1]};  

////Yin_reg[2] * Qa[3]
//  assign Mult_wire[2] = { {6{Yin_reg[2][31]}} , Yin_reg[2], 10'd0} + 
//                       { {8{Yin_reg[2][31]}} , Yin_reg[2], 8'd0}  +
//                       { {9{Yin_reg[2][31]}} , Yin_reg[2], 7'd0}  +
//                       {{12{Yin_reg[2][31]}} , Yin_reg[2], 4'd0}  +
//                       {{13{Yin_reg[2][31]}} , Yin_reg[2], 3'd0}  +
//                       {{15{Yin_reg[2][31]}} , Yin_reg[2], 1'd0};

////Yin_reg[3] * Qa[4] 
//  assign Mult_wire[3] = { {7{Yin_reg[3][31]}} , Yin_reg[3], 9'd0} +
//                       { {9{Yin_reg[3][31]}} , Yin_reg[3], 7'd0} +
//                       {{10{Yin_reg[3][31]}} , Yin_reg[3], 6'd0} +
//                       {{13{Yin_reg[3][31]}} , Yin_reg[3], 3'd0} +
//                       {{15{Yin_reg[3][31]}} , Yin_reg[3], 1'd0} +
//                       {{16{Yin_reg[3][31]}} , Yin_reg[3]}; 

////Yin_reg[4] * Qa[5]
//  assign Mult_wire[4] = { {9{Yin_reg[4][31]}} , Yin_reg[4], 7'd0} +
//                       {{10{Yin_reg[4][31]}} , Yin_reg[4], 6'd0} +
//                       {{12{Yin_reg[4][31]}} , Yin_reg[4], 4'd0} +
//                       {{13{Yin_reg[4][31]}} , Yin_reg[4], 3'd0};

////Yin_reg[5] * Qa[6]
//  assign Mult_wire[5] = {{11{Yin_reg[5][31]}} , Yin_reg[5], 5'd0} +
//                       {{13{Yin_reg[5][31]}} , Yin_reg[5], 3'd0} ;

////Yin_reg[6] * Qa[7]
//  assign Mult_wire[6] = {{15{Yin_reg[6][31]}} , Yin_reg[6], 1'd0} +
//                       {{16{Yin_reg[6][31]}} , Yin_reg[6]};


//reg signed [47:0] Mult_reg[6:0];
//    always @(posedge clk)begin
//        Mult_reg[0] <= Mult_wire[0];
//        Mult_reg[1] <= Mult_wire[1];
//        Mult_reg[2] <= Mult_wire[2];
//        Mult_reg[3] <= Mult_wire[3];
//        Mult_reg[4] <= Mult_wire[2];
//        Mult_reg[5] <= Mult_wire[3];
//        Mult_reg[6] <= Mult_wire[2];
//    end

assign Yout = Mult_wire[1] + Mult_wire[0] +  Mult_wire[2] + 
               Mult_wire[3] +  Mult_wire[4]  +  Mult_wire[5] + 
               Mult_wire[6] ;

mult_pole mult_pole_1 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[0]),      // input wire [31 : 0] A
  .B(Q5),      // input wire [11 : 0] B
  .P(Mult_wire[0])     ); // output wire [47 : 0] P);
  
mult_pole mult_pole_2 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[1]),      // input wire [31 : 0] A
  .B(Q6),      // input wire [11 : 0] B
  .P(Mult_wire[1])     );   // output wire [47 : 0] P);
  
mult_pole mult_pole_3 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[2]),      // input wire [31 : 0] A
  .B(Q7),      // input wire [11 : 0] B
  .P(Mult_wire[2])    );    // output wire [47 : 0] P);
  
mult_pole mult_pole_4 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[3]),      // input wire [31 : 0] A
  .B(Q8),      // input wire [11 : 0] B
  .P(Mult_wire[3])    );    // output wire [47 : 0] P);
  
mult_pole mult_pole_5 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[4]),      // input wire [31 : 0] A
  .B(Q9),      // input wire [11 : 0] B
  .P(Mult_wire[4])   );     // output wire [47 : 0] P);
  
mult_pole mult_pole_6 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[5]),      // input wire [31 : 0] A
  .B(Q10),      // input wire [11 : 0] B
  .P(Mult_wire[5])   );     // output wire [47 : 0] P);
  
mult_pole mult_pole_7 (
  .CLK(clk),  // input wire CLK
  .A(Yin_reg[6]),      // input wire [31 : 0] A
  .B(Q11),      // input wire [11 : 0] B
  .P(Mult_wire[6])   );     // output wire [47 : 0] P);


endmodule
