all: lut.dat nyan.dat

%.hex: %.rgb
	objcopy -I binary $< -O ihex $@

%.dat: %.rgb Makefile
	perl -e 'binmode(STDIN); while(read(STDIN, $$buf, 3)) { my @rgb = unpack("CCC", $$buf); printf "%08b%08b%08b\n", (reverse @rgb); }' < $< > $@

%.rgb: %.png
	convert $< $@

PWM_WIDTH=9

lut.dat: Makefile
	perl -e '$$bits = $(PWM_WIDTH); for ($$i = 0; $$i < 256; $$i++) {printf "%0".$$bits."b\n", (((1<<$$bits)-1) * (($$i / 255) ** 3));}' > lut.dat
