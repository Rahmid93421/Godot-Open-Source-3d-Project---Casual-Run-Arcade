extends Panel

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if(int(get_node("Value - Label").text) < 5):
		get_node("AnimationPlayer").play("heart");
	else:
		get_node("AnimationPlayer").stop();
