extends Control

var aposta_galo : float = 0.00
var aposta_adv : float = 0.00

onready var label_aposta_galo = $Panel/ApostaSeuGalo
onready var label_aposta_adv = $Panel/ApostaGaloAdv

func _ready():
	aposta_galo = 20.00
	aposta_adv = 20.00
	
	atualiza_texto_aposta()

func adiciona_aposta_galo(valor):
	aposta_galo += valor
	atualiza_texto_aposta()
	
func adiciona_aposta_adv(valor):
	aposta_adv += valor
	atualiza_texto_aposta()

func atualiza_texto_aposta():
	label_aposta_galo.text = ("%.2f" % aposta_galo)
	label_aposta_adv.text = ("%.2f" % aposta_adv)

func get_total_aposta():
	return aposta_galo + aposta_adv
