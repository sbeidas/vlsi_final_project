module pg_block(g_out, p_out,a,b);
  input a, b;
  output g_out, p_out;

  and(g_out,a,b);
  xor(p_out,a,b);

endmodule //pg_block

module pg_8block(p_out,g_out,a,b);
  input [7:0] a,b;
  output [8:1] g_out,p_out;

  pg_block pg1(g_out[1],p_out[1],a[0],b[0]);
  pg_block pg2(g_out[2],p_out[2],a[1],b[1]);
  pg_block pg3(g_out[3],p_out[3],a[2],b[2]);
  pg_block pg4(g_out[4],p_out[4],a[3],b[3]);
  pg_block pg5(g_out[5],p_out[5],a[4],b[4]);
  pg_block pg6(g_out[6],p_out[6],a[5],b[5]);
  pg_block pg7(g_out[7],p_out[7],a[6],b[6]);
  pg_block pg8(g_out[8],p_out[8],a[7],b[7]);

endmodule //pg_8block

module pg_32block(p_out,g_out,a,b,cin);
  input [31:0] a,b;
  input cin;
  output [32:0] g_out,p_out;  

  assign g_out[0] = cin;
  assign p_out[0] = 0;
  pg_8block pg8_1(g_out[8:1],p_out[8:1],a[7:0],b[7:0]);
  pg_8block pg8_2(g_out[16:9],p_out[16:9],a[15:8],b[15:8]);
  pg_8block pg8_3(g_out[24:17],p_out[24:17],a[23:16],b[23:16]);
  pg_8block pg8_4(g_out[32:25],p_out[32:25],a[31:24],b[31:24]);

endmodule //pg_32block

module sum_block(s,p,g);
  input g,p;
  output s;

  xor(s,g,p);

endmodule //sum_block

module sum_8block(s,p,g);
  input [8:0] p,g;
  output [7:0] s;

  sum_block s1(s[0],g[0],p[1]);
  sum_block s2(s[1],g[1],p[2]);
  sum_block s3(s[2],g[2],p[3]);
  sum_block s4(s[3],g[3],p[4]);
  sum_block s5(s[4],g[4],p[5]);
  sum_block s6(s[5],g[5],p[6]);
  sum_block s7(s[6],g[6],p[7]);
  sum_block s8(s[7],g[7],p[8]);

endmodule //sum_8block

module sum_32block(s,cout,p,g);
  input [32:0] p,g;
  output [31:0] s;
  output cout;
  
  wire w1;
  
  sum_8block s8_1(s[7:0],p[8:0],g[8:0]);
  sum_8block s8_2(s[15:8],p[16:8],g[16:8]);
  sum_8block s8_3(s[23:16],p[24:16],g[24:16]);
  sum_8block s8_4(s[31:24],p[32:24],g[32:24]);
                  //calculate cout
  and(w1,g[31],p[32]);
  or(cout,w1,g[32]);
  
endmodule  //sum_32block

module grey_box(g_out, p ,g,g_old);
  input p,g,g_old;
  output g_out;

  wire and_out,or_out;

  and(and_out, p, g_old);
  or(g_out, and_out,g);
endmodule // grey_box


module black_box(p_out,g_out,p,g,p_old,g_old);
  input p,g,p_old,g_old;
  output g_out,p_out;

  wire and1_out;
  
  and(and1_out, p, g_old);
  and(p_out, p, p_old);
  or(g_out, g,and1_out);

endmodule // black_box

module grey_blocks8(p_out,g_out,p_in,g_in,cool_g);
input [7:0] p_in,g_in;
input cool_g;
output [7:0] p_out,g_out;

assign p_out = p_in;
grey_box greyb1(g_out[0],p_in[0],g_in[0],cool_g);
grey_box greyb2(g_out[1],p_in[1],g_in[1],cool_g);
grey_box greyb3(g_out[2],p_in[2],g_in[2],cool_g);
grey_box greyb4(g_out[3],p_in[3],g_in[3],cool_g);
grey_box greyb5(g_out[4],p_in[4],g_in[4],cool_g);
grey_box greyb6(g_out[5],p_in[5],g_in[5],cool_g);
grey_box greyb7(g_out[6],p_in[6],g_in[6],cool_g);
grey_box greyb8(g_out[7],p_in[7],g_in[7],cool_g);

endmodule //grey_blocks8

module black_blocks8(p_out,g_out,p_in,g_in,cool_p,cool_g);
input [7:0] p_in,g_in;
input cool_g,cool_p;
output [7:0] p_out,g_out;

black_box blackb1(p_out[0],g_out[0],p_in[0],g_in[0],cool_p,cool_g);
black_box blackb2(p_out[1],g_out[1],p_in[1],g_in[1],cool_p,cool_g);
black_box blackb3(p_out[2],g_out[2],p_in[2],g_in[2],cool_p,cool_g);
black_box blackb4(p_out[3],g_out[3],p_in[3],g_in[3],cool_p,cool_g);
black_box blackb5(p_out[4],g_out[4],p_in[4],g_in[4],cool_p,cool_g);
black_box blackb6(p_out[5],g_out[5],p_in[5],g_in[5],cool_p,cool_g);
black_box blackb7(p_out[6],g_out[6],p_in[6],g_in[6],cool_p,cool_g);
black_box blackb8(p_out[7],g_out[7],p_in[7],g_in[7],cool_p,cool_g);

endmodule //black_blocks8

module sklansky_logic8(p_out,g_out,p,g);
  input  [7:0] p,g;
  output [7:0] p_out,g_out;

  wire  w1p,w1g,w2p,w2g,w3p,w3g,w4p,w4g,w5p,w5g, gout1,gout3;

  assign    g_out[0] = g[0];            //pin 0
  assign    p_out[0] = p[0];

  grey_box  gb1(gout1,p[1],g[1],g[0]);    //pin 1
  assign    p_out[1] = p[1];
  assign    g_out[1] = gout1;

  grey_box  gb2(g_out[2],p[2],g[2],gout1);    //pin 2
  assign    p_out[2] = p[2];

  black_box bb1(w1p,w1g,p[3],g[3],p[2],g[2]);    //pin 3
  grey_box  gb3(gout3,w1p,w1g,gout1);
  assign    p_out[3] = p[3];
  assign    g_out[3] = gout3;

  grey_box  gb4(g_out[4],p[4],g[4],gout3);    //pin 4
  assign    p_out[4] = p[4];
  black_box bb2(w2p,w2g,p[5],g[5],p[4],g[4]);    //pin 5
  grey_box  gb5(g_out[5],w2p,w2g,gout3);
  assign    p_out[5] = p[5];
  black_box bb3(w3p,w3g,p[6],g[6],w2p,w2g);    //pin 6
  grey_box  gb6(g_out[6],w3p,w3g,gout3);
  assign    p_out[6] = p[6];
  
  black_box bb4(w4p,w4g,p[7],g[7],p[6],g[6]);    //pin 7
  black_box bb5(w5p,w5g,w4p,w4g,w2p,w2g);
  grey_box  gb7(g_out[7],w5p,w5g,gout3);
  assign    p_out[7] = p[7];
  

endmodule //slansky_logic_8bit

module sklansky_logic8b(p_out,g_out,p,g);
  input  [7:0] p,g;
  output [7:0] p_out,g_out;

  wire  [3:0] p_s1,g_s1,p_s2,g_s2; //key : p_s1 = pout at stage 1

  assign    g_out[0] = g[0];           //pin 0
  assign    p_out[0] = p[0];

  black_box  gb1(p_s1[0],g_s1[0],p[1],g[1],p[0],g[0]);     //pin 1
  assign    p_out[1] = p_s1[0];
  assign    g_out[1] = g_s1[0];

  black_box  gb2(p_out[2],g_out[2],p[2],g[2],p_s1[0],g_s1[0]);     //pin 2
  assign    p_out[2] = p[2];

  black_box bb1(p_s1[1],g_s1[1],p[3],g[3],p[2],g[2]);     //pin 3
  black_box  gb3(p_s2[0],g_s2[0],p_s1[1],g_s1[1],p_s1[0],g_s1[0]);
  assign    p_out[3] = p_s2[0];
  assign    g_out[3] = g_s2[0];

  black_box  gb4(p_out[4],g_out[4],p[4],g[4],p_s2[0],g_s2[0]); //pin 4

  black_box bb2(p_s1[2],g_s1[2],p[5],g[5],p[4],g[4]); //pin 5
  black_box  gb5(p_out[5],g_out[5],p_s1[2],g_s1[2],p_s2[0],g_s2[0]);

  black_box bb3(p_s2[1],g_s2[1],p[6],g[6],p_s1[2],g_s1[2]); //pin 6
  black_box  gb6(p_out[6],g_out[6],p_s2[1],g_s2[1],p_s2[0],g_s2[0]);
  
  black_box bb4(p_s1[3],g_s1[3],p[7],g[7],p[6],g[6]); //pin 7
  black_box bb5(p_s2[2],g_s2[2],p_s1[3],g_s1[3],p_s1[2],g_s1[2]);
  black_box  gb7(p_out[7],g_out[7],p_s2[2],g_s2[2],p_s2[0],g_s2[0]);
  
endmodule //slansky_logic8_black


module sklansky_logic32(p_out,g_out,p,g);
  input  [32:0] p,g;
  inout [32:0] p_out,g_out;

  wire [7:0] skl8_p,skl8_g,skl8b_p,skl8b_g,skl8b2_p,skl8b2_g,black8b1_p,black8b1_g,skl8b3_p,skl8b3_g,grey8b2_p,grey8b2_g;
//0-7 bits
  sklansky_logic8 skl8(skl8_p[7:0],skl8_g[7:0],p[7:0],g[7:0]);
  assign p_out[7:0] = skl8_p;
  assign g_out[7:0] = skl8_g;
//8-15 bits  
  sklansky_logic8b skl8b1(skl8b_p,skl8b_g,p[15:8],g[15:8]);
  grey_blocks8 grey8b1(p_out[15:8],g_out[15:8],skl8b_p[7:0],skl8b_g[7:0],skl8_g[7]);
//16-23 bits  
  sklansky_logic8b skl8b2(skl8b2_p,skl8b2_g,p[23:16],g[23:16]);
  grey_blocks8 grey8b2(p_out[23:16],g_out[23:16],skl8b2_p[7:0],skl8b2_g[7:0],g_out[15]);
//   assign p_out[23:16] = 
//   assign g_out[23:16] = 
//24-31 bits  
  sklansky_logic8b skl8b3(skl8b3_p,skl8b3_g,p[31:24],g[31:24]);
  black_blocks8 black8b1(black8b1_p,black8b1_g,skl8b3_p[7:0],skl8b3_g[7:0],skl8b2_p[7],skl8b2_g[7]); //also passing in the 23 bits p and g
  grey_blocks8 grey8b3(p_out[31:24],g_out[31:24],black8b1_p,black8b1_g,g_out[15]); 
//pin 32
  assign    g_out[32]=g[32];            
  assign    p_out[32]=p[32];
  
endmodule //sklansky_logic32

module sklansky_adder32(s,cout,a,b,cin);
  input [31:0] a,b;
  input cin;
  output [31:0] s;
  output cout;

  wire [32:0] p_in,g_in,p_out,g_out;

  pg_32block  pgb(p_in,g_in,a,b,cin);
  sklansky_logic32 sl8(p_out,g_out,p_in,g_in);
  sum_32block sb32(s,cout,p_out,g_out);

endmodule //sklansky_adder32
