extends Area2D

signal placedTower

@onready var delete_button = $delete_button
@onready var textureButton = $TextureButton

var has_tower = false
var towerCost
var selected = false
# Called when the node enters the scene tree for the first time.

func _ready():
	delete_button.disabled = true
	connect("placedTower",get_tree().current_scene.towerPlaced)
	

func _on_texture_button_pressed():
	if !has_tower:   # chequea si ya tiene una torre
		add_child(get_tree().current_scene.selectedTower.instantiate())
		has_tower = true
		get_parent().update_slots()
		emit_signal("placedTower")
	
			   # Funcion preparada para upgradear torres en el futuro
	#else:
	#	get_tree().get_current_scene().current_tower_slot = self
	#	get_tree().get_current_scene().slotSelected = true

func find_tower():    # Devuelve la torre que esta en este slot
	for i in get_children():
		if i.is_in_group("towers"):
			return i

func _on_delete_button_pressed() -> void:
	for i in get_children():
		if i.is_in_group("towers"):
			i.queue_free()
	has_tower = false
	delete_button.disabled = true
	get_parent().update_slots()
	
func update():
	if has_tower:
		delete_button.disabled = false
		textureButton.disabled = true
	elif !has_tower:
		textureButton.disabled = true
		delete_button.disabled = true
		
