extends Area2D


var used = false
var platform
var inside = false
var animatedSprite
var sound 
# Called when the node enters the scene tree for the first time.
func _ready():
	#sound = get_node("sound")
	#print(sound)
	platform = get_parent().platform
	animatedSprite = get_node("AnimatedLawer")
	animatedSprite.play("default")
	#print(animatedSprite)
	#print(platform)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inside:
		if !used:
			if Input.is_action_just_pressed("interact"):
				animatedSprite.play("activate")
				await get_tree().create_timer(0.5).timeout
				animatedSprite.play("activated")
				#print("why not")
				platform.moving = true
				used = true
				#sound.play()


func _on_body_entered(body):
	if body.is_in_group("player"):
		#print("oh, yes")
		inside = true



func _on_body_exited(body):
	if body.is_in_group("player"):
		#print("bad guy")
		inside = false
