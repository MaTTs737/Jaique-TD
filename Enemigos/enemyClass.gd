extends Area2D

var healthPoints: int = 2
var type: String
var speed : int
var damage : int
var reward : int
var specialCondition = false
@onready var anim = $AnimatedSprite2D
var path_follow : PathFollow2D
func getSpecialCondition(time,atribute,amount):
	specialCondition = true
	$specialCondition.start(time)
	self.atribute = self.atribute+amount
	
func die():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("walking")
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

#func get_hit():
#	healthPoints -= 1
