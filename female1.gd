extends Panel

func _ready():
	if(get_parent().get_parent().get_parent().get_parent().characterUnlocked["female1"]):
		get_node("Panel").visible = false;
		get_node("Panel2").visible = false;
		get_node("Panel3").visible = true;
		get_node("m1su").show_behind_parent = false;

func _on_Buy_mouse_entered():
	get_parent().get_parent().get_node("Panel4/TextAd").bbcode_text = "[center]ARE YOU SURE THAT YOU WANT TO UNLOCK [u][color=red]'SHADOW'[/color][/u] SKIN for 8000 points?[/center]"
	get_parent().get_parent().get_node("Panel4/AnimationPlayer").play("PanelOut");
	get_parent().get_parent().get_parent().currentCharacter = "female1";

func _on_select_mouse_entered():
	get_node("Panel3/RichTextLabel").bbcode_text = "[center]SELECTED[/center]";
	get_parent().get_parent().get_parent().get_parent().infoDict["skin"] = "female1";
	get_parent().get_parent().get_parent().get_parent().infoDict["skinGender"] = 1;

func _on_select_mouse_exited():
	get_node("Panel3/RichTextLabel").bbcode_text = "[center]SELECT[/center]";
