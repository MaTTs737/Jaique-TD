extends Area2D

var damage = 500
var type = "bomb"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("explosion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_animation_player_animation_finished(anim_name):
	queue_free()
