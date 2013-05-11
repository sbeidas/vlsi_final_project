module HA(sout,cout,a,b);
  output sout,cout;
  input a,b;
  assign sout=a^b;
  assign cout=(a&b);
endmodule
module FA(sout,cout,a,b,cin);
  output sout,cout;
  input a,b,cin;
  assign sout=(a^b^cin);  
  assign cout=((a&b)|(a&cin)|(b&cin));
endmodule

module multiply4bits(product,inp1,inp2);
  output [7:0]product;
  input [3:0]inp1;
  input [3:0]inp2;
  assign product[0]=(inp1[0]&inp2[0]);
  wire x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17;
  
HA HA1(product[1],x1,(inp1[1]&inp2[0]),(inp1[0]&inp2[1]));
HA HA3(product[2],x15,x2,(inp1[2]&inp2[0]));
HA HA4(product[3],x12,x14,(inp1[3]&inp2[0]));
FA FA8(product[4],x11,x13,(inp1[3]&inp2[1]),x12);
FA FA7(product[5],x10,x9,(inp1[3]&inp2[2]),x11);
FA FA6(product[6],product[7],x8,(inp1[3]&inp2[3]),x10);

FA FA1(x2,x3,inp1[1]&inp2[1],(inp1[0]&inp2[2]),x1);
FA FA2(x4,x5,(inp1[1]&inp2[2]),(inp1[0]&inp2[3]),x3);
HA HA2(x6,x7,(inp1[1]&inp2[3]),x5);

FA FA5(x14,x16,x4,(inp1[2 ]&inp2[1]),x15);
FA FA4(x13,x17,x6,(inp1[2]&inp2[2]),x16);
FA FA3(x9,x8,x7,(inp1[2]&inp2[3]),x17);

endmodule

///////////////////////////////////////////////////////////////
module input_3_1_bit_adder(sum,carry_out,in1,in2,in3,carry_in);
input in1,in2,in3,carry_in;

output sum,carry_out;

wire r1;

FA F1(r1,c_0,in2,in1,carry_in);
FA F2(sum,carry_out,in3,r1,c_0);
endmodule

///////////////////////////////////////////////////////////////
module input_1_4_bit_adder(sum,carry_out,in1,in2,in3,carry_in);
input [3:0]in1;
input [3:0]in2;
input [3:0]in3;
input  carry_in;

output [3:0] sum;
output carry_out;

wire c_0,c_1,c_2,c_3;

input_3_1_bit_adder R1(sum,c_0,in1[0],in2[0],in3[0],carry_in);
input_3_1_bit_adder R2(sum[1],c_1,in1[1],in2[1],in3[1],c_0);
input_3_1_bit_adder R3(sum[2],c_2,in1[2],in2[2],in3[2],c_1);
input_3_1_bit_adder R4(sum[3],carry_out,in1[3],in2[3],in3[3],c_2);
endmodule

module multiply8bits(product,inp1,inp2);

output [15:0]product;
input [7:0]inp1;
input [7:0]inp2;

wire x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12; 
wire[3:0] a,b,c,d;
wire[7:0] b_d,a_d,c_b,a_c;

assign a = inp1[7:4];
assign b = inp1[3:0];
assign c = inp2[7:4];
assign d = inp2[3:0];

multiply4bits M1(b_d,b,d);
multiply4bits M2(a_d,a,d);
multiply4bits M3(c_b,c,b);
multiply4bits M4(a_c,a,c);

//ab x cd = (b x d) + (a x d)<<4 + (c x b)<<4 + (a x c)<<8
assign product[3:0]=b_d[3:0];
assign product[15:12]=a_c[7:4];

input_1_4_bit_adder r1(product[7:4],x1,b_d[7:4],a_d[3:0],c_b[3:0],0);
input_1_4_bit_adder r2(product[11:8],x2,a_c[3:0],a_d[7:4],c_b[7:4],x1);

input_1_4_bit_adder test(x7,x2,b_d[3:0],b,a,0);
input_1_4_bit_adder a343(x9,x2,b_d[3:0],b,b_d,0);

endmodule


  