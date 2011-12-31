/*
 * Panel Signals
 * 
 * CLK	- clock next bit into shift registers
 * LAT	- latch shift registers to output
 * OE/  - Output Enable.  Question: OE for current line, or whole display?
 * RGB01- 6 bits of RGB per logical scanline (two physical scanlines in parallel, at n and n+8)
 * ABC  - scanline selector, 3 bits
 * 
 * Overall panel timing
 *
 * The panel has 8 logical scanlines, scanned out in pairs to form 16 physical scanlines.
 * 
 * This design relies on the output of the first line being fed into the input of the
 * second, so that two scanlines can be clocked out in 64 cycles.  In effect, this means
 * we have 8x64 pixel scanlines which are split over two physical lines.
 *
 * Therefore, for line N, we clock out N+8 pixels from right to left, then scanline N
 * from right to left.
 */
module timing(input wire	 clk_in,
	      input wire 		  reset,

	      output wire [2:0] 	  line, 
	      output wire [5:0] 	  col,
	      output wire 		  lat, 
	      output wire [PWM_WIDTH-1:0] pwm, 
	      output wire 		  frame_clk);

   parameter PWM_WIDTH = 12;
   localparam COUNTER = PWM_WIDTH + 9;
   
   reg [COUNTER-1:0] 		  counter = 0;
   
   always @ (posedge clk_in or posedge reset)
     begin
	if (reset) begin
	   counter <= 0;
	end else begin
	   counter <= counter + 'd1;
	end
     end
   
   assign col = counter[5:0];
   assign line = counter[8:6];
   assign pwm = counter[COUNTER-1:9];

   // Frame done at the end of a full pwm cycle
   assign frame_clk = (counter == 0);

   // Latch when scanline finishes
   assign lat = (col == 0);
endmodule
