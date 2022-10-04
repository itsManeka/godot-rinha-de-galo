extends Node2D

class_name Ringue

onready var jogador = $Jogador
onready var inimigo = $Inimigo
onready var label_tempo = $Tempo
onready var aposta = $Apostas
onready var timer_aposta = $TimerAposta
onready var timer_terminou = $TimerTerminou
onready var label_fim = $Fim
onready var pessoas = $Pessoas
onready var timer_empate = $Timer

var tempo = 60
var terminou : bool = false
var resultado_luta

var ataques_recebidos_jogador = 0
var ataques_recebidos_inimigo = 0

var is_rei_dos_galos = false

func _ready():
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.REI_DOS_GALOS:
		is_rei_dos_galos = true
		pessoas.visible = false
		aposta.visible = false
		label_tempo.visible = false
	
	label_fim.visible = false
	label_tempo.text = ("%02d" % tempo)
	jogador.inicia(self)
	inimigo.inicia(self)

func _on_saiu_do_ringue(area):
	if area.get_parent() in [jogador, inimigo]:
		terminou = true
		
		para_timers()
		
		inimigo.set_terminou(terminou)
		jogador.set_terminou(terminou)
		
		if area.get_parent() == jogador:
			resultado_luta = Global.resultado.PERDEU
		else:
			resultado_luta = Global.resultado.GANHOU
		
		label_fim.visible = true
		timer_terminou.start(1.5)

func para_timers():
	timer_aposta.stop()
	timer_empate.stop()

func get_inimigo():
	return inimigo

func get_jogador():
	return jogador

func _on_saiu_limite_ia(area):
	if area.get_parent() == inimigo:
		inimigo.set_dentro_area_controle(false)

func _on_entrou_limite_ia(area):
	if area.get_parent() == inimigo:
		inimigo.set_dentro_area_controle(true)

func _on_timeout():
	if terminou or is_rei_dos_galos:
		return
		
	tempo -= 1
	label_tempo.text = ("%02d" % tempo)
	
	if tempo <= 0:
		terminou = true
		
		para_timers()
		
		inimigo.set_terminou(terminou)
		jogador.set_terminou(terminou)
		resultado_luta = Global.resultado.EMPATE
		label_fim.visible = true
		timer_terminou.start(1.5)
	
func _on_Jogador_recebeu_ataque():
	ataques_recebidos_jogador += 1

func _on_Inimigo_recebeu_ataque():
	ataques_recebidos_inimigo += 1

func _on_TimerAposta_timeout():
	if terminou or is_rei_dos_galos:
		return
		
	timer_aposta.wait_time = rand_range(1.5, 3.5)
	
	if ataques_recebidos_jogador > ataques_recebidos_inimigo:
		if randi()%3 > 0:
			aposta.adiciona_aposta_galo(rand_range(2, 20))
		else:
			aposta.adiciona_aposta_adv(rand_range(2, 20))
	else:
		if randi()%3 > 0:
			aposta.adiciona_aposta_adv(rand_range(2, 20))
		else:
			aposta.adiciona_aposta_galo(rand_range(2, 20))
	
func _on_TimerTerminou_timeout():
	if Global.get_tipo_luta_iniciado() == Global.tipo_luta.RINHA:
		Global.set_dados_luta(resultado_luta, aposta.get_total_aposta())
		get_tree().change_scene("res://menus/LutaConcluida.tscn")
	else:
		if resultado_luta == Global.resultado.PERDEU:
			Global.set_dados_luta(resultado_luta, 0)
			get_tree().change_scene("res://menus/LutaConcluida.tscn")
		else:
			if Global.get_campeao() == 4:
				Global.set_dados_luta(Global.resultado.REI_DOS_GALOS, 0)
				get_tree().change_scene("res://menus/LutaConcluida.tscn")
			else:
				get_tree().change_scene("res://menus/ReiDosGalos.tscn")
