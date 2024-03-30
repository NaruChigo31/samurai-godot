extends Node2D

var entered
var SOULCOIN = preload("res://soul_coin.tscn")
var closed = true
var AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	AnimatedSprite = get_node("AnimatedSprite2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		if Input.is_action_just_pressed("dialogue") and closed:
			AnimatedSprite.play("opening")
			await get_tree().create_timer(0.8).timeout
			closed = false
			var soul = SOULCOIN.instantiate()
			soul.position = position
			var soul2 = SOULCOIN.instantiate()
			soul2.position.x = position.x + 16
			var soul3 = SOULCOIN.instantiate()
			soul3.position.x = position.x - 16
			soul3.position.y = position.y
			get_parent().add_child(soul)
			get_parent().add_child(soul2)
			get_parent().add_child(soul3)
			
	if closed:
		AnimatedSprite.play("closed")
	if !closed:
		AnimatedSprite.play("opened")


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		entered = true
