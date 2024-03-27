extends Node2D

const DAMAGE = 5
var SOULCOIN = preload("res://soul_coin.tscn")

var attack = false
var closed = true
var alive = true
var AnimatedSprite

var entered = false

var attack_exited
var death_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	AnimatedSprite = get_node("AnimatedSprite2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive:
		if entered:
			if Input.is_action_just_pressed("interact") and closed:
				AnimatedSprite.play("opening")
				await get_tree().create_timer(0.8).timeout
				closed = false
		if closed:
			attack = false
			AnimatedSprite.play("closed")
		if !closed:
			#if attack:
				#AnimatedSprite.play("attack")
			if !attack:
				AnimatedSprite.play("idle")



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		entered = true



#func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	#if area is attack_uhh and !death or area is attack_uhh_right and !death or area.is_in_group("shuriken") and !death:
		#if death_count == 3:
			#Animated_sprite.play("death")
			#var soul = SOULCOIN.instantiate()
			#soul.position = position
			#get_parent().add_child(soul)
			#velocity.x = move_toward(velocity.x, 0, SPEED)
			#death = true
		#death_count+=1
		#print(death_count)


func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		if !closed:
			attack_exited = false
		while attack_exited == false:
			attack = true
			AnimatedSprite.play("attack")
			await get_tree().create_timer(0.8).timeout
			body.hurt(DAMAGE)

func _on_attack_area_body_exited(body):
	if body.is_in_group("player"):
		if !closed:
			attack_exited = true
			attack = false


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is attack_uhh and alive or area is attack_uhh_right and alive or area.is_in_group("shuriken") and alive:
		if death_count == 3:
			#Animated_sprite.play("death")
			var soul = SOULCOIN.instantiate()
			soul.position = position
			
			alive = false
			AnimatedSprite.play("death")
			await get_tree().create_timer(0.4).timeout
			#var tween = get_tree().create_tween()
			#tween.tween_property(chest,"modulate", Color(1,1,1,0), 0.2)
			queue_free()
			
			get_parent().add_child(soul)
			
		death_count+=1
