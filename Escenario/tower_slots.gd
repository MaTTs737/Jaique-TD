extends Node2D

func disable_slots():
	for i in get_children():
		i.textureButton.disabled = true
		
func enable_slots():
	for i in get_children():
		i.textureButton.disabled = false

func update_slots():
	for i in get_children():
		i.update()

func choose_place():
	for i in get_children():
		if i.has_tower:
			i.textureButton.disabled = true
		else : i.textureButton.disabled = false
		i.delete_button.disabled = true
