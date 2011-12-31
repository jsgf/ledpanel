module nyan(input [8:0]   addr,
	    input [2:0]   img, 
	    output [23:0] rgb);
   reg [23:0] nyan[(8*32*16)-1:0];

   assign rgb = nyan[{img,addr}];

   initial
     begin
	$readmemb("nyan.dat", nyan, 512*0, 512*1-1);
	$readmemb("Test2.dat", nyan, 512*1, 512*2-1);
	$readmemb("Test3.dat", nyan, 512*2, 512*3-1);
	$readmemb("Test4.dat", nyan, 512*3, 512*4-1);
	$readmemb("Test5.dat", nyan, 512*4, 512*5-1);
	$readmemb("Test6.dat", nyan, 512*5, 512*6-1);
	$readmemb("Test7.dat", nyan, 512*6, 512*7-1);
	$readmemb("Test8.dat", nyan, 512*7, 512*8-1);
     end
endmodule // nyan


