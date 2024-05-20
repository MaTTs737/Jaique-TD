extends Node

var damage : int = 1
var type : String
var waitingTime : int = 3
var range : int
var target : Object
var enemies_in_range = []
var enemyIn = Callable(self,"_on_DetectionArea_body_entered")
var enemyOut = Callable(self,"_on_DetectionArea_body_exited")
var projectil = preload("res://Torres/Projectiles/projectilClass.tscn")
var animationShoot

func shoot():
	if enemies_in_range.size() > 0:
		target = enemies_in_range[0]
		var disparo = projectil.instance()
		disparo.target = target
		disparo.type = type	
		self.add_child(disparo)
		$shootTimer.start(waitingTime)
		$AnimationPlayer.play(animationShoot)

	# Called when the node enters the scene tree for the first time.
func _ready():
	$shootTimer.wait_time=waitingTime
	$DetectionArea.connect("body_entered", enemyIn)
	$DetectionArea.connect("body_exited", enemyOut)

func _on_DetectionArea_body_entered(body):
	if body.is_in_group("enemies"):
		enemies_in_range.append(body)

func _on_DetectionArea_body_exited(body):
	if body.is_in_group("enemies"):
		enemies_in_range.erase(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_shoot_timer_timeout():
	if target:
		shoot()
