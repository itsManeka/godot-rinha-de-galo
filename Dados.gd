extends Node

var dinheiro = 160.00
var galos = []
var qtd_racao_especial = 0

func _ready():
	galos.append(GaloManager.get_galo_por_raca("Rhode Island Red"))

func adiciona_galo(galo : Galo):
	galos.append(galo)

func deduz_dinheiro(valor):
	dinheiro -= valor

func soma_dinheiro(valor):
	dinheiro += valor

func get_dinheiro():
	return dinheiro

func get_galos():
	return galos

func get_qtd_racao():
	return qtd_racao_especial

func add_racao():
	qtd_racao_especial += 1

func deduz_racao():
	qtd_racao_especial -= 1
