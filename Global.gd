extends Node

enum resultado {
	GANHOU,
	PERDEU,
	EMPATE,
	REI_DOS_GALOS
}

enum tipo_luta {
	RINHA,
	REI_DOS_GALOS
}

var resultado_luta
var valor_aposta : float = 0.00
var galo_selecionado : Galo = null
var galo_inimigo: Galo = null
var tipo_luta_iniciado
var campeao = -1

func _ready():
	randomize()

func set_dados_luta(resultado, aposta: float):
	resultado_luta = resultado
	valor_aposta = aposta

func get_resultado_luta():
	return resultado_luta
	
func get_valor_aposta():
	return valor_aposta
	
func set_galo_selecionado(galo : Galo):
	galo_selecionado = galo

func get_galo_selecionado() -> Galo:
	return galo_selecionado
	
func set_galo_inimigo(galo : Galo):
	galo_inimigo = galo
	
func get_galo_inimigo() -> Galo:
	return galo_inimigo

func set_tipo_luta_iniciado(tipo):
	tipo_luta_iniciado = tipo
	
func get_tipo_luta_iniciado():
	return tipo_luta_iniciado

func reseta_campeao():
	campeao = -1

func proximo_campeao():
	campeao += 1

func get_campeao():
	return campeao

func get_nome_campeao():
	match campeao:
		0:
			return "Wendel"
		1:
			return "Viniboy"
		2:
			return "Wilk"
		3:
			return "Maneka"
		4:
			return "Laerte"

func get_galo_campeao() -> Galo:
	match campeao:
		0:
			return GaloManager.get_galo_por_raca("Galo 16 Bits")
		1:
			return GaloManager.get_galo_por_raca("e-Galo")
		2:
			return GaloManager.get_galo_por_raca("Galo-sem-cabeça")
		3:
			return GaloManager.get_galo_por_raca("HellGalo")
		4:
			return GaloManager.get_galo_por_raca("Galo 3D")
	return null
