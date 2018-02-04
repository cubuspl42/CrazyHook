label0 = 0x40ABCD;

SECTIONS
{
	. = 0x402061;
	.foo ALIGN(1): { foo.obj }
	. = 0x40F7FA;
	.bar ALIGN(1) : { bar.obj }
}
