extends TextureButton

var cost = 0
var type = ""
var coins = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	type = "normal"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_cost_coins()
	print (cost)
	if coins < cost:
		disabled=true
	

func update_cost_coins():
	coins = get_tree().current_scene.coins
	cost = get_tree().current_scene.towerCost[type]
