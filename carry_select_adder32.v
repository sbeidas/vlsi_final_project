module select_adder4(s,cout,a,b,cin);
    output [3:0] s;
    output 	cout;
    input [3:0] a,b;
    input cin;
   
   wire adder0_carry,adder1_carry;
   wire [3:0] s1_zero,s1_one;
   
   adder4 	adder0(s1_zero,adder0_carry, a,b, 1'b0);
   adder4 	adder1(s1_one,adder1_carry, a,b, 1'b1);
   mux_4bit mux (s1_zero,s1_one,cin,s);
   assign cout =(cin & adder1_carry) | adder0_carry;

endmodule


//select-skip-adder
module select_adder32(s, cout, a, b, ci);

  output [31:0] s;
  output 	cout;
  input 	ci;
  input [31:0] a,b;
  wire 	c0,c1,c2,c3,c4,c5,c6;

	//s[3:0]
	adder4	a0(s[3:0],c0, a[3:0],b[3:0], ci);																							
	//s[7:4]
	select_adder4 SA1 (s[7:4],c1, a[7:4],b[7:4], c0);	
	//s[11:8]
	select_adder4 SA2 (s[11:8],c2, a[11:8],b[11:8], c1);	
	//s[15:12]
	select_adder4 SA3 (s[15:12],c3, a[15:12],b[15:12], c2);	
	//s[19:16]
	select_adder4 SA4 (s[19:16],c4, a[19:16],b[19:16], c3);	
	//s[23:20]
	select_adder4 SA5 (s[23:20],c5, a[23:20],b[23:20], c4);	
	//s[27:24]
	select_adder4 SA6 (s[27:24],c6, a[27:24],b[27:24], c5);
	//s[31:28]
	select_adder4 SA7 (s[31:28],cout, a[31:28],b[31:28], c6);	
   
endmodule 




