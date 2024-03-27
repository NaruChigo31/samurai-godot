extends TextureProgressBar

@export var player: player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.helthChange.connect(update)
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = player.currentHealth * 100 / player.maxHealth
