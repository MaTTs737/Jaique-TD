extends "res://Enemigos/enemyClass.gd"

var broken_1
var broken_2

# Called when the node enters the scene tree for the first time.
func _ready():
	healthPoints *= 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if healthPoints<201 and broken_1 == false:
		broken_1 = true
		transition_to(idle)
	elif healthPoints<101 and broken_2 == false:
		broken_2 = true
		transition_to(idle)

func transition_to(new_state):
	state = new_state
	match state:
		idle:
			if healthPoints>200:
				$AnimatedSprite2D.play("idle")
			elif healthPoints > 100:
				$AnimatedSprite2D.play("broken_1")
			else : $AnimatedSprite2D.play("broken_2")
			
			speed = initialSpeed
		frozen:
			if healthPoints>200:
				$AnimatedSprite2D.play("frozen")
			elif healthPoints > 100:
				$AnimatedSprite2D.play("broken_1_f")
			else : $AnimatedSprite2D.play("broken_2_f")
			
			speed /= 2
			specialCondition = true
			$specialCondition.start()
		special:
			specialCondition = true
			$specialCondition.start()
			$AnimatedSprite2D.play("special")
