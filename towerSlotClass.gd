extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_texture_button_pressed():
	get_tree().get_current_scene().current_tower_slot = self
	get_tree().get_current_scene().slotSelected = true
