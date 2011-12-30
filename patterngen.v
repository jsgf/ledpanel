module patterngen(input wire 	     pixclk,
		  input wire 	     frameclk,
		  input wire 	     reset,

		  output wire [8:0]  addr,
		  output wire [23:0] rgb,

		  output wire 	     write,
		  output reg 	     display);

   reg [8:0] 			     frameaddr;
   reg [6:0] 			     framecount;

   wire [4:0] 			     col;
   wire [3:0] 			     row;

   assign col = frameaddr[4:0];
   assign row = frameaddr[8:5];
   
   nyan n({row, col - framecount[6:2]}, rgb);
   
   always @ (posedge pixclk or posedge reset)
     begin
	if (reset) begin
	   frameaddr = 0;
	end else begin
	   frameaddr = frameaddr + 1;
	end
     end // always @ (posedge pixclk or posedge reset)

   always @ (posedge frameclk or posedge reset)
     begin
	if (reset) begin
	   framecount = 0;
	   display = 0;
	end else begin
	   display <= ~display;
	   framecount <= framecount + 1;
	end
     end

   assign addr = {row, col};
   assign write = pixclk;
endmodule
