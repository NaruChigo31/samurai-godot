extends Node2D

var area
# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_node("Area2D")


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var tween = get_tree().create_tween()
		tween.tween_property(area, "modulate", Color(1,1,1,0), 0.2)
		Gamestatus.panels_list[3] = true
