extends Control

onready var titulo = $Titulo
onready var valor = $GanhosValor
onready var ganhos_label = $Ganhos

func _ready():
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.RINHA:
		var valor_aposta
		
		match Global.get_resultado_luta():
			Global.resultado.EMPATE:
				titulo.text = "Empate!"
				valor_aposta = Global.get_valor_aposta() * 0.1
				
			Global.resultado.GANHOU:
				titulo.text = "Vitória!"
				valor_aposta = Global.get_valor_aposta() * 0.25
				
			Global.resultado.PERDEU:
				titulo.text = "Derrota!"
				valor_aposta = 0
		
		valor.text = ("%.2f" % valor_aposta)
		Dados.soma_dinheiro(valor_aposta)
	else:
		if Global.get_resultado_luta() == Global.resultado.REI_DOS_GALOS:
			titulo.text = "Você venceu os campeões e agora é o Rei dos Galos!"
			valor.text = ("%.2f" % 5000.00)
			Dados.soma_dinheiro(5000.00)
		else:
			valor.visible = false
			ganhos_label.visible = false
			titulo.text = "Derrota! Volte quando estiver mais forte."

func _on_VoltarMenu_button_down():
	get_tree().change_scene("res://menus/MenuIniciar.tscn")
