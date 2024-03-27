extends Area2D

var SPEED = 100
var direction = 1
var velocity = Vector2()
var chasing = false
@onready var animated = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animated.play("default")
	if chasing:
		velocity.x = delta * direction * SPEED
	if direction == -1:
		animated.flip_h = false
	if direction == 1:
		animated.flip_h = true
	if !chasing:
		direction = 0
	
	translate(velocity)


func _on_chasing_direction_body_entered(body):
	direction = 1
	chasing = true


func _on_chasing_direction_2_body_entered(body):
	direction = -1
	chasing = true


func _on_chasing_direction_body_exited(body):
	chasing = false


func _on_chasing_direction_2_body_exited(body):
	chasing = false


func _on_area_entered(area):
	if area is attack_uhh:
		queue_free()
