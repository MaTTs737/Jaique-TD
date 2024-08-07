extends "res://Enemigos/enemyClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	type = "acc"
	super._ready()
	$acc_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func transition_to(new_state:enemyState):
	state = new_state
	match state:
		enemyState.idle:
			emit_signal("back_to_normal")
			get_parent().speed = initialSpeed
			$acc_timer.start()
		enemyState.frozen:
			get_parent().speed /= 4
			specialCondition = true
			$specialCondition.start()
			emit_signal("freeze")
		enemyState.special:
			get_parent().speed *= 2
			specialCondition = true
			$specialCondition.start()
			emit_signal("special_s")


func _on_acc_timer_timeout():
	transition_to(enemyState.special)
