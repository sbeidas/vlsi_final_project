

module MULT_TB_8;


reg [7:0] inp1,inp2;

wire[15:0] product;


multiply8bits mult8(product,inp1,inp2);
   

initial begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#1000 $finish;		
	$shm_close();   // Closes the waveform database
end

// Stimulate the Input Signals
initial begin
	inp1 = 40;
	inp2 = 150;
	
	#200 $display("At Time: %d   %d*%d with prod=%d  ",$time, inp1, inp2,product);
	
		inp1 = 10;
	inp2 = 150;
	
	#200 $display("At Time: %d   %d*%d with prod=%d  ",$time, inp1, inp2,product);
	
			inp1 = 40;
	inp2 = 150;
	
	#200 $display("At Time: %d   %d*%d with prod=%d  ",$time, inp1, inp2,product);
	
		
	inp1 = 255;
	inp2 = 255;
	
	#200 $display("At Time: %d   %d*%d with prod=%d  ",$time, inp1, inp2,product);
	
	inp1 = 3;
	inp2 = 5;
	
	#200 $display("At Time: %d   %d*%d with prod=%d  ",$time, inp1, inp2,product);




end
endmodule // carry_select_8_TB



