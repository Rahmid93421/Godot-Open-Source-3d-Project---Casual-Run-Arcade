extends ColorRect

func _ready():
	get_parent().get_node("AnimationPlayer").play("Gradient");
