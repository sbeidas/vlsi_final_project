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