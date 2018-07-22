module parabrisa

sig Parabrisa {
	vel: one Velocidade,
	ejetor: one Estado
	
}
abstract sig Bool{}
one sig True extends Bool{}
one sig False extends Bool{}

abstract sig Velocidade {}

sig Zero extends Velocidade {}
sig Baixa extends Velocidade {}
sig Alta extends Velocidade {} 
fact{
	#Zero = 0 and #Baixa = 1 and #Alta = 2 and #Ativado = #True and #Desativado = #False
	
}
abstract sig Estado {}

sig Ativado extends Estado {}
sig Desativado extends Estado {}

pred show[]{}
run show for 5
