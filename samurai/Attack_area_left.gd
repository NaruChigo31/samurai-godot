extends Area2D
class_name attack_uhh


var attack_rest = false
var player
var attack_collision
# Called when the node enters the scene tree for the first time.
func _ready():
	attack_collision =  get_node("attack left collision")
	attack_collision.set_deferred("disabled", true)
	player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.directionText == "left":
		if Input.is_action_just_pressed("attack1") and attack_rest == false:
			#print("Ахахаха пизжец")
			attack_collision.set_deferred("disabled", false)
			attack_rest = true
		


func _on_animation_player_animation_finished(anim_name):
	attack_collision.set_deferred("disabled", true)
	attack_rest = false
