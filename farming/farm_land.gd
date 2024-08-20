extends Button

signal plant(farm_land)
signal harvest(farm_land)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		harvest.emit($".")
		print("Harvested " + $".".name)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		plant.emit($".")
		print("Planted " + $".".name)
