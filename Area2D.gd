extends Area2D

var tilemap
# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_node("../SecretArea")

func _on_body_entered(body):
	if body.name == "samurai":
		var tween = get_tree().create_tween()
		tween.tween_property(tilemap, "modulate", Color(1,1,1,0), 0.2)


func _on_body_exited(body):
	if body.name == "samurai":
		var tween = get_tree().create_tween()
		tween.tween_property(tilemap, "modulate", Color(1,1,1,1), 0.2)
