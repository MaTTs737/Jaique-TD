extends ProgressBar

func _ready():
	min_value = 0
	max_value = 20
	show_percentage = false

func _process(delta: float) -> void:
	$waveCount.text = str(get_tree().current_scene.wave)+" / 20"
