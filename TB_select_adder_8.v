`timescale 1ns/10ps

module carry_select_8_TB;

reg ci;
reg [7:0] a,b;

wire co;
wire [7:0] s;

select_adder8 adder1(s,co,a,b,ci);
   

initial begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#1000 $finish;		
	$shm_close();   // Closes the waveform database
end

// Stimulate the Input Signals
initial begin
	a = 5;
	b = 10;
	ci = 1;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 37;
	b = 48;
	ci = 0;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 125;
	b = 110;
	ci = 1;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 63;
	b = 211;
	ci = 0;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 122;
	b = 11;
	ci = 1;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 245;
	b = 2;
	ci = 0;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 3;
	b = 90;
	ci = 1;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 100;
	b = 200;
	ci = 0;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);

	a = 127;
	b = 127;
	ci = 1;
	#100 $display("At Time: %d   %d+%d with cin=%d Sum=%d Carry=%d",$time, a, b, ci,s,co);	
end
endmodule // carry_select_8_TB

