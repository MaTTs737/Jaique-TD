extends Node


@onready var tower_normal = $tower_button_normal
@onready var tower_ice = $tower_button_ice
@onready var tower_hard = $tower_button_hard
@onready var tower_bomb = $tower_button_bomb
@onready var fog_material = $"map/CanvasLayer/TextureRect".material
@onready var audio_arrival = $audio_arrival
@onready var arrival_sound = load("res://Assets Generales/Audios/splash-death-splash-46048.mp3")

var towerSelected = false
var selectedTower
var selectedSprite 
var life_points = 100
var max_life_points = 100
var coins : int = 300

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

var towerCost

var arrival : Callable = func enemy_arrived(damage:int):
	update_fog_intensity()
	audio_arrival.stream = arrival_sound
	audio_arrival.volume_db = -10
	audio_arrival.play()
	var arrive_effect = arriveEffect.instantiate()
	arrive_effect.global_position = $map/end/CollisionShape2D.global_position
	add_child(arrive_effect)
	life_points -= damage
	if life_points <= 0:
		lose()
var delete_tower : Callable = func delete_tower(towerSlot):
	for i in towerSlot.get_children():
		if i.is_in_group("towers"):
			i.queue_free()
	towerSlot.has_tower = false
	towerSlot.textureButton.disabled = false

const pantallaPausa = preload("res://Sistema/pantallaPausa.tscn")
const pantallaVictoria = preload("res://Sistema/pantallaVictoria.tscn")
const pantallaDerrota = preload("res://Sistema/pantallaDerrota.tscn")
const arriveEffect = preload("res://Enemigos/arrive_effect.tscn")

func _ready():
	DifficultySettings.reset_difficulty_variables()
	towerCost = DifficultySettings.towerCost
	update_fog_intensity()
	$audio_background.stream.loop = true
	Global.player_won = false
	$towerSlots.disable_slots()
	
func _process(_delta):
	if Input.is_action_just_pressed("pausa"):
		var pausaScreen = pantallaPausa.instantiate()
		add_child(pausaScreen)
		get_tree().paused = true
		#get_tree().change_scene_to_file("res://Sistema/pantallaPausa.tscn")
	if Input.is_action_just_pressed("ui_down"):
		life_points -= 5
		update_fog_intensity()
# func selectTower(type):  # Selecciona torre y coloca sprite sobre el cursor3	selectedTower = torres[type].instantiate()
#	selectedSprite = towerSprites[type].instantiate()
#	add_child(selectedSprite)
#	towerSelected = true

#func _input(event): # Coloca torre al hacer click
#	if event is InputEventMouseButton and towerSelected :
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			place_tower(event.position)

#func place_tower(position):


# Funciones al apretar boton de nueva torre
func _on_new_tower_button_pressed():
	selectedTower=torres.normal
	disable_tower_buttons()
	$towerSlots.choose_place()
	towerCost = DifficultySettings.TOWER_COST_DEFAULT.normal
	coins -= towerCost
	
	#selectTower("normal")
	#towerSelected = true

func _on_tower_button_ice_pressed():
	selectedTower=torres.ice
	disable_tower_buttons()
	$towerSlots.choose_place()
	towerCost = DifficultySettings.TOWER_COST_DEFAULT.ice
	coins -= towerCost
	#selectTower("ice")
	#towerSelected = true # Replace with function body.

func _on_tower_button_hard_pressed():
	selectedTower=torres.hard
	disable_tower_buttons()
	$towerSlots.choose_place()
	towerCost = DifficultySettings.TOWER_COST_DEFAULT.hard
	coins -= towerCost
	#selectTower("hard")
	#towerSelected = true # Replace with function body.

func _on_tower_button_bomb_pressed():
	selectedTower=torres.bomb
	disable_tower_buttons()
	$towerSlots.choose_place()
	towerCost = DifficultySettings.TOWER_COST_DEFAULT.bomb
	coins -= towerCost
	#selectTower("bomb")
	#towerSelected = true


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
	Global.playerScore.timeSurvived=$map.timeSurvived
	get_tree().change_scene_to_file("res://Sistema/Cutscenes/closing.tscn")

func updateTowerCost(tower):
	for i in torres:
		if tower == i:
			towerCost[tower] *= 1.05
			towerCost[tower]=int(towerCost[tower])
			print (towerCost[tower])

func update_fog_intensity():
	var fog_intensity = 1.0 - float(life_points)/float(max_life_points)
	fog_material.set_shader_parameter("fog_intensity",fog_intensity)

func update_progress():
	$Control/ProgressBar.value = $map.wave
