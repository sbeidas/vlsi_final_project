//select-skip-adder
module select_adder8(s, cout, a, b, ci);

   output [7:0] s;
   output 	cout;
   input 	ci;
   input [7:0] a,b;
   wire 	c0,c1,c1_zero,c1_one;
   wire [3:0] s1_zero,s1_one;
   
   //s[3:0]
   adder4	a0(s[3:0],c0, a[3:0],b[3:0], ci);																							
   
   //s[4:0]
   adder4 	a1_c0(s1_zero,c1_zero, a[7:4],b[7:4], 1'b0);
   adder4 	a1_c1(s1_one,c1_one, a[7:4],b[7:4], 1'b1);
   mux_4bit mux (s1_zero,s1_one,c0,s[7:4]);
   
   assign cout =(c0 & c1_one) | c1_zero;
   
endmodule // select-skip-adder8



