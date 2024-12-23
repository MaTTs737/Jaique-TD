extends TextureButton

var cost = 0
var type = ""
var coins = 0
var canceled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_cost_coins()
	if !canceled:
		if coins < cost:
			disabled=true
		else :
			disabled = false
	else : disabled = true
	$Label.text = str(cost)

func update_cost_coins():
	coins = get_tree().current_scene.coins
	cost = DifficultySettings.TOWER_COST_DEFAULT[type]
