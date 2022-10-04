extends Node2D

func get_galo_aleatorio():
	return get_child(randi() % get_child_count()).duplicate()

func get_galo_por_raca(raca):
	for galo in get_children():
		if galo.get_raca() == raca:
			return galo.duplicate()

func get_galo_aleatorio_normal():
	var galo: Galo = null
	while true:
		galo = get_galo_aleatorio()
		if !galo.is_especial():
			return galo

func get_galo_aleatorio_especial():
	var galo: Galo = null
	while true:
		galo = get_galo_aleatorio()
		if galo.is_especial():
			return galo
