extends Area2D

@onready var textureButton = $TextureButton
var has_tower = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_tower:
		$TextureButton.disabled = true

func _on_texture_button_pressed():
	if !has_tower:   # chequea si ya tiene una torre
		get_tree().get_current_scene().current_tower_slot = self # devuelve el slot al main
		get_tree().get_current_scene().slotSelected = true
	
			   # Funcion preparada para upgradear torres en el futuro
	#else:
	#	get_tree().get_current_scene().current_tower_slot = self
	#	get_tree().get_current_scene().slotSelected = true

#func find_tower():    # Devuelve la torre que esta en este slot
	for i in get_children():
		if i.is_in_group("towers"):
			return i
