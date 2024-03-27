extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Gamestatus.panels_list[0] && Gamestatus.panels_list[1] && Gamestatus.panels_list[2] && Gamestatus.panels_list[3]:
		position.x += 100
