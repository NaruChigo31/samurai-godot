extends Node


# Called when the node enters the scene tree for the first time.
@export var scene : String
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_entered(area):
	if area.get_parent() is player:
		Gamestatus.lastLevel = scene
		Gamestatus.lives = 3
		get_tree().change_scene_to_file(scene)


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
