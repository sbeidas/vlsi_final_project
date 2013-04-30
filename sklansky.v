
module grey_box(g_out, p ,g,g_old);
  input  p,g,g_old;
  output g_out;
  wire and_out,or_out;
  or(g_out, and_out,g);
  and(and_out, p, g_old); 
endmodule // adder8


module black_box(g_out,p,g,p_old,g_old);
  input  p,g,p_old,g_old;
  output b_g_out,b_p_out;
  wire and1_out,and2_out,or_out;
  
  and(and1_out, p, g_old);
  and(b_p_out, p, p_old);
  or(b_g_out, g,and1_out);

endmodule // adder8


