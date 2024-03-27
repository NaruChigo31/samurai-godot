extends Area2D


var speed = 1
var velocity = Vector2()
var der = 1
var player
@onready var animation =$AnimatedSprite2D
@onready var collision =$CollisionShape2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if der == 1:
		animation.flip_h = false
		collision.scale.x = 1
	if der == -1:
		animation.flip_h = true
		collision.scale.x = -1
	velocity.x = der * speed 

	translate(velocity)



func _on_body_entered(body):
	if !body.is_in_group("player"):
		queue_free()
