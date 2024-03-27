extends Node


var curent_checkpoint: CheckPoint
var player: player

var lives = 3

var lastLevel = "res://level1.tscn"

var panels_list = [false,false,false,false]

func  respawn_player():
	if curent_checkpoint != null:
		if lives == 0:
			get_tree().change_scene_to_file("res://death.tscn")
		else:
			player.position = curent_checkpoint.global_position
		

var doubleJumpEnabled = true
var dashEnabled = true
var shurikenEnabled = true

var coins = 7000



