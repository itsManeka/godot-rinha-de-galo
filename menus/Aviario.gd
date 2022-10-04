extends Control

onready var grid_galos = $GridGalos
onready var painel_galo = $PainelGalo
onready var quantidade_racao = $Quantidade

var galo_selecionado : Galo = null

func _ready():
	grid_galos.preenche(Dados.get_galos())
	atualiza_quantidade_racao()

func _on_GridGalos_selecionou(galo):
	galo_selecionado = galo
	painel_galo.preenche(galo)

func _on_TextureButton_button_down():
	get_tree().change_scene("res://menus/MenuIniciar.tscn")
	
func _on_Melhorar_button_down():
	if Dados.get_qtd_racao() > 0:
		Dados.deduz_racao()
		galo_selecionado.aplica_racao()
		atualiza_quantidade_racao()
		painel_galo.preenche(galo_selecionado)

func atualiza_quantidade_racao():
	quantidade_racao.text = "Quantidade: " + str(Dados.get_qtd_racao())
