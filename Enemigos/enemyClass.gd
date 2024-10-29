extends Area2D

signal freeze
signal special_s
signal back_to_normal
signal arrived_signal(dmg)
signal enemy_died
enum enemyState{idle, frozen, special}

var healthPoints: int = 200
var damage:int
var type: String
@export var initialSpeed : int
var speed : int
var reward : int = 10
var specialCondition = false
@onready var state = enemyState.idle
@onready var anim = $AnimatedSprite2D
@onready var audio_freeze = $audio_freeze

var path_follow : PathFollow2D
var proyectil # Almacena el tipo de proyectil que golpea

const efectoMuerte = preload("res://Enemigos/assets/effects/effect_death.tscn")
const hitEffect = preload("res://Enemigos/assets/effects/effect_hit..tscn")

@onready var sonido_freeze = load("res://Assets Generales/Audios/breaking-ice-98676.mp3")

func transition_to(new_state:enemyState):
	state = new_state
	match state:
		enemyState.idle:
			emit_signal("back_to_normal")
			get_parent().speed = initialSpeed
			specialCondition = false
		enemyState.frozen:
			audio_freeze.play()
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
	emit_signal("enemy_died")
	var efecto = efectoMuerte.instantiate() # Instancia escena con efecto de muerte
	efecto.global_position = global_position
	get_tree().current_scene.add_child(efecto) # Lo agrega a la escena main
	get_tree().current_scene.coins += reward # Entrega recompensa
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	healthPoints=DifficultySettings.enemyHP[type]
	reward=DifficultySettings.enemyReward[type]
	initialSpeed=DifficultySettings.enemySpeed[type]
	damage=DifficultySettings.enemyDamage[type]
	get_parent().speed = initialSpeed
	 #path_follow = self.get_parent() // devuelve que no se puede asignar un valor de tipo nodo a un objeto pathfollow.
	connect("arrived_signal",get_tree().current_scene.arrival)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		
	if healthPoints <= 0:
		die()
	# Verificar si el nodo PathFollow2D está configurado
	#if path_follow:
	#	path_follow.progress+=1
	#else:
	#print("no hay")

func get_hit(damage,type):
	var efecto = hitEffect.instantiate()  # Instancia escena de efecto grafico de golpe
	efecto.global_position = global_position
	get_tree().current_scene.add_child(efecto)
	healthPoints -= damage
	

func _on_special_condition_timeout():
	specialCondition = false
	transition_to(enemyState.idle)


func _on_area_entered(area):
	if area.is_in_group("ammo"):
		get_hit(area.damage,area.type)
		proyectil = area.type  # Identifica el tipo de proyectil para definir sonido
		if (area.type == "ice") and (state != enemyState.frozen):
			transition_to(enemyState.frozen)
			

func arrived():
	emit_signal("arrived_signal",damage)
	emit_signal("enemy_died")
	queue_free()
