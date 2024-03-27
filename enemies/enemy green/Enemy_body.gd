extends RigidBody2D

var DAMAGE = 2.5
var SPEED = 100
var direction = 1
var velocity = Vector2()
var chasing_right = false
var chasing_left = false
var rng = RandomNumberGenerator.new()
var emotion = 1
var exitLeft = true
var exitRight = true
var death_count = 0

var SOULCOIN = preload("res://soul_coin.tscn")

var attack = false
var death = false
@onready var Animated_sprite = $AnimatedSprite2D

func _ready():
	var others =  get_tree().get_nodes_in_group("enemy")
	for i in others:
		add_collision_exception_with(i)

func _physics_process(delta):
	if !chasing_right and !chasing_left and !attack and !death:
		if direction == 1:
			Animated_sprite.flip_h = false
			Animated_sprite.play("Run")
			velocity.x = delta * direction * SPEED
		elif direction == -1:
			Animated_sprite.flip_h = true
			Animated_sprite.play("Run")
			velocity.x = delta * direction * SPEED
		elif  direction == 0:
			Animated_sprite.play("idle")
			velocity.x = delta * direction * SPEED
	if death == true:
		exitRight = true
		exitLeft = true
		await get_tree().create_timer(0.8).timeout
		queue_free()
	if attack:
		SPEED = 0
	if !attack:
		SPEED = 100
	translate(velocity)


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is attack_uhh and !death or area is attack_uhh_right and !death or area.is_in_group("shuriken") and !death:
		if death_count == 3:
			Animated_sprite.play("death")
			var soul = SOULCOIN.instantiate()
			soul.position = position
			get_parent().add_child(soul)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			death = true
		death_count+=1
		print(death_count)


func _on_random_generator_timeout():
	if !chasing_right and !chasing_left and !attack:
		var emotion = rng.randi_range(1, 3)
		if emotion == 1:
			Animated_sprite.flip_h = false
			Animated_sprite.play("Run")
			direction = 1
		if emotion == 2:
			Animated_sprite.flip_h = true
			Animated_sprite.play("Run")
			direction = -1
		if emotion == 3:
			Animated_sprite.play("idle")
			direction = 0
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
		
		


func _on_attack_right_body_entered(body):
	exitRight = false
	if body.is_in_group("player"):
		while exitRight == false:
			direction = 0
			emotion = 3
			attack = true
			chasing_right = false
			Animated_sprite.play("Attack")
			await get_tree().create_timer(0.8).timeout
			body.hurt(DAMAGE)

func _on_attack_left_body_entered(body):
	exitLeft = false
	if body is CharacterBody2D:
		while exitLeft == false:
			direction = 0
			emotion = 3
			Animated_sprite.flip_h = true
			attack = true
			chasing_left = false
			Animated_sprite.play("Attack")
			await get_tree().create_timer(0.8).timeout
			body.hurt(DAMAGE)


func _on_attack_right_body_exited(body):
	exitRight = true
	attack = false
	#emotion = 1

func _on_attack_left_body_exited(body):
	exitLeft = true
	attack = false
	#emotion = 2

#func _on_animated_sprite_2d_animation_finished():
	#attack = false
