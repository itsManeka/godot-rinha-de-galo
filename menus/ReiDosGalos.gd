extends Control

onready var painel_galo = $PainelGalo
onready var sprite_personagem = $Personagem
onready var sprite_galo = $Galo
onready var nome = $Nome

var galo_inimigo : Galo = null
var campeao = -1

func _ready():
	Global.proximo_campeao()
	
	campeao = Global.get_campeao()
	galo_inimigo = Global.get_galo_campeao()
	Global.set_galo_inimigo(galo_inimigo)
	sprite_personagem.frame = campeao
	sprite_galo.texture = galo_inimigo.get_sprite()
	painel_galo.preenche(galo_inimigo)
	nome.text = Global.get_nome_campeao()

func _on_Lutar_button_down():
	get_tree().change_scene("res://Ringue.tscn")
