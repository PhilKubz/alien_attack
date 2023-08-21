extends Node2D

var lives = 3
var score = 0

var gameover_scene = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()

func _on_player_damage_taken():
	lives -= 1
	hud.set_lives(lives)
	player_hit_sound.play()
	if lives == 0:
		player.die()
		
		await get_tree().create_timer(.5).timeout
		
		var gameover = gameover_scene.instantiate()
		gameover.set_score(score)
		ui.add_child(gameover)
		

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("enemy_died", on_enemy_died)
	add_child(enemy_instance)
	
func on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()

func on_special_enemy_died():
	score += 200
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned_01(path_enemy_instance_01):
	add_child(path_enemy_instance_01)
	path_enemy_instance_01.enemy1.connect("enemy_died", on_special_enemy_died)


func _on_enemy_spawner_path_enemy_spawned_02(path_enemy_instance_02):
	add_child(path_enemy_instance_02)
	path_enemy_instance_02.enemy2.connect("enemy_died", on_special_enemy_died)
