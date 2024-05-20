extends Node

var damage
var target
var shooting_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = get_parent().damage
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	followTarget()

func hit():
	target.healthPoints -= damage
	queue_free()

func followTarget():
	shooting_direction = (target.global_position - self.global_position).normalized()
	self.global_position = self.global_position + shooting_direction
