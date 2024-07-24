extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Recibe senial del enemy y modifica la animation que muestra

func freeze():
	animation = "frozen"	
func back_to_normal():
	animation = "idle"
func special():
	animation = "special"


func _on_enemy_class_back_to_normal():
	back_to_normal()

func _on_enemy_class_freeze():
	freeze() # Replace with function body.

func _on_enemy_class_special_s():
	special() # Replace with function body.
