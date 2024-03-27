extends RigidBody2D

var speed = 100
var velocity = Vector2()
var direction = 1
var chasing_left = false
var chasing_right = false
var walk = false
var death = false
@onready var animation = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chasing_right and !death:
		animation.play("run")
		animation.flip_h = true
		speed = 100
		direction = -1
		velocity.x = delta * direction * speed
		
	if chasing_left and !death:
		animation.play("run")
		animation.flip_h = false
		speed = 100
		direction = 1
		velocity.x = delta * direction * speed
	if !chasing_left:
		animation.play("idle")
		speed = 0
	if !chasing_left:
		animation.play("idle")
		speed = 0
	if death:
		await get_tree().create_timer(1).timeout
		queue_free()
	move_and_collide(velocity)


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		chasing_right = true



func _on_area_2d_2_body_entered(body):
	if body is CharacterBody2D:
		chasing_left = true



func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		chasing_right= false

func _on_area_2d_2_body_exited(body):
	if body is CharacterBody2D:
		chasing_left = false


func _on_area_2d_3_area_entered(area):
	if area is attack_uhh and !death:
		animation.play("death")
		death = true
