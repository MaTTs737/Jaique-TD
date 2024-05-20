extends Node

var healthPoints: int
var type: String
var speed : int
var damage : int
var reward : int
var specialCondition = false


func getSpecialCondition(time,atribute,amount):
	specialCondition = true
	$specialCondition.start(time)
	self.atribute = self.atribute+amount
	
func die():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if healthPoints <= 0:
		die()


func _on_special_condition_timeout():
	specialCondition = false
