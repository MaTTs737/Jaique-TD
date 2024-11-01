extends Node2D

var step = 0

func next_step():
	step +=1
	run_step(step)
	
func previous_step():
	if step == 0:
		pass
	else: step -= 1
	run_step(step)

func make_all_invisible():
	$display_inicial.visible = false
	$display_monedas_y_vidas.visible = false
	$display_seleccion_torre.visible = false
	$display_slots.visible = false
	$display_final.visible = false
	

func run_step(x):
	make_all_invisible()
	match x:
		0: make_all_invisible()
		1: $display_seleccion_torre.visible = true
		2: $display_slots.visible = true
		3: $display_monedas_y_vidas.visible = true
		4: $display_final.visible = true


func _on_boton_siguiente_pressed() -> void:
	next_step()
	if step ==4:
		$boton_siguiente.queue_free()


func _on_boton_volver_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Sistema/menuPrincipal.tscn") # Replace with function body.


func _on_boton_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://Sistema/tutorial_version_2.tscn") # Replace with function body.


func _on_boton_anterior_pressed() -> void:
	previous_step()


func _on_boton_empezar_pressed() -> void:
	$display_inicial.visible = true
	$boton_siguiente.visible = true
	$boton_anterior.visible = true
	$boton_reiniciar.visible = true
	$boton_empezar.visible = false
