module parabrisa

----------------------------------------------------------------------------------------
-- PROJETO ALLOY :  SISTEMA PARA LIMPEZA DO PARA-BRISA
-- GRUPO: 21

-- DIEGO AMANCIO
-- WESLEY LUCENA
-- KLEBERSON CANUTO
-- IONESIO JUNIOR

-- CLIENTE : KYLLER GORGONIO
-- PROFESSORES : KYLLER GORGONIO / THIAGO MASSONI
----------------------------------------------------------------------------------------

-- ASSINATURAS
sig Parabrisa {
	velAtual: one Velocidade,
	velAnterior: one Velocidade,
	velPosterior: one Velocidade,
	bicosEjetores: one Estado
}

abstract sig Velocidade {}
one sig Zero extends Velocidade {}
one sig Baixa extends Velocidade {}
one sig Alta extends Velocidade {} 

abstract sig Estado {}
one sig Ligado extends Estado {}
one sig Desligado extends Estado {}

-- FATOS
fact ParabrisaFatos{
   all p:Parabrisa | validarPredicados[p]
}

-- VALIDA TODOS OS PREDICADOS
pred validarPredicados[p:Parabrisa]{
	( p.bicosEjetores = Ligado ) => ejetorLigado[p] else ejetorDesligado[p]
}

-- EJETOR DE AGUA LIGADO
pred ejetorLigado[p:Parabrisa]{
	( p.velAnterior = Zero ) => ( p.velAtual = Baixa and p.velPosterior = Zero ) else ( p.velAtual = p.velAnterior )
}

-- EJETOR DE AGUA DESLIGADO
pred ejetorDesligado[p:Parabrisa]{
	possibilidadesVelAnterior[p] and possibilidadesVelAtual[p] and possibilidadesVelPosterior[p]
}

pred possibilidadesVelAnterior[p:Parabrisa]{
	( p.velAnterior = Zero or p.velAnterior = Baixa or p.velAnterior = Alta )
}

pred possibilidadesVelAtual[p:Parabrisa]{
	( p.velAtual = Zero or p.velAtual = Baixa or p.velAtual = Alta )
}

pred possibilidadesVelPosterior[p:Parabrisa]{
	( p.velPosterior = Zero or p.velPosterior = Baixa or p.velPosterior = Alta )
}

-- TESTES
assert checkEjetorLigadoPaletaDesligada {
	all p:Parabrisa | (p.bicosEjetores = Ligado and p.velAnterior = Zero ) =>  (p.velAtual = Baixa and p.velPosterior = Zero )
}

assert checkEjetorLigadoPaletaLigada {
	all p:Parabrisa | (p.bicosEjetores = Ligado and p.velAnterior != Zero) => ( p.velAtual = p.velAnterior )
}


check checkEjetorLigadoPaletaDesligada for 1000
check checkEjetorLigadoPaletaLigada for 1000

pred show {}
run show for 50
