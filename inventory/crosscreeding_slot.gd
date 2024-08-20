class_name CrossbreedingSlot extends PanelContainer

func init(cms: Vector2) -> void:
	custom_minimum_size = cms

func _can_drop_data(at_position, data):
	if data is InventoryItem and data.data.genes != "":
		return true
	return false
	
	
func _drop_data(at_position, data):
	if get_child_count() > 0:
		var item := get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())
	data.reparent(self)
