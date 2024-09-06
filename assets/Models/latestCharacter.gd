extends Spatial

onready var textures = { "m1su": preload("res://assets/Models/textures/M1SUNew.png"),
						 "male1": preload("res://assets/Models/textures/male1.png"),
						 "male2": preload("res://assets/Models/textures/male2.png")
						};

func _ready():
	var material = SpatialMaterial.new();
	material.albedo_texture = textures["m1su"];
	get_node("Armature/Skeleton/characterMedium").set_surface_material(0, material);
