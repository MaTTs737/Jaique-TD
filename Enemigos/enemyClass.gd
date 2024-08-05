extends Area2D

signal freeze
signal special_s
signal back_to_normal

enum enemyState{idle, frozen, special}

var healthPoints: int = 200
var type: String
@export var initialSpeed : int
var speed : int
var reward : int = 10
var specialCondition = false
@onready var state = enemyState.idle
@onready var anim = $AnimatedSprite2D
var path_follow : PathFollow2D

const efectoMuerte = preload("res://Enemigos/efectoMuerte.tscn")

func transition_to(new_state:enemyState):
	state = new_state
	match state:
		enemyState.idle:
			emit_signal("back_to_normal")
			get_parent().speed = initialSpeed
			specialCondition = false
		enemyState.frozen:
			get_parent().speed /= 4
			specialCondition = true
			$specialCondition.start()
			emit_signal("freeze")
		enemyState.special:
			specialCondition = true
			$specialCondition.start()
			emit_signal("special_s")



#func getSpecialCondition(time,atribute,amount):
#	specialCondition = true
#	$specialCondition.start(time)
#	self.atribute = self.atribute+amount
	
	
func die():
	var efecto = efectoMuerte.instantiate()
	efecto.global_position = global_position
	get_tree().current_scene.add_child(efecto)
	get_tree().current_scene.coins += reward
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	healthPoints=DifficultySettings.enemyHP[type]
	reward=DifficultySettings.enemyReward[type]
	initialSpeed=DifficultySettings.enemySpeed[type]
	get_parent().speed = initialSpeed
	 #path_follow = self.get_parent() // devuelve que no se puede asignar un valor de tipo nodo a un objeto pathfollow.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		
	if healthPoints <= 0:
		die()
	# Verificar si el nodo PathFollow2D está configurado
	#if path_follow:
	#	path_follow.progress+=1
	#else:
	#print("no hay")

func get_hit(damage):
	healthPoints -= damage

func _on_special_condition_timeout():
	specialCondition = false
	transition_to(enemyState.idle)


func _on_area_entered(area):
	if area.is_in_group("ammo"):
		get_hit(area.damage)
		if (area.type == "ice") and (state != enemyState.frozen):
			transition_to(enemyState.frozen)

func arrived():
	get_tree().get_current_scene().enemy_arrived()
	queue_free()
