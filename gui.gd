extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	%Inventory.hide()
	%Crossbreeder.hide()
	%FarmPatch.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_action"):
		%Inventory.visible = !%Inventory.visible
		%FarmPatch.visible = !%FarmPatch.visible
		%Crossbreeder.visible = !%Crossbreeder.visible
