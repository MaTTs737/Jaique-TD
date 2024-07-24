extends Node2D

var damage : int = 50
var type : String
var target : Object
var enemies_in_range = []
var enemyIn = Callable(self,"_on_DetectionArea_area_entered")
var enemyOut = Callable(self,"_on_DetectionArea_area_exited")
var projectil = preload("res://Torres/Projectiles/projectil_normal.tscn")
@onready var anim = $AnimationPlayer
var can_shoot = true


func shoot():
	var disparo = projectil.instantiate()
	disparo.target = target
	disparo.damage = damage
	disparo.type = type
	add_child(disparo)
	can_shoot = false
	$shootTimer.start()
	anim.play("shoot")
	

	# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$DetectionArea.connect("area_entered", enemyIn)
	#$DetectionArea.connect("area_exited", enemyOut)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if enemies_in_range.size() > 0:
		target = enemies_in_range[0]
	
	if target and can_shoot: shoot()

func _on_DetectionArea_area_exited(area):
	if area.is_in_group("enemies"):
		enemies_in_range.erase(area)
		if target == area:
			if enemies_in_range:
				target = enemies_in_range[0]
			else : target = null

func _on_shoot_timer_timeout():
	can_shoot = true


func _on_detection_area_entered(area):
	if area.is_in_group("enemies"):
		enemies_in_range.append(area)
