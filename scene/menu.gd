extends CanvasLayer


# Called when the node enters the scene tree for the first time.
 

func _ready():
	$BoxContainer.hide()
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	$BoxContainer.show()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_exit_pressed():
	get_tree().quit()
