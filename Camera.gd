extends Camera

onready var initPos = 0;
var dist = {"left": 1.35, "right": -1.35};
var commandButton = null;

func _process(_delta):
	if(Input.is_action_just_pressed("wup")):
		commandButton = "left";
	if(Input.is_action_just_pressed("sdown")):
		commandButton = "right";
	
	if(get_parent().get_parent().get_parent().stopGame == false):
		if(get_parent().get_node("maleNewRun").visible):
			get_parent().get_node("maleNewRun/AnimationPlayer").get_animation("Armature|mixamocom|Layer0").loop = true;
			get_parent().get_node("maleNewRun/AnimationPlayer").play("Armature|mixamocom|Layer0");
		else:
			get_parent().get_node("newFemaleCh/AnimationPlayer").get_animation("Armature|mixamocom|Layer0").loop = true;
			get_parent().get_node("newFemaleCh/AnimationPlayer").play("Armature|mixamocom|Layer0");
		
		if(commandButton == "left"):
			if(get_parent().translation.x <= initPos + dist["left"] - 0.05):
				get_parent().translation.x += dist["left"];
				print(str(initPos) + " " + str(dist["left"]));
				print(str(get_parent().translation.x));
		else:
			if(commandButton == "right"):
				if(get_parent().translation.x >= initPos + dist["right"] + 0.05):
					get_parent().translation.x += dist["right"];
					
		get_parent().get_parent().get_node("Ground").translation.x = get_parent().translation.x;

		commandButton = null;
	else:
		get_parent().get_node("maleNewRun/AnimationPlayer").stop();
		get_parent().get_node("newFemaleCh/AnimationPlayer").stop();

func _on_Button_pressed():
	commandButton = "left";

func _on_Button2_pressed():
	commandButton = "right";
