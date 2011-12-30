module sp_ram #(parameter DATA_WIDTH=8,
		parameter ADDR_WIDTH=8)
   (input [(DATA_WIDTH-1):0]	   data,
    input [(ADDR_WIDTH-1):0] 	 addr,
    input 			 we, clk,
    output reg [(DATA_WIDTH-1):0] q);
   
   reg [DATA_WIDTH-1:0] 	  ram [2**ADDR_WIDTH-1:0];

   always @ (posedge clk)
     begin
	q <= ram[addr];
	if (we)
	  ram[addr] = data;
     end
endmodule
