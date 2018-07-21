module parabrisa

sig Parabrisa {
	vel: Velocidade
}

abstract sig Velocidade {}
sig Desligado extends Velocidade {}
sig Baixa extends Velocidade {}
sig Alta extends Velocidade {} 

sig Ejetor {
	estadoAtual: Estado
}

abstract sig Estado {}
sig Ativado extends Estado {}
sig Desativado extends Estado {}
