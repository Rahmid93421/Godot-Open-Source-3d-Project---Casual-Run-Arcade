extends Spatial

func _ready():
	get_node("AnimationPlayer").play("CoinAnim");
