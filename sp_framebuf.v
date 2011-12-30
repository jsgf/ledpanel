module sp_framebuf(input display,

		   // Display
		   input 	     dispclk,
		   input [2:0] 	     row,
		   input [5:0] 	     col,
		   output [7:0]      red, green, blue,

		   // Update
		   input [(3+6)-1:0] addr,
		   input 	     we,
		   input 	     clk,
		   input [23:0]      data,
		   output [23:0]     q);

   wire [(3+6)-1:0] dispaddr, addr0, addr1;
   wire 	    we0, we1;
   wire 	    clk0, clk1;
   wire [23:0] 	    q0, q1;
   
   assign dispaddr = { ~col[5], row, col[4:0] };

   wire 	    update;
   assign update = !display;
   
   sp_ram #(24, 9) ram0(data, addr0, we0, clk0, q0);
   sp_ram #(24, 9) ram1(data, addr1, we1, clk1, q1);
   
   assign addr0 = display ? addr : dispaddr;
   assign addr1 = update  ? addr : dispaddr;

   assign we0 = display & we;
   assign we1 = update  & we;

   assign clk0 = display ? clk : dispclk;
   assign clk1 = update  ? clk : dispclk;

   assign red   = (display ? q1[ 7: 0] : q0[ 7: 0]);
   assign green = (display ? q1[15: 8] : q0[15: 8]);
   assign blue  = (display ? q1[23:16] : q0[23:16]);

   assign q = update ? q1 : q0;
endmodule
