extends VideoStreamPlayer

var loseScreen = preload("res://Sistema/pantallaDerrota.tscn")
var winScreen = preload("res://Sistema/pantallaVictoria.tscn")
func _ready():
	pass 


func _process(delta):
	pass


func _on_finished():
	get_tree().paused=true
	
	var screen = loseScreen.instantiate()
	if (Global.player_won == true):
		screen = winScreen.instantiate()
	else:
		screen = loseScreen.instantiate()
	add_child(screen)
