
module adder32test;

reg ci;
reg [31:0] a,b;

wire co;
wire [31:0] s;

adder32 adder1(s,co,a,b,ci);
   

initial begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#1000 $finish;		
	$shm_close();   // Closes the waveform database
end

// Stimulate the Input Signals
initial begin
	a = 520;
	b = 10;
	ci = 1;
	#5 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 37;
	b = 48;
	ci = 0;
	#10 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 125;
	b = 110;
	ci = 1;
	#15 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 63;
	b = 211;
	ci = 0;
	#20 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 122;
	b = 11;
	ci = 1;
	#25 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 245;
	b = 2;
	ci = 0;
	#30 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 3;
	b = 90;
	ci = 1;
	#35 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 100;
	b = 200;
	ci = 0;
	#40 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);

	a = 127;
	b = 127;
	ci = 1;
	#45 $display("At Time: %d  Sum=%d Carry=%d",$time,s,co);
end

endmodule // stimulus
