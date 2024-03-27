extends RigidBody2D


var SPEED = 10
var direction = 1
var velocity = Vector2()
var chasing_right = false
var chasing_left = false
var rng = RandomNumberGenerator.new()
var emotion = 1
var my_random_number
var not_right = false
var not_left = false
var not_stand = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		#if 
	if chasing_right:
		velocity.x = move_toward(velocity.x, 2, SPEED)
	if chasing_left:
		velocity.x = move_toward(velocity.x, -2, SPEED)	
	
	translate(velocity)




func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is attack_uhh:
		queue_free()


func _on_random_generator_timeout():
	print("why")
	var emotion = rng.randi_range(1, 2)
	if emotion == 1 and !chasing_right and !chasing_left:
		velocity.x = move_toward(velocity.x, 1, SPEED)
	if emotion == 2 and !chasing_right and !chasing_left:
		velocity.x = move_toward(velocity.x, -1, SPEED)
	if emotion == 3 and !chasing_right and !chasing_left:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	print(emotion)
	$random_generator.start()


func _on_left_area_body_entered(body):
	if body is CharacterBody2D:
		chasing_left = true


func _on_right_area_body_entered(body):
	if body is CharacterBody2D:
		chasing_right = true


func _on_left_area_body_exited(body):
	if body is CharacterBody2D:
		chasing_left = false


func _on_right_area_body_exited(body):
	if body is CharacterBody2D:
		chasing_right = false
		

