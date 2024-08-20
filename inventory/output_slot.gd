class_name OutputSlot extends PanelContainer

func init(cms: Vector2) -> void:
	custom_minimum_size = cms

func _can_drop_data(at_position, data):
	return false
	
	
func _drop_data(at_position, data):
	return
