extends Area2D
class_name web
var speed = 5
var velocity = Vector2()
var der = 1
var player


func _physics_process(delta):
	velocity.x = der * speed 
	
	
	
	translate(velocity)


func _on_body_entered(body):
	if !body.is_in_group("enemy"):
		queue_free()
		
