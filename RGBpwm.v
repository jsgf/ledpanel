module RGBpwm(input wire [PWM_WIDTH - 1:0] pwmlvl,
	      input wire [PWM_WIDTH - 1:0] red,
	      input wire [PWM_WIDTH - 1:0] green,
	      input wire [PWM_WIDTH - 1:0] blue,

	      output wire 		   redled,
	      output wire 		   greenled,
	      output wire 		   blueled);

   parameter PWM_WIDTH = 12;
   //localparam [PWM_WIDTH-1:0] PWM_RANGE = (1<<PWM_WIDTH)-1;
   //localparam [PWM_WIDTH-1:0] HALFRANGE = PWM_RANGE/2;
   
   function pwm;
      input [PWM_WIDTH-1:0] 		   lvl, pix;
      begin
	 //pwm = ((HALFRANGE - (lvl/2)) < pix) && (pix < (HALFRANGE - (lvl/2) + lvl));
	 pwm = pix > lvl;
      end
   endfunction //
   
   assign redled = pwm(pwmlvl, red);
   assign greenled = pwm(pwmlvl, green);
   assign blueled = pwm(pwmlvl, blue);
   
endmodule
