module nyan(input [8:0]   addr,
	    output [23:0] rgb);
   reg [23:0] nyan[(32*16)-1:0];

   assign rgb = nyan[addr];

   initial
     $readmemb("nyan.dat", nyan);
   
endmodule // nyan


