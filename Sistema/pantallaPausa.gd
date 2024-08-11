extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_boton_volver_pressed():
	get_tree().paused = false
	queue_free()


func _on_boton_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Sistema/menuPrincipal.tscn")


func _on_boton_salir_pressed():
	get_tree().quit()


func _on_boton_reiniciar_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")
