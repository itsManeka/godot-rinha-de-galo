extends Node2D

class_name Galo

export(Texture) var sprite
export var tamanho = 1.0
export var velocidade_maxima = 80
export var forca = 100
export var resistencia = 20
export(String) var raca = ""
export(String, MULTILINE) var descricao = ""
export(bool) var especial = false

func get_sprite() -> Texture:
	return sprite

func get_tamanho():
	return tamanho

func get_velocidade_maxima() -> int:
	return velocidade_maxima

func get_forca() -> int:
	return forca

func get_resistencia() -> int:
	return resistencia

func get_raca():
	return raca

func get_descricao():
	return descricao

func is_especial():
	return especial

func aplica_racao():
	velocidade_maxima += int(velocidade_maxima * 0.1)
	forca += int(forca * 0.1)
	resistencia += int(resistencia * 0.1)
