extends Spatial

onready var initPos = translation;
var dist = {"left": 0.05, "right": -0.05};
var commandButton = null;

func _process(_delta):
	if(commandButton == "left"):
		if(translation.x <= initPos.x + dist["left"]):
			translation.x += dist["left"];
	else:
		if(commandButton == "right"):
			if(translation.x >= initPos.x + dist["right"]):
				translation.x += dist["right"];
	
	commandButton = null;

func _on_Button_pressed():
#	translation.x += 1.3;
	commandButton = "left";

func _on_Button2_pressed():
#	translation.x -= 1.3;
	commandButton = "right";
