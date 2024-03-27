extends Area2D



#func _on_area_entered(body):
	#if area.get_parent() is player:
		#area.get_parent().hurt(100)



func _on_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(100)
