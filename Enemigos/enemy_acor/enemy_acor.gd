extends "res://Enemigos/enemyClass.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	healthPoints *= 3
	reward = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if healthPoints>200 and state == idle:
		anim.animation = "idle"
	if healthPoints<200 and healthPoints >= 101 and state == idle:
		anim.animation = "broken_1"
	elif healthPoints<101 and state == idle:
		anim.animation = "broken_2"

func transition_to(new_state):
	state = new_state
	match state:
		idle:
			get_parent().speed = initialSpeed
		frozen:
			if healthPoints>200:
				anim.animation = "frozen"
			elif healthPoints > 100:
				anim.animation = "broken_1_f"
			else : anim.animation = "broken_2_f"
			
			get_parent().speed /= 2
			specialCondition = true
			$specialCondition.start()
		special:
			specialCondition = true
			$specialCondition.start()

func _on_area_entered(area):
	if area.is_in_group("ammo"):
		if area.type == "hard":
			get_hit(area.damage)
		elif area.type == "ice" and (state != frozen):
			transition_to(frozen)
	else: pass
