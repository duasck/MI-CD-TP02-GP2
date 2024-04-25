module ErroCaixa(
	input Low, Mid, High,
	output ErroMedida
);
	
	wire Low_inv, Mid_inv, High_inv, NotAB, NotBC;
	
	// Inversao:
	not UI1(Low_inv, Low);
	not UI2(Mid_inv, Mid);
	
	// Portas AND:
	and UI3(NotAB, Low_inv, Mid);
	and UI4(NotBC, Mid_inv, High);
	
	or UI5(ErroMedida, NotBC, NotAB);
	
endmodule