extends GridContainer

var inv_size = 16
var items_load = [
	"res://resource_items/crop.tres"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in inv_size:
		var slot := InventorySlot.new()
		slot.init(Vector2(64, 64))
		%Inventory.add_child(slot)
		
	for i in items_load.size():
		var item := InventoryItem.new()
		item.init(load(items_load[i]))
		%Inventory.get_child(i).add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func has_crop():
	for i in %Inventory.get_child_count():
		if %Inventory.get_child(i).get_child_count() != 0 and %Inventory.get_child(i).get_child(0) is InventoryItem:
			return true
	print("No crop")
	return false
			
	
func add_items(items: Array[CropData]):
	for i in items.size():
		var item := InventoryItem.new()
		item.init(items[i])
		for j in %Inventory.get_child_count():
			if %Inventory.get_child(j).get_child_count() == 0:
				%Inventory.get_child(j).add_child(item)

func remove_crop():
	for i in %Inventory.get_child_count():
		if %Inventory.get_child(i).get_child_count() != 0:
			var inventory_item = %Inventory.get_child(i).get_child(0)
			%Inventory.get_child(i).remove_child(%Inventory.get_child(i).get_child(0))
			return inventory_item.data
