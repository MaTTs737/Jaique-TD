extends Area2D


enum {idle, frozen, special}

var healthPoints: int = 100
var type: String
@export var initialSpeed : int
var speed : int
var damage : int = 1
var reward : int = 10
var specialCondition = false
@onready var state = idle
@onready var anim = $AnimatedSprite2D
var path_follow : PathFollow2D

func transition_to(new_state):
	state = new_state
	match state:
		idle:
			anim.play("idle")
			speed = initialSpeed
		frozen:
			speed /= 2
			anim.play("frozen")
			specialCondition = true
			$specialCondition.start()
		special:
			specialCondition = true
			$specialCondition.start()
			anim.play("special")



#func getSpecialCondition(time,atribute,amount):
#	specialCondition = true
#	$specialCondition.start(time)
#	self.atribute = self.atribute+amount
	
	
func die():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = initialSpeed
	 #path_follow = self.get_parent() // devuelve que no se puede asignar un valor de tipo nodo a un objeto pathfollow.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if healthPoints <= 0:
		die()
	# Verificar si el nodo PathFollow2D está configurado
	#if path_follow:
	#	path_follow.progress+=1
	#else:
	#print("no hay")


func _on_special_condition_timeout():
	specialCondition = false
	transition_to(idle)

#func get_hit():
#	healthPoints -= 1
