extends ColorRect

@export var crop: PackedScene

var input_tracker: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	for input in get_tree().get_nodes_in_group("crossbreeding_input"):
		add_crossbreeding_slot(input)
	
	var slot := OutputSlot.new()
	slot.set_anchors_preset(Control.PRESET_FULL_RECT)
	$Output.add_child(slot)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_crossbreeding_slot(container):
	var slot := CrossbreedingSlot.new()
	slot.set_anchors_preset(Control.PRESET_FULL_RECT)
	slot.child_entered_tree.connect(_on_crop_input_change)
	slot.child_exiting_tree.connect(_on_crop_input_change)
	input_tracker[slot] = false
	container.add_child(slot)

#func _on_crop_input_enter(node: Node):
	#input_tracker[node.get_parent()] = true
	#
	#var input_filled = true
	#for input in input_tracker.values():
		#input_filled = input and input_filled
	#if input_filled:
		#print("Inputs filled")
	#
#func _on_crop_input_exit(node: Node):
	#input_tracker[node.get_parent()] = false
	
func _on_crop_input_change(node: Node):
	var crops: Array[Crop] = []
	for input in get_tree().get_nodes_in_group("crossbreeding_input"):
		if input.get_child(0).get_child_count() != 0:
			var new_crop = crop.instantiate()
			new_crop.load_from_resource(node.data)
			crops.append(new_crop)
			
	if crops.size() > 0:
		var crossbreed_crop_data = Crop.crossbreed(crops)
		print(crossbreed_crop_data.genes)
