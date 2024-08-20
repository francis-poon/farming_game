class_name Crop extends TextureRect

enum Genetics {
	G,
	X
}

var growth_stage
var genes: Array[Genetics]
var animation_frames
var crop_data: CropData

# Called when the node enters the scene tree for the first time.
func _ready():
	growth_stage = 0
	texture.resource_local_to_scene = true
	$GrowthTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func start():
	pass
	
func _on_growth_timer_timeout():
	if growth_stage + 1 < animation_frames.size():
		growth_stage += 1
		self.texture.region.position.x = animation_frames[growth_stage] * self.texture.region.size.x
	else:
		$GrowthTimer.stop()
		

static func crossbreed(crossbreed_genes: Array[Crop]):
	var gene_counter: Array[Dictionary] = []
	gene_counter.resize(crossbreed_genes[0].genes.size())
	for i in gene_counter.size():
		gene_counter[i] = {}
	for crop in crossbreed_genes:
		for gene_index in crop.genes.size():
			var gene = crop.genes[gene_index]
			if not gene_counter[gene_index].has(gene):
				gene_counter[gene_index][gene] = 1
			else:
				gene_counter[gene_index][gene] += 1
				
	print(gene_counter)
			
	var max_genes = []
	max_genes.resize(gene_counter.size())
	for i in gene_counter.size():
		var gene_dict: Dictionary = gene_counter[i]
		var max_gene_weight = 0
		var max_gene = Genetics.G
		for gene in gene_dict.keys():
			if gene_dict[gene] > max_gene_weight:
				max_gene_weight = gene_dict[gene]
				max_gene = gene
		max_genes[i] = max_gene
		
	var crop_data: CropData = crossbreed_genes[0].crop_data.duplicate()
	crop_data.genes = "".join(max_genes.map(func(elem): return Genetics.find_key(elem)))
	return crop_data
			
	
func harvest() -> Array[CropData]:
	if growth_stage + 1 >= animation_frames.size():
		return [crop_data, crop_data]
	return [crop_data]
	
func load_from_resource(data: CropData):
	crop_data = data.duplicate()
	$GrowthTimer.wait_time = crop_data.growth_timer
	if crop_data.genes == "":
		genes = random_genes()
		crop_data.genes = "".join(genes)
	else:
		genes = load_genes_from_string(crop_data.genes)
	#genes = random_genes()
	crop_data.genes = "".join(genes.map(func(elem): return Genetics.find_key(elem)))
	animation_frames = load_animation_frames(crop_data.crop_animation_frames)
	self.texture = crop_data.crop_texture.duplicate()
	self.texture.resource_local_to_scene = true
	self.texture.region.position.x = animation_frames[0] * self.texture.region.size.x
	
	
	
func random_genes() -> Array[Genetics]:
	var generated_genes: Array[Genetics] = []
	generated_genes.resize(6)
	for i in generated_genes.size():
		generated_genes[i] = Genetics.get(Genetics.keys()[randi_range(0, Genetics.size()-1)])
	return generated_genes
	
func load_genes_from_string(string_data: String) -> Array[Genetics]:
	var generated_genes: Array[Genetics] = []
	generated_genes.resize(string_data.length())
	for i in string_data.length():
		if Genetics.has(string_data[i]):
			generated_genes[i] = Genetics.get(string_data[i])
		else:
			generated_genes[i] = Genetics.X
	return generated_genes
	
func load_animation_frames(data: Array[int]):
	match data.size():
		0:
			return range(0,0)
		1:
			return range(0, data[0])
		2:
			return range(data[0], data[1])
		_:
			return range(data[0], data[1], data[2])
