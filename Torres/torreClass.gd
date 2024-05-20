extends Node

var damage : int = 1
var type : String
var cost : int
var waitingTime : int = 3
var range : int
var target : Object

var enemyInCall = Callable($areaVision,"_on_DetectionArea_body_entered")
var enemyOutCall = Callable($areaVision,"_on_DetectionArea_body_exited")
var priorTargegt : Object

func identifyEnemy(): #elige entre los enemigos que esten en rango uno para usar de target
	var enemy_list=[]

func shoot():
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$shootTimer.wait_time=waitingTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shoot_timer_timeout():
	shoot()
