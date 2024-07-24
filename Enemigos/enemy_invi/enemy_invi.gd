extends "res://Enemigos/enemyClass.gd"

@onready var invi_timer = $invi_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	invi_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)


func transition_to(new_state):
	state = new_state
	match state:
		idle:
			emit_signal("back_to_normal")
			get_parent().speed = initialSpeed
			invi_timer.start()
			$CollisionShape2D.disabled = false
		frozen:
			get_parent().speed /= 4
			specialCondition = true
			$specialCondition.start()
			emit_signal("freeze")
		special:
			specialCondition = true
			$CollisionShape2D.disabled = true
			$specialCondition.start()
			emit_signal("special_s")

func go_invi():
	transition_to(special)
	


func _on_invi_timer_timeout():
	go_invi()
