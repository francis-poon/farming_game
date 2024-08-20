extends GridContainer

signal plant_farm_land(farm_land)
signal harvest_farm_land(farm_land)

# Called when the node enters the scene tree for the first time.
func _ready():
	for farm_land in get_tree().get_nodes_in_group("farmland"):
		farm_land.harvest.connect(_on_harvest)
		farm_land.plant.connect(_on_plant)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_harvest(farm_land):
	harvest_farm_land.emit(farm_land)
	
func _on_plant(farm_land):
	plant_farm_land.emit(farm_land)
