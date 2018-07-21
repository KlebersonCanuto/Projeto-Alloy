module parabrisa

sig Parabrisa {
	vel: one Velocidade
	ejetor: one Estado
}

abstract sig Velocidade {}
sig Zero extends Velocidade {}
sig Baixa extends Velocidade {}
sig Alta extends Velocidade {} 

abstract sig Estado {}
sig Ativado extends Estado {}
sig Desativado extends Estado {}

