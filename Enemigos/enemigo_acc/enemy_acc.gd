extends "res://Enemigos/enemyClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func transition_to(new_state):
	state = new_state
	match state:
		"idle":
			emit_signal("back_to_normal")
			get_parent().speed = initialSpeed
		
		"frozen":
			get_parent().speed /= 4
			specialCondition = true
			$specialCondition.start()
			emit_signal("freeze")
		"special":
			get_parent().speed *= 2
			specialCondition = true
			$specialCondition.start()
			emit_signal("special_s")
