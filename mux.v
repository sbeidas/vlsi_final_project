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

module  mux_4bit(in_0,in_1 ,sel,mux_out);
	input [3:0] in_0, in_1;
	input sel ;
	output [3:0]  mux_out;
	reg [3:0]  mux_out;
	always @ (sel or in_0 or in_1)
	begin : MUX
		if (sel == 1'b0) begin
 			mux_out = in_0;
		end else begin
			mux_out = in_1 ;
		end
	end
endmodule //mux