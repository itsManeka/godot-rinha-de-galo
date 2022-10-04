extends Control

onready var grid_galos = $GridGalos
onready var painel_galo = $PainelGalo
onready var dinheiro = $Dinheiro
onready var label_dinheiro = $DinheiroLabel
onready var botao_batalhar = $Batalhar

var galo_selecionado : Galo = null

func _ready():
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.REI_DOS_GALOS:
		label_dinheiro.visible = false
		dinheiro.visible = false
	
	dinheiro.text = ("%.2f" % Dados.get_dinheiro())
	grid_galos.preenche(Dados.get_galos())
	
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.RINHA:
		if Dados.get_dinheiro() < 20.00:
			botao_batalhar.disabled = true

func _on_GridGalos_selecionou(galo):
	galo_selecionado = galo
	painel_galo.preenche(galo)

func _on_Batalhar_button_down():
	Global.set_galo_selecionado(galo_selecionado)
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.RINHA:
		Dados.deduz_dinheiro(20.00)
		get_tree().change_scene("res://Ringue.tscn")
	else:
		get_tree().change_scene("res://menus/ReiDosGalos.tscn")

func _on_Voltar_button_down():
	get_tree().change_scene("res://menus/MenuIniciar.tscn")
