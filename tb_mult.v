
`timescale 1ns/10ps

module MULT_TB;


reg [3:0] inp1,inp2;

wire[7:0] product;


multiply8bits adder1(product,inp1,inp2);
   

initial begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#1000 $finish;		
	$shm_close();   // Closes the waveform database
end

// Stimulate the Input Signals
initial begin
	inp1 = 5;
	inp2 = 10;
	
	#100 $display("At Time: %d   %d*%d with prod=%d  ",$time, inp1, inp2,product);


end
endmodule // carry_select_8_TB


