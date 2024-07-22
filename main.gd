extends Node

var towerSelected = false
var selectedTower
var selectedSprite
var life_points = 5

var torres = {
		"normal" = preload("res://Torres/Torre Normal/torre_normal.tscn"),
		"ice" = preload("res://Torres/Torre Ice/torre_ice.tscn"),
		"hard"=preload("res://Torres/Torre Hard/torre_hard.tscn"),
		"bomb"=preload("res://Torres/Torre Bomb/torre_bomb.tscn")
		}

var towerSprites = {
	"normal"=preload("res://Torres/Torre Normal/selectNormal.tscn"),
	"ice"=preload("res://Torres/Torre Ice/selectIce.tscn"),
	"hard"=preload("res://Torres/Torre Hard/selectHard.tscn"),
	"bomb"=preload("res://Torres/Torre Bomb/selectBomb.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func selectTower(type):  # Selecciona torre y coloca sprite sobre el cursor
	selectedTower = torres[type].instantiate()
	selectedSprite = towerSprites[type].instantiate()
	add_child(selectedSprite)
	towerSelected = true

func _input(event): # Coloca torre al hacer click
	if event is InputEventMouseButton and towerSelected :
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			place_tower(event.position)

func place_tower(position):
	# Example function to place a tower at the clicked position
	selectedTower.position = position
	add_child(selectedTower)
	towerSelected = false
	selectedSprite.queue_free()

# Funciones al apretar boton de nueva torre
func _on_new_tower_button_pressed():
	selectTower("normal")
	towerSelected = true

func _on_tower_button_ice_pressed():
	selectTower("ice")
	towerSelected = true # Replace with function body.

func _on_tower_button_hard_pressed():
	selectTower("hard")
	towerSelected = true # Replace with function body.

func _on_tower_button_bomb_pressed():
	selectTower("bomb")
	towerSelected = true

# Llama siguiente oleada prematuramente

func _on_next_wave_button_pressed():
	pass

func enemy_arrived():
	life_points -= 1
	if life_points == 0:
		print("perdiste")
		
