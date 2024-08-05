extends VideoStreamPlayer

var loseScreen = preload("res://Sistema/pantallaDerrota.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_finished():
	get_tree().paused=true
	var derrota = loseScreen.instantiate()
	add_child(derrota)
	#get_tree().change_scene_to_file("res://Sistema/menuPrincipal.tscn")
