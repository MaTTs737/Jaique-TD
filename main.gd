extends Node

var towerSelected = false
var selectedTower
var selectedSprite
var life_points = 100
var coins : int = 30
var current_tower_slot
@onready var tower_normal = $tower_button_normal
@onready var tower_ice = $tower_button_ice
@onready var tower_hard = $tower_button_hard
@onready var tower_bomb = $tower_button_bomb
var slotSelected = false

var tower_buttons = [
	tower_normal,
	tower_ice,
	tower_hard,
	tower_bomb
]

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

var towerCost = {
	normal = 10,
	hard = 50,
	ice = 30,
	bomb = 100,
}


const pantallaPausa = preload("res://Sistema/pantallaPausa.tscn")
const pantallaVictoria = preload("res://Sistema/pantallaVictoria.tscn")
const pantallaDerrota = preload("res://Sistema/pantallaDerrota.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	disable_tower_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if slotSelected:
		enable_tower_buttons()
	if coins > 1000:
		win()
	if Input.is_action_just_pressed("pausa"):
		var pausaScreen = pantallaPausa.instantiate()
		add_child(pausaScreen)
		get_tree().paused = true
		
		#get_tree().change_scene_to_file("res://Sistema/pantallaPausa.tscn")


# func selectTower(type):  # Selecciona torre y coloca sprite sobre el cursor3	selectedTower = torres[type].instantiate()
#	selectedSprite = towerSprites[type].instantiate()
#	add_child(selectedSprite)
#	towerSelected = true

#func _input(event): # Coloca torre al hacer click
#	if event is InputEventMouseButton and towerSelected :
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			place_tower(event.position)

#func place_tower(position):
func place_tower():# Example function to place a tower at the clicked position
	#selectedTower.position = position
	var new_tower = selectedTower.instantiate()
	current_tower_slot.add_child(new_tower)
	coins -= towerCost[new_tower.type]
	updateTowerCost(new_tower.type)
	current_tower_slot.textureButton.disabled = true
	current_tower_slot.selected = false
	towerSelected = false
	#selectedSprite.queue_free()
	disable_tower_buttons()
	current_tower_slot = null
	slotSelected = false
	

# Funciones al apretar boton de nueva torre
func _on_new_tower_button_pressed():
	selectedTower=torres.normal
	place_tower()
	disable_tower_buttons()
	#selectTower("normal")
	#towerSelected = true

func _on_tower_button_ice_pressed():
	selectedTower=torres.ice
	place_tower()
	disable_tower_buttons()
	#selectTower("ice")
	#towerSelected = true # Replace with function body.

func _on_tower_button_hard_pressed():
	selectedTower=torres.hard
	place_tower()
	disable_tower_buttons()
	#selectTower("hard")
	#towerSelected = true # Replace with function body.

func _on_tower_button_bomb_pressed():
	selectedTower=torres.bomb
	place_tower()
	disable_tower_buttons()
	#selectTower("bomb")
	#towerSelected = true

# Llama siguiente oleada prematuramente

func _on_next_wave_button_pressed():
	pass

func enemy_arrived():
	life_points -= 1
	if life_points == 0:
		lose()

func disable_tower_buttons():
	tower_normal.disabled = true
	tower_ice.disabled = true
	tower_hard.disabled = true
	tower_bomb.disabled = true

func enable_tower_buttons():
	tower_normal.disabled = false
	tower_ice.disabled = false
	tower_hard.disabled = false
	tower_bomb.disabled = false

#func update_tower(new_tower):
#	var old_tower = slotSelected.find_tower()
#	var upgrade_tower = torres.normal.instantiate()
#	old_tower.queue_free()
#	slotSelected.add_child(upgrade_tower)

func win():
	get_tree().paused = true
	var vic = pantallaVictoria.instantiate()
	add_child(vic)
	
func lose():
	get_tree().paused = true
	var lose = pantallaDerrota.instantiate()
	add_child(lose)

func updateTowerCost(tower):
	for i in torres:
		if tower == i:
			towerCost[tower] *= 1.05
			towerCost[tower]=int(towerCost[tower])
			print (towerCost[tower])
