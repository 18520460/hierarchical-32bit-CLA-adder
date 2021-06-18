module carrylookahead_2bit
(
	/*input*/
	input wire p0,
	input wire p1,
	input wire g0,
	input wire g1,
	input wire c0,
	/*output*/
	output wire G,
	output wire P,
	output wire c1
);
	assign G = (g0 && p1) || g1;
	assign P =  p0 && p1;
	assign c1 = (c0 && p0) || g0; 
endmodule