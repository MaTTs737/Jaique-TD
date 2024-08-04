extends Control

# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_volver_a_jugar_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")

func _on_salir_al_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Sistema/menuPrincipal.tscn")

func _on_salir_del_juego_pressed():
	get_tree().quit()
