extends ProgressBar

func _ready():
	min_value = 0
	max_value = 20
	show_percentage = false

func update(wave:int):
	$waveCount.text = str(wave)+" / 20"
	value=wave
