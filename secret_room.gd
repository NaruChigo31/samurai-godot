extends TileMap

var tilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_node("SecretArea")

