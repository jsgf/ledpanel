module RGBpwm(input wire [PWM_WIDTH - 1:0] pwm,
	      input wire [PWM_WIDTH - 1:0] red,
	      input wire [PWM_WIDTH - 1:0] green,
	      input wire [PWM_WIDTH - 1:0] blue,

	      output wire 		   redled,
	      output wire 		   greenled,
	      output wire 		   blueled);

   parameter PWM_WIDTH = 8;
   
   function do_pwm;
      input [PWM_WIDTH - 1:0]  pwm, pix;
      begin
	 do_pwm = pix > pwm;
      end
   endfunction
   
   assign redled = do_pwm(pwm, red);
   assign greenled = do_pwm(pwm, green);
   assign blueled = do_pwm(pwm, blue);
   
endmodule
