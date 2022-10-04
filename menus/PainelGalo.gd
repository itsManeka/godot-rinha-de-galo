extends Panel

onready var raca = $VBoxContainer/Raca
onready var tamanho = $VBoxContainer/HBoxContainer/Coluna2/Tamanho
onready var forca = $VBoxContainer/HBoxContainer/Coluna2/Forca
onready var velocidade = $VBoxContainer/HBoxContainer/Coluna5/Velocidade
onready var resistencia = $VBoxContainer/HBoxContainer/Coluna5/Resistencia
onready var descricao = $VBoxContainer/Descricao

func preenche(galo : Galo):
	raca.text = galo.get_raca()
	tamanho.text = str(galo.get_tamanho())
	forca.text = str(galo.get_forca())
	velocidade.text = str(galo.get_velocidade_maxima())
	resistencia.text = str(galo.get_resistencia())
	descricao.text = str(galo.get_descricao())
