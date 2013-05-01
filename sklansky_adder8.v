module pg_block(g_out, p_out,a,b);
  input a, b;
  output g_out, p_out;

  and(g_out,a,b);
  xor(p_out,a,b);

endmodule //pg_block

module pg_8block(p_out,g_out,a,b,cin);
  input [7:0] a,b;
  input cin;
  output [8:0] g_out,p_out;
  
  
  assign g_out[0] = cin;
  pg_block pg1(g_out[1],p_out[1],a[0],b[0]);
  pg_block pg2(g_out[2],p_out[2],a[1],b[1]);
  pg_block pg3(g_out[3],p_out[3],a[2],b[2]);
  pg_block pg4(g_out[4],p_out[4],a[3],b[3]);
  pg_block pg5(g_out[5],p_out[5],a[4],b[4]);
  pg_block pg6(g_out[6],p_out[6],a[5],b[5]);
  pg_block pg7(g_out[7],p_out[7],a[6],b[6]);
  pg_block pg8(g_out[8],p_out[8],a[7],b[7]);

endmodule //pg_8block

module sum_block(s,p,g);
  input g,p;
  output s;

  xor(s,g,p);

endmodule //sum_block

module sum_8block(s,cout,p,g);
  input [8:0] p,g;
  output [7:0] s;
  output cout;

  sum_block s1(s[0],g[0],p[1]);
  sum_block s2(s[1],g[1],p[2]);
  sum_block s3(s[2],g[2],p[3]);
  sum_block s4(s[3],g[3],p[4]);
  sum_block s5(s[4],g[4],p[5]);
  sum_block s6(s[5],g[5],p[6]);
  sum_block s7(s[6],g[6],p[7]);
  sum_block s8(s[7],g[7],p[8]);
  				//calculate cout
  and(w1,g[7],p[7]);
  or(cout,w1,g[8]);

endmodule //sum_8block

module grey_box(g_out, p ,g,g_old);
  input p,g,g_old;
  output g_out;

  wire and_out,or_out;

  and(and_out, p, g_old);
  or(g_out, and_out,g);
endmodule // grey_box


module black_box(g_out,p_out,p,g,p_old,g_old);
  input p,g,p_old,g_old;
  output g_out,p_out;

  wire and1_out;
  
  and(and1_out, p, g_old);
  and(p_out, p, p_old);
  or(g_out, g,and1_out);

endmodule // black_box

module sklansky_logic8(p_out,g_out,p,g);
  input  [8:0] p,g;
  output [8:0] p_out,g_out;

  wire  w1p,w1g,w2p,w2g,w3p,w3g,w4p,w4g,w5p,w5g, gout1,gout3;

  assign    g_out[0] = g[0];			//pin 0
  assign    p_out[0] = p[0];

  grey_box  gb1(gout1,p[1],g[1],g[0]);	//pin 1
  assign    p_out[1] = p[1];
  assign    g_out[1] = gout1;

  grey_box  gb2(g_out[2],p[2],g[2],g[1]);	//pin 2
  assign    p_out[2] = p[2];

  black_box bb1(w1p,w1g,p[3],g[3],p[2],g[2]);	//pin 3
  grey_box  gb3(gout3,w1p,w1g,gout1);
  assign    p_out[3] = p[3];
  assign    g_out[3] = gout3;

  grey_box  gb4(g_out[4],p[4],g[4],gout3);	//pin 4
  assign    p_out[4] = p[4];
  black_box bb2(w2p,w2g,p[5],g[5],p[4],g[4]);	//pin 5
  grey_box  gb5(g_out[5],w2p,w2g,gout3);
  assign    p_out[5] = p[5];
  black_box bb3(w3p,w3g,p[6],g[6],w2p,w2g);	//pin 6
  grey_box  gb6(g_out[6],w3p,w3g,gout3);
  assign    p_out[6] = p[6];
  black_box bb4(w4p,w4g,p[7],g[7],p[6],g[6]);	//pin 7
  black_box bb5(w5p,w5g,w4p,w4g,w2p,w2g);
  grey_box  gb7(g_out[7],w5p,w5g,gout3);
  assign    p_out[7] = p[7];
  
 // grey_box  gb8(g_out[8],p[8],g[8],g[7]);	//pin 8
  assign    p_out[8]=p[8];

endmodule //slansky_logic_8bit

module sklansky_adder8(s,cout,a,b,cin);
  input [7:0] a,b;
  input cin;
  output [7:0] s;
  output cout;

  wire [8:0] p_in,g_in,p_out,g_out;

  pg_8block  pgb(p_in,g_in,a,b,cin);
  sklansky_logic8 sl8(p_out,g_out,p_in,g_in);
  sum_8block sb8(s,cout,p_out,g_out);

endmodule //sklansky_adder8
  
  
  
