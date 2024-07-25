extends Area2D

var damage: int
var target: Area2D
var speed: float = 600.0  # Adjust the speed as necessary
var shooting_direction: Vector2
var target_die : Callable = func(): queue_free()
var type : String

func _ready():
	if target: target.connect("tree_exited",self.target_die)
	if target:
		shooting_direction = (target.global_position - global_position).normalized()

func _process(delta):
	if target:
		follow_target(delta)
		#if (target.global_position - global_position).length() < 2:  # Check if close enough to hit
		#	hit()
	else:
		queue_free()

func follow_target(delta):
	var direction = (target.global_position - global_position).normalized()
	position += direction * speed * delta

func hit():
	queue_free()
	
func _on_area_entered(area):
	if area.is_in_group("enemies"):
		hit()
