extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_area_body_entered(body):
	pass # Replace with function body.


func _on_area_entered(area):
	if area.get_parent() is player:
		area.get_parent().hurt(15)
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(0.1).timeout
		$CollisionShape2D.set_deferred("disabled", false)
