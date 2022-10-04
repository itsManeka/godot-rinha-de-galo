extends Control

onready var dinheiro = $Dinheiro
onready var descricao = $Descricao
onready var informacao = $Infos

func _ready():
	informacao.visible = false
	dinheiro.text = ("%.2f" % Dados.get_dinheiro())

func _on_Rinha_button_down():
	Global.set_tipo_luta_iniciado(Global.tipo_luta.RINHA)
	get_tree().change_scene("res://menus/SelecionarGalo.tscn")

func _on_Aviario_button_down():
	get_tree().change_scene("res://menus/Aviario.tscn")

func _on_Comprar_button_down():
	get_tree().change_scene("res://menus/Loja.tscn")

func _on_Mestre_button_down():
	Global.set_tipo_luta_iniciado(Global.tipo_luta.REI_DOS_GALOS)
	Global.reseta_campeao()
	get_tree().change_scene("res://menus/SelecionarGalo.tscn")

func _on_Aviario_mouse_entered():
	descricao.text = "Visualize e gerêncie seus galos."

func _on_Comprar_mouse_entered():
	descricao.text = "Compre galos novos ou ração para aumentar o poder de seus galos."

func _on_Rinha_mouse_entered():
	descricao.text = "Aposte R$20.00 e lute uma rinha com um galo aleatório. Ganhe 25% das apostas se vencer e 10% se terminar em empate."

func _on_Mestre_mouse_entered():
	descricao.text = "Derrote os 5 campeões e seus galos especiais e seja o Rei dos Galos."

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(meta)
	
func _on_Fechar_button_down():
	informacao.visible = false

func _on_Sobre_button_down():
	informacao.visible = true
