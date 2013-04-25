
module carry_select_32_TB;

reg ci;
reg [31:0] a,b;

wire co;
wire [31:0] s;

select_adder32 adder1(s,co,a,b,ci);
   
initial begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#1000 $finish;		
	$shm_close();   // Closes the waveform database
end

// Stimulate the Input Signals
initial begin
	a = 5	;
	b = 10;
	ci = 1;
	#20 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 10;
	b = 33;
	ci = 0;
	#40 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);
	
	a = 641322;
	b = 542343;
	ci = 0;
	#100 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	
end

endmodule // stimulus
