extends Node

var towerSelected = false
var selectedTower

var torres = {
		normal = preload("res://Torres/Torre Normal/torre_normal.tscn")
		}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func selectTower(type):
	selectedTower = torres.type.instance()
	towerSelected = true

func _input(event):
	if event is InputEventMouseButton and towerSelected :
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			place_tower(event.position)


func place_tower(position):
	# Example function to place a tower at the clicked position
	selectedTower.position = position
	add_child(selectedTower)

func _on_new_tower_button_pressed():
	selectTower("normal")
	towerSelected = true
