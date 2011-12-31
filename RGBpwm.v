module RGBpwm(input wire [PWM_WIDTH - 1:0] pwm,
	      input wire [PWM_WIDTH - 1:0] red,
	      input wire [PWM_WIDTH - 1:0] green,
	      input wire [PWM_WIDTH - 1:0] blue,

	      output wire 		   redled,
	      output wire 		   greenled,
	      output wire 		   blueled);

   parameter PWM_WIDTH = 12;
   
   assign redled = red > pwm;
   assign greenled = green > pwm;
   assign blueled = blue > pwm;
   
endmodule
