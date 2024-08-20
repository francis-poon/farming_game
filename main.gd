extends Node2D

@export var crop: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_farm_patch_harvest_farm_land(farm_land):
	if farm_land.has_node("Crop"):
		var harvest_crop = farm_land.get_node("Crop")
		%Inventory.add_items(harvest_crop.harvest())
		farm_land.get_node("Crop").queue_free()

func _on_farm_patch_plant_farm_land(farm_land):
	if %Inventory.has_crop():
		var crop_data = %Inventory.remove_crop()
		var new_crop = crop.instantiate()
		new_crop.load_from_resource(crop_data)
		farm_land.add_child(new_crop)
		new_crop.start()
