extends Area2D

var sound
var random = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	sound = get_node("sound")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		Gamestatus.coins += random.randi_range(50,80)
		sound.play()
		await get_tree().create_timer(0.2).timeout
		
		queue_free()
