extends Area2D
class_name CheckPoint

@export var spawnpoin = false
var activate = false
@onready var shop = get_node("Shop")

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(shop, "modulate", Color(1,1,1,0), 0.2)


func activateCheckPoint():
	Gamestatus.curent_checkpoint = self
	activate = true

func _on_area_entered(area):
	if area.get_parent() is player :
		activateCheckPoint()
		var tween = get_tree().create_tween()
		tween.tween_property(shop, "modulate", Color(1,1,1,1), 0.2)
		
func _on_area_exited(area):
	if area.get_parent() is player:
		activateCheckPoint()
		var tween = get_tree().create_tween()
		tween.tween_property(shop, "modulate", Color(1,1,1,0), 0.2)



func _on_shuriken_pressed():
	if !Gamestatus.shurikenEnabled:
		if Gamestatus.coins >= 2000:
			Gamestatus.shurikenEnabled = true
			Gamestatus.coins -= 2000



func _on_dash_pressed():
	if !Gamestatus.dashEnabled:
		if Gamestatus.coins >= 1500:
			Gamestatus.dashEnabled = true
			Gamestatus.coins -= 1500


func _on_double_pressed():
	if !Gamestatus.doubleJumpEnabled:
		if Gamestatus.coins >= 1000:
			Gamestatus.doubleJumpEnabled = true
			Gamestatus.coins -= 1000


