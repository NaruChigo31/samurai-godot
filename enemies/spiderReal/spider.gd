extends RigidBody2D

var velocity = Vector2()
var direction = 1
var DAMAGE = 5
var SPEED = 1.5
var emotion = 1
var death = false
var FIRE = preload("res://enemies/spiderReal/web.tscn")
var SOULCOIN = preload("res://soul_coin.tscn")
@onready var Animated_sprite = $AnimatedSprite2D
@onready var CollissionPolygon = $CollisionPolygon2D
var rng = RandomNumberGenerator.new()
var web = false
var walk = false
var attack = false
var death_count = 0

var exitAttackRight
var exitAttackLeft

var busyLeft
var busyRight

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_pressed("check"):
		print("busyLeft",busyLeft)
		print("busyRight",busyRight)
		print("attack",attack)
		print("web",web)
	
	if direction == 1:
		Animated_sprite.flip_h = false
		CollissionPolygon.scale.x = 1
		
	if direction == -1:
		Animated_sprite.flip_h = true
		CollissionPolygon.scale.x = -1



	velocity.x = direction * SPEED
	if !busyLeft and !busyRight and !attack and !web and !death:
		if walk:
			Animated_sprite.play("run")
		else:
			Animated_sprite.play("idle")
			
		if emotion == 1:
			walk = true
			direction = 1
			velocity.x = direction * SPEED
		elif emotion == 2:
			walk = true
			direction = -1
			velocity.x = direction * SPEED
		elif emotion == 3:
			walk = false
			direction = 0
			velocity.x = direction * SPEED
	elif web:
		walk = false
		#Animated_sprite.play("web")
	elif attack:
		walk = false


	if death:
		busyLeft = false
		busyRight = false
		attack = false
		walk = false
		web = false
		exitAttackRight = true
		exitAttackLeft = true
		direction = 0
		Animated_sprite.play("death")
		await get_tree().create_timer(0.7).timeout
		var soul = SOULCOIN.instantiate()
		soul.position = position
		var soul2 = SOULCOIN.instantiate()
		soul2.position.x = position.x + 16
		soul2.position.y = position.y
		get_parent().add_child(soul)
		get_parent().add_child(soul2)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		queue_free()

	translate(velocity)


func _on_left_body_entered(body):
	if body.is_in_group("player"):
		direction = -1
		busyLeft = true
		while busyLeft == true:
			web = true
			direction = 0
			walk = false
			$FirePosLeft.position.x = abs($FirePosLeft.position.x)*-1
			#Animated_sprite.play("web")
			await get_tree().create_timer(0.3).timeout
			var fire = FIRE.instantiate()
			fire.der = -1
			fire.position = $FirePosLeft.global_position
			get_parent().add_child(fire)
			web = false
			direction = -1
			walk = true
			Animated_sprite.play("run")
			await get_tree().create_timer(0.8).timeout

func _on_right_body_entered(body):
	if body.is_in_group("player"):
		direction = 1
		busyRight = true
		while busyRight == true:
			web = true
			direction = 0
			walk = false
			$FirePosRight.position.x = abs($FirePosRight.position.x)
			#Animated_sprite.play("web")
			await get_tree().create_timer(0.3).timeout
			var fire = FIRE.instantiate()
			fire.der = 1
			fire.position = $FirePosRight.global_position
			get_parent().add_child(fire)
			web = false
			direction = 1
			walk = true
			Animated_sprite.play("run")
			await get_tree().create_timer(0.8).timeout



func _on_left_body_exited(body):
	if body.is_in_group("player"):
		busyLeft = false

func _on_right_body_exited(body):
	if body.is_in_group("player"):
		busyRight = false




func _on_random_generator_timeout():
	emotion = rng.randi_range(1,3)



func _on_area_2d_area_entered(area):
	if area is attack_uhh and !death or area is attack_uhh_right and !death or area.is_in_group("shuriken") and !death:
		if death_count == 5:
			death = true
		death_count+=1
		


func _on_attack_right_body_entered(body):
	if body.is_in_group("player"):
		print("tururur")
		direction = 1
		exitAttackRight = false
		while exitAttackRight == false:
			direction = 0
			attack = true
			web = false
			busyRight = false
			Animated_sprite.play("attack")
			await get_tree().create_timer(0.8).timeout
			body.hurt(DAMAGE)


func _on_attack_left_body_entered(body):
	if body.is_in_group("player"):
		print("lyalyalya")
		direction = -1
		exitAttackLeft = false
		while exitAttackLeft == false:
			direction = 0
			Animated_sprite.flip_h = true
			attack = true
			web = false
			busyLeft = false
			Animated_sprite.play("attack")
			await get_tree().create_timer(0.8).timeout
			body.hurt(DAMAGE)



func _on_attack_right_body_exited(body):
	if body.is_in_group("player"):
		exitAttackRight = true
		attack = false
		#web = true
		walk = true
func _on_attack_left_body_exited(body):
	if body.is_in_group("player"):
		exitAttackLeft = true
		attack = false
		#web = true
		walk = true





