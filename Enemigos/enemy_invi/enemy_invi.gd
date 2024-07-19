extends "res://Enemigos/enemyClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func transition_to(new_state):
	state = new_state
	match state:
		idle:
			$AnimatedSprite2D.play("idle")
			speed = initialSpeed
			$CollisionShape2D.disabled = false
		frozen:
			speed /= 2
			$AnimatedSprite2D.play("frozen")
			specialCondition = true
			$specialCondition.start()
		special:
			$CollisionShape2D.disabled
			specialCondition = true
			$specialCondition.start()
			$AnimatedSprite2D.play("special")
