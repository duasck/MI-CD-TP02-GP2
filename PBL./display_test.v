module display_test(L, M, H, Display, MatrizDisplay);
	input wire L, M, H;
	output reg [6:0] Display, [6:0]MatrizDisplay[3][3];
	
	always @*begin
		case ({L, M, H})
			3'b000: Display = 7'b1110111;
			3'b001: Display = 7'b1110110;
			3'b010: Display = 7'b0110110;
			default: Display = 7'b1111111;
		endcase
	end

endmodule 