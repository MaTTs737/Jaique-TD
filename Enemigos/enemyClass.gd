extends Area2D

signal freeze
signal special_s
signal back_to_normal
signal enemy_arrived(dmg)
signal enemy_died (efecto,drop,reward)
signal enemy_eliminated
enum enemyState{idle, frozen, special}

var healthPoints: int
var damage:int
var type: String
var defaultSpeed : int
var reward : int
var specialCondition = false

var frozenTime = 3

@onready var state = enemyState.idle
@onready var anim = $AnimatedSprite2D
@onready var audio_freeze = $audio_freeze

# Estas lineas precargan escenas de efectos visuales
const efectoMuerte = preload("res://Enemigos/assets/effects/effect_death.tscn") 
const efectoHit = preload("res://Enemigos/assets/effects/effect_hit..tscn")
const efectoDrop = preload("res://Enemigos/assets/effects/effect_coinDrop.tscn")
@onready var sonido_freeze = load("res://Assets Generales/Audios/breaking-ice-98676.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	#instancia los valores segun el tipo del que se trate
	healthPoints=DifficultySettings.enemyHP[type]
	reward=DifficultySettings.enemyReward[type]
	damage=DifficultySettings.enemyDamage[type]
	
	# Para que la velocidad tome efecto se la debe asignar la nodo pathFollow2D del cual los enemigos son hijos
	defaultSpeed= DifficultySettings.enemySpeed[type]
	get_parent().speed = defaultSpeed

# Called every frame.
func _process(_delta):
	pass


func go_idle():
	emit_signal("back_to_normal")
	get_parent().speed = defaultSpeed
	specialCondition = false
	
func go_frozen():
	audio_freeze.play()
	get_parent().speed = defaultSpeed/4
	specialCondition = true
	$specialCondition.start(frozenTime)
	emit_signal("freeze")
	
func go_special ():
	specialCondition = true
	$specialCondition.start()
	emit_signal("special_s")

func transition_to(new_state:enemyState):
	state = new_state
	match state:
		enemyState.idle:
			go_idle()
		enemyState.frozen:
			go_frozen()
		enemyState.special:
			go_special()

func get_hit(damage,type):
	var efecto = efectoHit.instantiate()  # Instancia escena de efecto grafico de golpe
	efecto.global_position = global_position
	get_tree().current_scene.add_child(efecto)
	healthPoints -= damage
	if healthPoints <= 0:
		die()
	

func die():
	var efecto = efectoMuerte.instantiate()
	var drop = efectoDrop.instantiate() # Instancian escena con efecto de muerte y drop
	efecto.global_position = global_position
	drop.global_position = global_position
	emit_signal("enemy_eliminated")
	emit_signal("enemy_died",efecto,drop,reward)
	queue_free()

func arrived():
	emit_signal("enemy_eliminated")
	emit_signal("enemy_arrived",damage)
	queue_free()


func _on_special_condition_timeout():
	specialCondition = false
	transition_to(enemyState.idle)


func _on_area_entered(area):
	if area.is_in_group("ammo"):
		get_hit(area.damage,area.type)
		if (area.type == "ice") and (state != enemyState.frozen):
			transition_to(enemyState.frozen)
