


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


module adder32(s, co, a, b, ci);
   
   output [31:0] s;
   output 	co;
   input [31:0] a, b;
   input 	ci;
   
   wire 	c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
   
   adder a0(s[0], c1, a[0], b[0], ci);
   adder a1(s[1], c2, a[1], b[1], c1);
   adder a2(s[2], c3, a[2], b[2], c2);
   adder a3(s[3], c4, a[3], b[3], c3);
   adder a4(s[4], c5, a[4], b[4], c4);
   adder a5(s[5], c6, a[5], b[5], c5);
   adder a6(s[6], c7, a[6], b[6], c6);
   adder a7(s[7], c8, a[7], b[7], c7);

   adder a8(s[8], c9, a[8], b[8], c8);
   adder a9(s[9], c10, a[9], b[9], c9);
   adder a10(s[10], c11, a[10], b[10], c10);
   adder a11(s[11], c12, a[11], b[11], c11);
   adder a12(s[12], c13, a[12], b[12], c12);
   adder a13(s[13], c14, a[13], b[13], c13);
   adder a14(s[14], c15, a[14], b[14], c14);
   adder a15(s[15], c16, a[15], b[15], c15);
   adder a16(s[16], c17, a[16], b[16], c16);
   adder a17(s[17], c18, a[17], b[17], c17);
   adder a18(s[18], c19, a[18], b[18], c18);
   adder a19(s[19], c20, a[19], b[19], c19);
   adder a20(s[20], c21, a[20], b[20], c20);
   adder a21(s[21], c22, a[21], b[21], c21);
   adder a22(s[22], c23, a[22], b[22], c22);
   adder a23(s[23], c24, a[23], b[23], c23);
   adder a24(s[24], c25, a[24], b[24], c24);
   adder a25(s[25], c26, a[25], b[25], c25);
   adder a26(s[26], c27, a[26], b[26], c26);
   adder a27(s[27], c28, a[27], b[27], c27);
   adder a28(s[28], c29, a[28], b[28], c28);
   adder a29(s[29], c30, a[29], b[29], c29);
   adder a30(s[30], c31, a[30], b[30], c30);
   adder a31(s[31], co, a[31], b[31], c31);
 
      
endmodule // adder8


