// Adder 
module adder(s, co, a, b, ci);

   output s, co;
   input  a, b, ci;
   
   wire   o0, o1, o2;
   
   xor(s, a, b, ci);
   
   or(o0, a, b);
   or(o1, b, ci);
   or(o2, ci, a);
   and(co, o0, o1, o2);
   
endmodule // adder


module adder4(s, co, a, b, ci);
   
   output [3:0] s;
   output 	co;
   input [3:0] 	a, b;
   input 	ci;
   
   wire 	c1, c2, c3;
   
   adder a0(s[0], c1, a[0], b[0], ci);
   adder a1(s[1], c2, a[1], b[1], c1);
   adder a2(s[2], c3, a[2], b[2], c2);
   adder a3(s[3], co, a[3], b[3], c3);

   
      
endmodule // adder4