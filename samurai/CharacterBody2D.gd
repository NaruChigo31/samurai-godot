extends CharacterBody2D

class_name  player
signal  helthChange

var SPEED = 100.0
const JUMP_VELOCITY = -300.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_player
var particles_right
var particles_left
var run_particles
var run_index = 0
var attack_flag = false
var two_jump = 0

var runSound
var swordEnemySound
var swordAirSound
var dashTimer
var dash_flag
var is_running = false

var shuriken = preload("res://samurai/shuriken.tscn")
var shuriken_flag
var shurikenLeft
var shurikenRight

var enemyAttacked = false

var dialog_flag = false

@export var maxHealth = 100
@onready var currentHealth : int = maxHealth


@export var tilemap : TileMap


var directionText : String = "right"

func hurt(damage):
	currentHealth -= damage
	if currentHealth <= 0:
		die()
		currentHealth = 100
	helthChange.emit()
	

func die():
	Gamestatus.lives -= 1
	Gamestatus.respawn_player()
	

func  _ready():
	helthChange.emit()
	
	animation_player = get_node("AnimationPlayer")
	
	shurikenLeft = get_node("shuriken_left")
	shurikenRight = get_node("shuriken_right")
	
	particles_right = get_node("particles right")
	particles_left = get_node("particles left")
	
	dashTimer = get_node("DashTimer")
	
	runSound = get_node("run")
	swordAirSound = get_node("swordAir")
	swordEnemySound = get_node("swordEnemy")
	
	run_particles = [particles_left, particles_right]
	
	Gamestatus.player = self
		
func _physics_process(delta):
	
	if !is_running:
		runSound.stop()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")


	if direction == -1:
		directionText = "left"
		run_index = 0
	if direction == 1:
		directionText = "right"
		run_index = 1
	#if direction == 0:
		#is_running = false
	#if is_running:
		#runSound.play()

	
	if is_on_floor():
		#if !Gamestatus.doubleJumpEnabled:
			#two_jump = 2
		#if Gamestatus.doubleJumpEnabled:
		two_jump = 0
		
	if direction and attack_flag == false:
		velocity.x = direction * SPEED
		if is_on_floor():
			animation_player.play("run "+directionText)
			run_particles[run_index].emitting = true
			is_running = true
			
	else:
		is_running = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		run_particles[run_index].emitting = false
		
		if is_on_floor()  and attack_flag == false:
			if dash_flag:
				animation_player.play("dash "+directionText)
			if shuriken_flag:
				animation_player.play("shuriken "+directionText)
			else:
				animation_player.play("idle "+directionText)
				is_running = false
	
	
	
	if is_on_floor(): 
		if Input.is_action_pressed("ui_right"):
			is_running = true
	if !is_on_floor():
		is_running = false
			
	if Input.is_action_just_pressed("ui_right"):
		if is_running:
			runSound.play()
		directionText = "right"
		direction = 1
		#await get_tree().create_timer(0.2).timeout
		#runSound.stop()
	#if !Input.is_action_just_pressed("ui_right"):
		#runSound.stop()
	if Input.is_action_pressed("ui_left"):
		if is_on_floor(): 
			is_running = true
	if Input.is_action_just_pressed("ui_left"):
		if is_running:
			runSound.play()
		direction = -1
		directionText = "left"
		#await get_tree().create_timer(0.2).timeout
		#runSound.stop()
		
	if Input.is_action_just_pressed("jump") and two_jump < 2  and attack_flag == false:
		if !Gamestatus.doubleJumpEnabled:
			two_jump = 2
		if Gamestatus.doubleJumpEnabled:
			two_jump = two_jump + 1
		velocity.y = JUMP_VELOCITY
		animation_player.play("airChange "+directionText)
		run_particles[run_index].emitting = false
		
	if Input.is_action_just_pressed("attack1"):
		attack_flag = true
		#if is_on_floor():
		animation_player.play('attack1 '+directionText)
		if enemyAttacked:
			swordEnemySound.play()
		if !enemyAttacked:
			swordAirSound.play()
		velocity.x = 0
		#velocity.y = 0
		run_particles[run_index].emitting = false
		
	if  Input.is_action_just_pressed("dash") and !attack_flag and currentHealth > 0:
		#dashTimer.start()
		if Gamestatus.dashEnabled:
			dash_flag = true
			animation_player.play('dash '+directionText)
			if directionText == "right":
				velocity.x = move_toward(velocity.x, 1500, 1500)
			if directionText == "left":
				velocity.x = move_toward(velocity.x, -1500, 1500)
			await get_tree().create_timer(0.6).timeout
			dash_flag = false
		
	if Input.is_action_just_pressed("shuriken") and !attack_flag and currentHealth > 0:
		if Gamestatus.shurikenEnabled:
			velocity.x = 0
			shuriken_flag = true
			animation_player.play('shuriken '+directionText)
			if directionText == "right":
				shurikenRight.position.x = abs(shurikenRight.position.x)
				var shur = shuriken.instantiate()
				shur.der = 1
				shur.position = shurikenRight.global_position
				await get_tree().create_timer(0.48).timeout
				get_parent().add_child(shur)
			if directionText == "left":
				shurikenLeft.position.x = abs(shurikenLeft.position.x)
				var shur = shuriken.instantiate()
				shur.der = -1
				shur.position = shurikenLeft.global_position
				await get_tree().create_timer(0.48).timeout
				get_parent().add_child(shur)
			await get_tree().create_timer(0.32).timeout
			shuriken_flag = false
		

	move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'attack1 left' or anim_name == 'attack1 right':
		attack_flag = false
	if anim_name == 'shuriken left' or anim_name == 'shuriken right':
		shuriken_flag = false
		
#var dialog_res = ''
#var dialog_start = ''
#


#func _on_dialog_triger_area_entered(area):
	#print('dindin')
	#if area.get_parent() is dialog:
		#dialog_flag = true
		#print('dindin')
#
#
#func _on_dialog_triger_area_exited(area):
	#if area.get_parent() is dialog:
		#dialog_flag = false
		#print('тындын')


func _on_dash_timer_timeout():
	dash_flag = false


func _on_area_2d_area_entered(area):
	if area is web:
		if SPEED > 0:
			SPEED = SPEED / 2
		$WebTimer.start()

func _on_web_timer_timeout():
	SPEED = 100


func _on_attack_area_left_body_entered(body):
	if directionText == "left":
		if body.is_in_group("enemy"):
			print("enemy left",body)
	
			if attack_flag:
				enemyAttacked = true
			print("attacked left",enemyAttacked)
		else:
			enemyAttacked = false


func _on_attack_area_right_body_entered(body):
	if directionText == "right":
		if body.is_in_group("enemy"):
			print("enemy right",body)
	
			if attack_flag:
				enemyAttacked = true
			print("attacked right",enemyAttacked)
		else:
			enemyAttacked = false
