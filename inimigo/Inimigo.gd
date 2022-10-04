extends KinematicBody2D

class_name Inimigo

var dados_galo : Galo = null

var ACELERACAO = 500
var VELOCIDADE_MAXIMA = 70
var FRICCAO = 500

onready var sprite = $Sprite
onready var animacao = $AnimationPlayer
onready var timer_atacar = $TimerAtacar
onready var timer_troca_estado = $TimerTrocaEstado
onready var timer_perambular = $TimerPerambular

signal recebeu_ataque

enum {
	ATAQUE,
	ATACADO,
	PARADO,
	BUSCAR,
	PERAMBULAR
}

var resistencia = 0
var forca = 0
var velocidade = Vector2.ZERO
var ringue = null
var jogador : Jogador = null
var estado = BUSCAR
var entrou_area_jogador = false
var destino_perambular = Vector2.ZERO
var dentro_da_area = true

var terminou : bool = false

func _ready():
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.REI_DOS_GALOS:
		dados_galo = Global.get_galo_inimigo()
	else:
		dados_galo = GaloManager.get_galo_aleatorio_normal()
	
	sprite.texture = dados_galo.get_sprite()
	scale.x = dados_galo.get_tamanho()
	scale.y = dados_galo.get_tamanho()
	VELOCIDADE_MAXIMA = dados_galo.get_velocidade_maxima()
	forca = dados_galo.get_forca()
	resistencia = dados_galo.get_resistencia()

func inicia(_ringue : Ringue):
	ringue = _ringue
	jogador = ringue.get_jogador()
	
	troca_estado([BUSCAR, PARADO, PERAMBULAR])

func get_forca() -> int:
	return forca
	
func _physics_process(delta):
	if terminou:
		return
		
	if jogador:
		look_at(jogador.global_position)
	
	match estado:
		ATACADO:
			if not processa_recebeu_ataque(delta):
				return
			
		PARADO:
			animacao.play("parado")
			
			velocidade = velocidade.move_toward(Vector2.ZERO, FRICCAO * delta)
			velocidade = move_and_slide(velocidade)
			
		BUSCAR:
			animacao.play("andando")
			
			var direcao = global_position.direction_to(jogador.global_position)
			velocidade = velocidade.move_toward(direcao * VELOCIDADE_MAXIMA, ACELERACAO * delta)
			velocidade = move_and_slide(velocidade)
		
		PERAMBULAR:
			animacao.play("andando")
			
			var direcao = global_position.direction_to(destino_perambular)
			velocidade = velocidade.move_toward(direcao * VELOCIDADE_MAXIMA, ACELERACAO * delta)
			velocidade = move_and_slide(velocidade)
			
			if global_position == destino_perambular:
				atualiza_perambular()

func processa_recebeu_ataque(delta) -> bool:
	velocidade = velocidade.move_toward(Vector2.ZERO, 200 * delta)
	velocidade = move_and_slide(velocidade)

	if velocidade == Vector2.ZERO:
		troca_estado([BUSCAR, PARADO, PERAMBULAR])
	else:
		return false
	
	return true

func troca_estado(estados):
	if dentro_da_area:
		estados.shuffle()
		estado = estados.pop_front()
	else:
		estado = PERAMBULAR
	
	if estado == PERAMBULAR:
		atualiza_perambular()
		
	timer_troca_estado.start(rand_range(0.2, 0.7))

func recebeu_ataque():
	emit_signal("recebeu_ataque")
	
	estado = ATACADO
	var direction = (jogador.get_transform().origin - get_transform().origin).normalized()
	velocidade = -direction * (jogador.get_forca() - resistencia)

func ataque_finalizado():
	if !dentro_da_area:
		troca_estado([PERAMBULAR])
	else:
		troca_estado([BUSCAR, PERAMBULAR, PARADO])

func _on_area_entered(_area):
	entrou_area_jogador = true
	
	timer_atacar.start(0.1)

func _on_area_exited(_area):
	entrou_area_jogador = false

func _on_TimerAtacar_timeout():
	if estado == ATACADO:
		return
		
	estado = ATAQUE
	animacao.play("ataque")
	jogador.recebeu_ataque()

func _on_TimerTrocaEstado_timeout():
	if not estado in [ATACADO, ATAQUE]:
		troca_estado([BUSCAR, PERAMBULAR, PARADO])

func _on_TimerPerambular_timeout():
	atualiza_perambular()

func atualiza_perambular():
	timer_perambular.start(rand_range(0.5, 4))
	if dentro_da_area:
		destino_perambular = Vector2(rand_range(0, ProjectSettings.get_setting("display/window/size/width")),
									 rand_range(0, ProjectSettings.get_setting("display/window/size/height")))
	else:
		#centro do ringue
		destino_perambular = Vector2(rand_range(92, 225),
									 rand_range(50, 125))

func _on_TimerControleRingue_timeout():
	if not dentro_da_area:
		atualiza_perambular()

func set_dentro_area_controle(dentro : bool):
	dentro_da_area = dentro
	if !dentro_da_area:
		estado = PERAMBULAR
		atualiza_perambular()

func set_terminou(b):
	terminou = b
