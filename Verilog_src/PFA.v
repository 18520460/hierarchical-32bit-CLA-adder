module PFA
(
	/*input*/
	input wire c,
	input wire x,
	input wire y,
	/*output*/
	output wire p,
	output wire g,
	output wire s
);
	assign p = x ^ y; 
	assign g = x && y;
	assign s = p ^ c;

endmodule