module CLA_32bit
(
	/*input*/
	input wire [31:0] x,
	input wire [31:0] y,
	input wire carry_in,
	/*output*/
	output wire [31:0] s,
	output wire carry_out
);
	wire G[0:1];
	wire P[0:1];
	wire LV1_G;
	wire LV1_P;
	wire carry;
	CLA_16bit LOW(  
		.x(x[15:0]),  
		.y(y[15:0]),  
		.carry_in(carry_in), 
		.s(s[15:0]), 
		.G(G[0]), 
		.P(P[0])
	);
	CLA_16bit HIGH( 
		.x(x[31:16]), 
		.y(y[31:16]), 
		.carry_in(carry), 
		.s(s[31:16]), 
		.G(G[1]), 
		.P(P[1])
	);
	carrylookahead_2bit name(
		.p0(P[0]),
		.p1(P[1]),
		.g0(G[0]),
		.g1(G[1]),
		.c0(carry_in),
		.G(LV1_G),
		.P(LV1_P),
		.c1(carry)
	);
	assign carry_out = (carry_in && LV1_P) || LV1_G;
endmodule