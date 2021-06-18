module CLA_16bit
(
	/*input*/
	input wire [15:0] x,
	input wire [15:0] y,
	input wire carry_in,
	/*output*/
	output wire [15:0] s,
	output wire G,
	output wire P
);
	genvar i;
	wire carry_bus[0:15];
	wire lv_1_g_bus[0:15];
	wire lv_1_p_bus[0:15];
	wire lv_2_g_bus[0:3];
	wire lv_2_p_bus[0:3];
	generate
		for(i = 0 ; i <= 15; i = i + 1) begin : add_com_gen
			PFA my_PFA(
				.c(carry_bus[i]),
				.x(x[i]), 
				.y(y[i]), 
				.p(lv_1_p_bus[i]), 
				.g(lv_1_g_bus[i]), 
				.s(s[i])
			);
		end
		for(i = 0; i <= 3; i = i + 1) begin : carry_gen_lv1
			carrylookahead_4bit my_carry( 
				.c0(carry_bus[i * 4]), 
				.p0(lv_1_p_bus[i * 4]), 
				.p1(lv_1_p_bus[i * 4 + 1]), 
				.p2(lv_1_p_bus[i * 4 + 2]), 
				.p3(lv_1_p_bus[i * 4 + 3]), 
				.g0(lv_1_g_bus[i * 4]), 
				.g1(lv_1_g_bus[i * 4 + 1]), 
				.g2(lv_1_g_bus[i * 4 + 2]), 
				.g3(lv_1_g_bus[i * 4 + 3]), 
				.c1(carry_bus[i * 4 + 1]), 
				.c2(carry_bus[i * 4 + 2]), 
				.c3(carry_bus[i * 4 + 3]), 
				.G(lv_2_g_bus[i]),  
				.P(lv_2_p_bus[i]) 
			);
		end
	endgenerate
	//lv2 carry generate
	carrylookahead_4bit my_lv2_carry( 
		.c0(carry_in), 
		.p0(lv_2_p_bus[0]), 
		.p1(lv_2_p_bus[1]), 
		.p2(lv_2_p_bus[2]), 
		.p3(lv_2_p_bus[3]), 
		.g0(lv_2_g_bus[0]), 
		.g1(lv_2_g_bus[1]), 
		.g2(lv_2_g_bus[2]), 
		.g3(lv_2_g_bus[3]), 
		.c1(carry_bus[4]), 
		.c2(carry_bus[8]), 
		.c3(carry_bus[12]), 
		.G(G),  
		.P(P) 
	);
	assign carry_bus[0] = carry_in;
endmodule

