module patterngen(input wire 	     pixclk,
		  input wire 	     frameclk,
		  input wire 	     reset,

		  output wire [8:0]  addr,
		  output wire [23:0] rgb,

		  output wire 	     write,
		  output reg 	     display);

   reg [8:0] 			     frameaddr;
   reg [12:0] 			     framecount;

   wire [4:0] 			     col;
   wire [3:0] 			     row;

   assign col = frameaddr[4:0];
   assign row = frameaddr[8:5];

   nyan img({row, col - framecount[6:2]}, framecount[12:10], rgb);
   
   always @ (posedge pixclk or posedge reset)
     begin
	if (reset) begin
	   frameaddr <= 0;
	end else begin
	   frameaddr <= frameaddr + 'd1;
	end
     end // always @ (posedge pixclk or posedge reset)

   always @ (posedge frameclk or posedge reset)
     begin
	if (reset) begin
	   framecount <= 0;
	   display <= 0;
	end else begin
	   display <= ~display;
	   framecount <= framecount + 'd1;
	end
     end

   assign addr = frameaddr;
   assign write = pixclk;
endmodule
