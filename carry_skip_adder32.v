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

//mux
module  mux(in_0,in_1 ,sel,mux_out);
	input in_0, in_1, sel ;
	output mux_out;
	reg  mux_out;

	always @ (sel or in_0 or in_1)
	begin : MUX
		if (sel == 1'b0) begin
 			mux_out = in_0;
		end else begin
			mux_out = in_1 ;
		end
	end
endmodule //mux


// skip logic
module skiplogic(cout1, a, b, cin,cout0);
	input [3:0] a,b;
	input cin,cout0;
	output cout1;
	
	wire o1,o2,o3,o4;
	xor(o1,a[0],b[0]);
	xor(o2,a[1],b[1]);
	xor(o3,a[2],b[2]);
	xor(o4,a[3],b[3]);
	and(w,o1,o2,o3,o4);
	
	mux mux(cout0,cin,w,cout1);
	

endmodule //skip logic

//carry-skip-adder
module skip_adder32(s, co, a, b, ci);
   
   output [31:0] s;
   output 	co;
   input [31:0] 	a, b;
   input 	ci;
   
   wire 	c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
   
   adder4	a0(s[3:0],c1, a[3:0],b[3:0], ci);
   skiplogic s0(c2, a[3:0],b[3:0],ci,c1);
   adder4 	a1(s[7:4],c3, a[7:4],b[7:4], c2);
   skiplogic s1(c4,a[7:4],b[7:4],c2,c3); 
   
   adder4 	a2(s[11:8],c5, a[11:8],b[11:8], c4);
   skiplogic s2(c6,a[11:8],b[11:8],c4,c5); 
   adder4 	a3(s[15:12],c7, a[15:12],b[15:12], c6);
   skiplogic s3(c8,a[15:12],b[15:12],c6,c7);   
   
   adder4 	a4(s[19:16],c9, a[19:16],b[19:16], c8);
   skiplogic s4(c10,a[19:16],b[19:16],c8,c9); 
   adder4 	a5(s[23:20],c11, a[23:20],b[23:20], c10);
   skiplogic s5(c12,a[23:20],b[23:20],c10,c11); 
   
   adder4 	a6(s[27:24],c13, a[27:24],b[27:24], c12);
   skiplogic s6(c14,a[27:24],b[27:24],c12,c13); 
   adder4 	a7(s[31:28],c15, a[31:28],b[31:28], c14);
   skiplogic s7(co,a[31:8],b[31:28],c14,c15); 
   
   
endmodule // carry-skip-adder32


