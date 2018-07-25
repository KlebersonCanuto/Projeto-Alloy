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
	velAtual: Velocidade,
	velAnterior: Velocidade,
	velPosterior: Velocidade,
	bicosEjetores: Estado
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
	( p.velAnterior = Zero ) => ( p.velAtual = Baixa and p.velPosterior = Zero ) else ( p.velAtual = p.velAnterior and p.velPosterior = p.velAnterior)
}

-- EJETOR DE AGUA DESLIGADO
pred ejetorDesligado[p:Parabrisa]{
	( p.velAtual = Zero or p.velAtual = Baixa or p.velAtual = Alta ) and p.velAnterior = p.velAtual and p.velPosterior = p.velAtual
}

-- TESTES
assert checkEjetorLigadoPaletaDesligada {
	all p:Parabrisa | (p.bicosEjetores = Ligado and p.velAnterior = Zero ) =>  (p.velAtual = Baixa and p.velPosterior = Zero )
}

assert checkEjetorLigadoPaletaLigada {
	all p:Parabrisa | (p.bicosEjetores = Ligado and p.velAnterior != Zero) => ( p.velAtual = p.velAnterior and p.velPosterior = p.velAnterior)
}

assert checkEjetorDesligado {
	all p:Parabrisa | (p.bicosEjetores = Desligado) => ( p.velAtual = p.velAnterior and p.velPosterior = p.velAnterior)
}

pred show []{}
run show for 50
check checkEjetorLigadoPaletaDesligada for 100
check checkEjetorLigadoPaletaLigada for 100
check checkEjetorDesligado for 100
