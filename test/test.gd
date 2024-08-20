extends Node

enum MyEnum {
	A=1, B=3, C=5
}

var crop_scene: PackedScene = load("res://farming/crop.tscn")
var test_crop = load("res://resource_items/test_crop.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	var crop: Crop = crop_scene.instantiate()
	crop.load_from_resource(test_crop)
	Crop.crossbreed([crop])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print(MyEnum.keys()[randi_range(0, MyEnum.size()-1)])
