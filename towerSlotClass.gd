extends Area2D

signal delete

@onready var delete_button = $delete_button
@onready var textureButton = $TextureButton
@onready var upgradeButton = $upgrade_button

var has_tower = false
var towerCost
var selected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	delete_button.disabled = true
	connect("delete",get_tree().current_scene.delete_tower)
	upgradeButton.disabled = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if selected : 
		pass
	if has_tower and upgradeButton.disabled:
		upgradeButton.disabled = false
		
	
func _on_texture_button_pressed():
	if !has_tower:   # chequea si ya tiene una torre
		get_tree().get_current_scene().current_tower_slot = self # devuelve el slot al main
		get_tree().get_current_scene().slotSelected = true
		textureButton.button_pressed = true
		for i in get_parent().get_children():
			selected = false
		selected = true
			   # Funcion preparada para upgradear torres en el futuro
	#else:
	#	get_tree().get_current_scene().current_tower_slot = self
	#	get_tree().get_current_scene().slotSelected = true

func find_tower():    # Devuelve la torre que esta en este slot
	for i in get_children():
		if i.is_in_group("towers"):
			return i


func _on_delete_button_pressed() -> void:
	emit_signal("delete",self)



func _on_upgrade_button_pressed() -> void:
	var currentTower = find_tower()
	var newTower = DifficultySettings.LEVEL_2_TOWERS[currentTower.type]
	currentTower.queue_free()
	var tower = newTower.instantiate()
	tower.type = "normal"
	add_child(tower)
	
