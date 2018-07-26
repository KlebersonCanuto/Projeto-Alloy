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
abstract one sig Parabrisa {}

sig ParabrisaDesligado extends Parabrisa{
	bicosEjetores: Desligado,
	vel: one Velocidade
}

sig ParabrisaLigado extends Parabrisa{
	velAtual: Velocidade,
	velAnterior: Velocidade,
	velPosterior: Velocidade,
	bicosEjetores: Ligado
}

abstract sig Velocidade {}
one sig Zero extends Velocidade {}
one sig Baixa extends Velocidade {}
one sig Alta extends Velocidade {} 

abstract one sig Estado {}
sig Ligado extends Estado {}
sig Desligado extends Estado {}

-- FATOS
fact ParabrisaDesligadoFatos{
   all p:ParabrisaDesligado | validarPredicadosDesligado[p]
}

fact ParabrisaLigadoFatos{
   all p:ParabrisaLigado | validarPredicadosLigado[p]
}

-- VALIDA TODOS OS PREDICADOS
pred validarPredicadosDesligado[p:ParabrisaDesligado]{
	ejetorDesligado[p]
}

pred validarPredicadosLigado[p:ParabrisaLigado]{
	ejetorLigado[p]
}


-- EJETOR DE AGUA LIGADO
pred ejetorDesligado[p:ParabrisaDesligado]{
	p.vel = Zero or p.vel = Baixa or p.vel = Alta
}

pred ejetorLigado[p:ParabrisaLigado]{
	( p.velAnterior = Zero ) => ( p.velAtual = Baixa and p.velPosterior = Zero ) else ( p.velAtual = p.velAnterior and p.velPosterior = p.velAnterior)
}

-- TESTES
assert checkEjetorLigadoPaletaDesligada {
	all p:ParabrisaLigado | (p.bicosEjetores = Ligado and p.velAnterior = Zero ) =>  (p.velAtual = Baixa and p.velPosterior = Zero )
}

assert checkEjetorLigadoPaletaLigada {
	all p:ParabrisaLigado | (p.bicosEjetores = Ligado and p.velAnterior != Zero) => ( p.velAtual = p.velAnterior and p.velPosterior = p.velAnterior)
}

assert checkEjetorDesligado {
	all p:ParabrisaDesligado | (p.bicosEjetores = Desligado)
}

pred show []{}
--check checkEjetorLigadoPaletaDesligada for 6
--check checkEjetorLigadoPaletaLigada for 6
--check checkEjetorDesligado for 6
run show for 6
