extends Node2D

@onready var pathfollow = $PathFollow2D
@onready var enemy2 = $PathFollow2D/Enemy2

func _ready():
	pathfollow.set_progress_ratio(1)
	
func _process(delta):
	pathfollow.progress_ratio -= 0.25 * delta
	if pathfollow.progress_ratio <= 0:
		queue_free()
