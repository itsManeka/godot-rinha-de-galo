extends Control

export var valor_galo_normal = 200.00
export var valor_galo_especial = 500.00
export var valor_racao = 100.00

onready var seu_dinheiro = $SeuDinheiro
onready var mensagem = $ItemList/VBoxContainer/HBoxContainer5/Mensagem
onready var linha_cheat = $CheatCodes
onready var botao_cheat = $Cheat

onready var preco_galo_normal_texto = $ItemList/VBoxContainer/HBoxContainer/Preco
onready var preco_galo_especial_texto = $ItemList/VBoxContainer/HBoxContainer2/Preco
onready var preco_racao_texto = $ItemList/VBoxContainer/HBoxContainer3/Preco

func _ready():
	preco_galo_normal_texto.text = "R$ " + ("%.2f" % valor_galo_normal)
	preco_galo_especial_texto.text = "R$ " + ("%.2f" % valor_galo_especial)
	preco_racao_texto.text = "R$ " + ("%.2f" % valor_racao)
	
	atualiza_seu_dinheiro()
	atualiza_mensagem("")

func _on_Voltar_button_down():
	get_tree().change_scene("res://menus/MenuIniciar.tscn")

func _on_Galo_button_down():
	if Dados.get_dinheiro() >= valor_galo_normal:
		Dados.deduz_dinheiro(valor_galo_normal)
		var galo : Galo = GaloManager.get_galo_aleatorio_normal()
		Dados.adiciona_galo(galo)
		atualiza_seu_dinheiro()
		atualiza_mensagem("Comprou um " + galo.get_raca() + ".")
	else:
		atualiza_mensagem("Dinheiro insuficiente.")

func _on_GaloEsp_button_down():
	if Dados.get_dinheiro() >= valor_galo_especial:
		Dados.deduz_dinheiro(valor_galo_especial)
		var galo : Galo = GaloManager.get_galo_aleatorio_especial()
		Dados.adiciona_galo(galo)
		atualiza_seu_dinheiro()
		atualiza_mensagem("Comprou um " + galo.get_raca() + ".")
	else:
		atualiza_mensagem("Dinheiro insuficiente.")

func _on_Racao_button_down():
	if Dados.get_dinheiro() >= valor_racao:
		Dados.deduz_dinheiro(valor_racao)
		Dados.add_racao()
		atualiza_seu_dinheiro()
		atualiza_mensagem("Comprou ração epecial.")
	else:
		atualiza_mensagem("Dinheiro insuficiente.")

func atualiza_seu_dinheiro():
	seu_dinheiro.text = ("%.2f" % Dados.get_dinheiro())

func atualiza_mensagem(texto):
	mensagem.text = texto

func _on_Cheat_button_down():
	match linha_cheat.text.to_lower():
		"macacoagiota":
			Dados.soma_dinheiro(500.00)
			atualiza_mensagem("Adicionou R$ 500.00.")
		"anungunrama":
			Dados.adiciona_galo(GaloManager.get_galo_por_raca("HellGalo"))
			atualiza_mensagem("Comprou um HellGalo.")
		"packdogalinho":
			Dados.adiciona_galo(GaloManager.get_galo_por_raca("e-Galo"))
			atualiza_mensagem("Comprou um e-Galo.")
		"cuidadocomacuca":
			Dados.adiciona_galo(GaloManager.get_galo_por_raca("Galo-sem-cabeça"))
			atualiza_mensagem("Comprou um Galo-sem-cabeça.")
		"ourobouros":
			Dados.adiciona_galo(GaloManager.get_galo_por_raca("Galo 16 Bits"))
			atualiza_mensagem("Comprou um Galo 16 Bits.")
		"etreal":
			Dados.adiciona_galo(GaloManager.get_galo_por_raca("Galo 3D"))
			atualiza_mensagem("Comprou um Galo 3D.")
		"birl!":
			Dados.add_racao()
			atualiza_mensagem("Comprou ração epecial.")
		_:
			atualiza_mensagem("Código inválido.")
			
	atualiza_seu_dinheiro()
