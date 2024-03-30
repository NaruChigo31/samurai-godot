extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	var level = Gamestatus.lastLevel
	print(level)
	get_tree().change_scene_to_file(level)


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scene/menu.tscn")


func _on_restart_button_down():
	var level = Gamestatus.lastLevel
	print(level)
	get_tree().change_scene_to_file(level)
