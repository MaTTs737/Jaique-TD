extends Node2D

var movimiento = position.y

func _ready():
	$AnimationPlayer.play("drop")
