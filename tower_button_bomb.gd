extends TextureButton

var cost = 0
var type = ""
var coins = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "bomb"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if coins < cost:
		disabled=true
	update_cost_coins()

func update_cost_coins():
	coins = get_tree().current_scene.coins
	cost = get_tree().current_scene.towerCost[type]
