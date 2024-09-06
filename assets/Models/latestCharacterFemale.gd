extends Spatial

onready var textures = { "female1": preload("res://assets/Models/textures/female1.png"),
						 "female2": preload("res://assets/Models/textures/female2.png")
						};

func _ready():
	var material = SpatialMaterial.new();
	material.albedo_texture = textures["female2"];
	get_node("Armature/Skeleton/characterMedium").set_surface_material(0, material);
