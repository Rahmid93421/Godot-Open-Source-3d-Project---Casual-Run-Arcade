extends Spatial

func _ready():
	get_node("PointArea/AnimationPlayer").play("PointRotation");

func _on_PointArea_body_entered(_body):
	get_parent().get_parent().get_parent().pointsCurrentSession += 1;
	get_parent().playCoinSound = true;
	self.queue_free();
