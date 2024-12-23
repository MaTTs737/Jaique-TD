extends Node


@onready var tower_normal = $tower_button_normal
@onready var tower_ice = $tower_button_ice
@onready var tower_hard = $tower_button_hard
@onready var tower_bomb = $tower_button_bomb
@onready var fog_material = $"map/CanvasLayer/TextureRect".material
@onready var audio_arrival = $audio_arrival
@onready var arrival_sound = load("res://Assets Generales/Audios/splash-death-splash-46048.mp3")

var wave = 0
var towerSelected = false
var selectedTower
var selectedSprite 
var life_points = 100
var max_life_points = 100
var coins : int = 300
var selectedType = ""
var towerPlaced : Callable = func towerPlaced():
	$cancelButton.disabled = true
	enable_tower_buttons()
	$towerSlots.update_slots()

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

@export var arrival : Callable = func enemy_arrived(damage:int):
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


const pantallaPausa = preload("res://Sistema/pantallaPausa.tscn")
const pantallaVictoria = preload("res://Sistema/pantallaVictoria.tscn")
const pantallaDerrota = preload("res://Sistema/pantallaDerrota.tscn")
const arriveEffect = preload("res://Enemigos/assets/effects/effect_arrive.tscn")

func _ready():
	DifficultySettings.reset_difficulty_variables()
	update_fog_intensity()
	$audio_background.stream.loop = true
	Global.player_won = false
	$towerSlots.disable_slots()
	$cancelButton.disabled = true
	
func _process(_delta):
	if Input.is_action_just_pressed("pausa"):
		var pausaScreen = pantallaPausa.instantiate()
		add_child(pausaScreen)
		get_tree().paused = true
		#get_tree().change_scene_to_file("res://Sistema/pantallaPausa.tscn")
	if Input.is_action_just_pressed("ui_down"):
		life_points -= 5
		update_fog_intensity()

# Funciones al apretar boton de nueva torre
func _on_new_tower_button_pressed():
	selectTower("normal")
	selectedType = "normal"
	
	#selectTower("normal")
	#towerSelected = true

func _on_tower_button_ice_pressed():
	selectTower("ice")
	selectedType = "ice"
	#selectTower("ice")
	#towerSelected = true # Replace with function body.

func _on_tower_button_hard_pressed():
	selectTower("hard")
	selectedType = "hard"
	#selectTower("hard")
	#towerSelected = true # Replace with function body.

func _on_tower_button_bomb_pressed():
	selectTower("bomb")
	selectedType = "bomb"
	#selectTower("bomb")
	#towerSelected = true


func disable_tower_buttons():
	tower_normal.canceled = true
	tower_ice.canceled = true
	tower_hard.canceled = true
	tower_bomb.canceled = true

func enable_tower_buttons():
	tower_normal.canceled = false
	tower_ice.canceled = false
	tower_hard.canceled = false
	tower_bomb.canceled = false

#func update_tower(new_tower):   // Futura func de upgrade de torre
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
			DifficultySettings.towerCost[tower] *= 1.05
			DifficultySettings.towerCost[tower]=int(DifficultySettings.towerCost[tower])
			print (DifficultySettings.towerCost[tower])

func update_fog_intensity():
	var fog_intensity = 1.0 - float(life_points)/float(max_life_points)
	fog_material.set_shader_parameter("fog_intensity",fog_intensity)

func update_progress():
	$Control/ProgressBar.value = $map.wave

func selectTower(type):
	selectedTower = torres[type]
	disable_tower_buttons()
	$towerSlots.choose_place()
	coins -= DifficultySettings.TOWER_COST_DEFAULT[type]
	$cancelButton.disabled = false
	
func cancel_tower_selection(tower):
	coins += DifficultySettings.TOWER_COST_DEFAULT[tower]
	selectedTower = null
	selectedType = null
	enable_tower_buttons()
	$towerSlots.update_slots()
	
func _on_cancel_button_pressed() -> void:
	cancel_tower_selection(selectedType)
	$cancelButton.disabled = true
