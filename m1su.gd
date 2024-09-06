extends Panel

func _ready():
	if(get_parent().get_parent().get_parent().get_parent().characterUnlocked["m1su"]):
		get_node("Panel").visible = false;
		get_node("Panel2").visible = false;
		get_node("Panel3").visible = true;
		get_node("m1su").show_behind_parent = false;
