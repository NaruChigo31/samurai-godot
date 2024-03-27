extends Area2D

@export var tilemap: Node
# Called when the node enters the scene tree for the first time.
#func _ready():
	#tilemap = get_node("false_floor")


func _on_body_entered(body):
	if body.name == "samurai":
		var tween = get_tree().create_tween()
		tween.tween_property(tilemap, "modulate", Color(1,1,1,0), 0.3)
		await get_tree().create_timer(0.3).timeout
		tilemap.queue_free() 
		queue_free()
		
