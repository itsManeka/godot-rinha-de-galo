extends ScrollContainer

signal selecionou(galo)

var pre_painel_galo = preload("res://menus/grids/GaloPanel.tscn")

onready var container = $VBoxContainer

func preenche(galos):
	for galo in galos:
		var painel = pre_painel_galo.instance()
		painel.set_dados(galo as Galo)
		painel.connect("selecionou", self, "_on_selecionou_galo")
		container.add_child(painel)
	
	container.get_child(0).seleciona()

func _on_selecionou_galo(galo):
	emit_signal("selecionou", galo)
	
	for panel in container.get_children():
		if panel.get_galo() != galo:
			panel.set_selecionado(false)
