extends Area2D

signal enemy_died

@export var speed = 300

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	queue_free()
	enemy_died.emit()


#func _on_area_entered(area):
#	die()


func _on_body_entered(body):
	body.take_damage()
	die()

