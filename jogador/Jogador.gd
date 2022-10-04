extends KinematicBody2D

class_name Jogador

var dados_galo : Galo = null

var ACELERACAO = 500
var VELOCIDADE_MAXIMA = 80
var FRICCAO = 500

var resistencia = 0
var forca = 0
var velocidade = Vector2.ZERO

var terminou : bool = false

onready var sprite = $Sprite
onready var animacao = $AnimationPlayer

signal recebeu_ataque

enum {
	MOVIMENTO,
	ATAQUE,
	ATACADO
}

var estado = MOVIMENTO
var entrou_area_inimigo = false

var ringue = null
var inimigo = null

func _ready():
	dados_galo = Global.get_galo_selecionado()
	sprite.texture = dados_galo.get_sprite()
	scale.x = dados_galo.get_tamanho()
	scale.y = dados_galo.get_tamanho()
	VELOCIDADE_MAXIMA = dados_galo.get_velocidade_maxima()
	forca = dados_galo.get_forca()
	resistencia = dados_galo.get_resistencia()
	
func inicia(_ringue: Ringue):
	ringue = _ringue
	inimigo = ringue.get_inimigo()

func get_forca() -> int:
	return forca

func _physics_process(delta):
	if terminou:
		return
		
	if inimigo:
		look_at(inimigo.global_position)
	
	match estado:
		MOVIMENTO:
			movimento(delta)
			
		ATAQUE:
			ataque()
		
		ATACADO:
			atacado(delta)

func atacado(delta):
	velocidade = velocidade.move_toward(Vector2.ZERO, 200 * delta)
	velocidade = move_and_slide(velocidade)
	
	if velocidade == Vector2.ZERO:
		estado = MOVIMENTO

func movimento(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_vector.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animacao.play("andando")
		velocidade = velocidade.move_toward(input_vector * VELOCIDADE_MAXIMA, ACELERACAO * delta)
	else:
		animacao.play("parado")
		velocidade = velocidade.move_toward(Vector2.ZERO, FRICCAO * delta)
	
	velocidade = move_and_slide(velocidade)
	
	if Input.is_action_just_pressed("ataque"):
		estado = ATAQUE
	
func ataque():
	animacao.play("ataque")
	
	if entrou_area_inimigo:
		inimigo.recebeu_ataque()

func recebeu_ataque():
	emit_signal("recebeu_ataque")
	
	estado = ATACADO
	var direction = (inimigo.get_transform().origin - get_transform().origin).normalized()
	velocidade = -direction * (inimigo.get_forca() - resistencia)

func ataque_finalizado():
	estado = MOVIMENTO

func _on_area_entered(_area):
	entrou_area_inimigo = true

func _on_area_exited(_area):
	entrou_area_inimigo = false

func set_terminou(b):
	terminou = b
