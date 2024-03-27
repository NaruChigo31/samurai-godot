extends Path2D


# Called when the node enters the scene tree for the first time.

@export var loop = true
@export var speed = 0.2
@export var speed_scale = 1
@export var moving = true
var sound

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer


func _ready():
	sound = get_node("sound")
	print(sound)
	#sound.stop()
	if not loop:
		animation.play('move')
		sound.play()
		animation.speed_scale = speed_scale
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		#sound.play()
		path.progress += speed
	#if !moving:
		#sound.stop()
