module rgblut(input [7:0] 	     r, g, b,
	      output [PWM_WIDTH-1:0] rl, gl, bl);

   parameter PWM_WIDTH = 12;
   
   reg [PWM_WIDTH-1:0] 	    lutrom[255:0];

   assign rl = lutrom[r];
   assign gl = lutrom[g];
   assign bl = lutrom[b];

   initial
     $readmemb("lut.dat", lutrom);
   
endmodule // rgblut

