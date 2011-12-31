module patterngen(input wire 	     pixclk,
		  input wire 	     frameclk,
		  input wire 	     reset,
		  input wire 	     switchimg,

		  output wire [8:0]  addr,
		  output wire [23:0] rgb,

		  output wire 	     write,
		  output reg 	     display);

   reg [8:0] 			     frameaddr;
   reg [6:0] 			     framecount;
   reg [2:0] 			     img;

   wire [4:0] 			     col;
   wire [3:0] 			     row;

   assign col = frameaddr[4:0];
   assign row = frameaddr[8:5];

   nyan imgrom({row, col - framecount[6:2]}, img, rgb);

   always @ (posedge switchimg or posedge reset)
     if (reset)
       img <= 0;
     else
       img <= img + 1'd1;
   
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
