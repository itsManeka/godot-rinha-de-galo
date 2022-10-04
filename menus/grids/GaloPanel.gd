extends Panel

signal selecionou(galo)

onready var sprite = $Sprite
onready var label_nome = $Nome
onready var selecionado = $Seleciona

var galo : Galo = null
var setou_dados = false

func _ready():
	selecionado.visible = false

func set_dados(galo_ : Galo):
	galo = galo_

func _process(_delta):
	if !setou_dados:
		if galo:
			setou_dados = true
			sprite.texture = galo.get_sprite()
			label_nome.text = galo.get_raca()

func get_galo():
	return galo

func _on_TouchScreenButton_pressed():
	seleciona()

func seleciona():
	set_selecionado(true)
	
	emit_signal("selecionou", galo)

func set_selecionado(b):
	selecionado.visible = b
