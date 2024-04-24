module circuito(Us, Ua, H, T, M, L, Vs, Bs, Al, Erro, Ve, Dig1, Dig2, Dig3, SegA, SegB, SegC, SegD, SegE, SegF, SegG, Ponto);

input Us, Ua, T, H, M, L;
output Vs, Bs, Al,Erro, Ve, Dig1, Dig2, Dig3, SegA, SegB, SegC, SegD, SegE, SegF, SegG, Ponto;

/*
    Vs (Gotejamento)= Ua ~Us ~Erro ~Medio Baixo ~Vazio + Ua ~Us T ~Erro ~Vazio
    Bs (Aspercao)= ~Erro ~Vazio ~Us ~Ua + ~Us Ua ~T Medio ~Baixo ~Vazio ~Erro
    Al (Alarme)= ~M + ~L
    Cheio = H M L
    Medio = ~H M L
    Baixo = ~H ~M L
    Critico = ~H ~M ~L
    Erro = M ~L + H ~M
    Ve (Vavula entrada)= ~H ~M + ~H L
*/

//=================DEFINICOES===========
wire Hinv, Minv, Linv, Erroinv, Uainv, Usinv, Vazioinv, Baixoinv, Medioinv, Cheioinv, Tinv;
not N1(Hinv, H);
not N2(Minv, M);
not N3(Linv, L);
not N4(Erroinv, Erro);
not N5(Uainv, Ua);
not N6(Usinv, Us);
not N7(Vazioinv, Vazio);
not N8(Tinv, T);
not N9(Baixoinv, Baixo);
not N10(Medioinv, Medio);
not N11(Cheioinv, Cheio);

// Vazio = ~H ~M ~L
wire vazio, medio, baixo;
and V1 (Vazio, Hinv, Minv, Linv);

// Baixo = ~H ~M L
and B1 (Baixo, Hinv, Minv, L);

// Medio = ~H M L
and M1 (Medio, Hinv, M, L);

// Cheio = H M L
and C1 (Cheio, H, M, L);

// Erro = M ~L + H ~M
wire ErA, ErB;
and E2 (ErA, M, Linv);
and E3 (ErB, H, Minv);
or E4 (Erro, ErA, ErB);

//Valvula de entrada
//Ve = ~H * ~M + ~H * L
wire VeA, VeB;
or H3 (VeA, H, Erro);
not H4 (Ve, VeA);

//Al = ~M + ~L + Erro
or A1(Al, Minv, Linv, Erro);


// Vs (Gotejamento) = Ua ~Us ~Erro ~Medio Baixo ~Vazio + Ua ~Us T ~Erro ~Vazio
wire VsA, VsB;
and VS1 (VsA, Ua, Usinv, Erroinv, Minv, Baixo, Vazioinv);
and VS2 (VsB, Ua, Usinv, T, Erroinv, Vazioinv);
or VS3 (Vs, VsA, VsB);

//Bs (Aspercao)= ~Erro ~Vazio ~Us ~Ua + ~Us Ua ~T Medio ~Baixo ~Vazio ~Er
wire BsA, BsB;
and BS1 (BsA, Erroinv, Vazioinv, Usinv, Uainv);
and BS2 (BsB, Usinv, Ua, Tinv, Medio, Baixoinv, Vazioinv, Erroinv);
or BS3 (Bs, BsA, BsB);

//========================
not (Dig1, 0);
not (Dig2, 0);
not (Dig3, 0);
not (SegB, 0);
not (SegC, 0);
not (SegE, 0);
not (SegF, 0);
not (Ponto, 0);

wire LedD, LedG, LedA;

// Minimo
and (LedD, L, Erroinv);
not (SegD, LedD);

// Medio
and (LedG, L, M, Erroinv);
not (SegG, LedG);

// Alto
and (LedA, L, M, H, Erroinv);
not (SegA, LedA);
//========================

endmodule
