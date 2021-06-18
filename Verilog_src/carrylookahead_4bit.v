module carrylookahead_4bit
(
	/*port declare*/
	/*input*/
	input wire c0,
	input wire p0,
	input wire p1,
	input wire p2,
	input wire p3,
	input wire g0,
	input wire g1,
	input wire g2,
	input wire g3,
	/*output*/
	output wire c1,
	output wire c2,
	output wire c3,
	output wire G,
	output wire P
);
	assign c1 = (c0 && p0) || g0;
	assign c2 = (c0 && p0 && p1) || (g0 && p1) || g1;
	assign c3 = (c0 && p0 && p1 && p2) || (g0 && p1 && p2) || (g1 && p2) || g2;
	assign P =   p0 && p1 && p2 && p3;
	assign G = (g0 && p1 && p2 && p3) || (g1 && p2 && p3) || (g2 && p3) || g3;
endmodule
