
module adder8test;

reg ci;
reg [7:0] a,b;

wire co;
wire [7:0] s;

adder8 adder1(s,co,a,b,ci);
   

initial begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#1000 $finish;		
	$shm_close();   // Closes the waveform database
end

// Stimulate the Input Signals
initial begin
	a = 500	;
	b = 1000;
	ci = 1;
	#20 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 320;
	b = 400;
	ci = 0;
	#40 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	
end

endmodule // stimulus
