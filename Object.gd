extends Spatial

func _on_Area_body_entered(_body):
	get_node("CPUParticles").emitting = true;
	if(get_parent().get_node_or_null("Empty")):
		get_parent().get_parent().get_parent().gameOver = true;
	else:
		get_parent().get_parent().get_parent().get_parent().gameOver = true;
