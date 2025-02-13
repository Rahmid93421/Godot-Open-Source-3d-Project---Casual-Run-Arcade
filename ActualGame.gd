extends Spatial

export onready var roadScene = preload("res://Hit the road Jack.tscn");
export onready var roadSceneEmpty = preload("res://Hit the road Jack - Empty.tscn");

var roadArray = [null, null, null];
var obstaclesArray = [null, null, null];
var roadEmpty = [null, null];
var distRoads = 8;
var indRoad = 0;
var pointsCurrentSession;
var tutorial = true

func _ready():
	print(str(get_parent().infoDict["skinGender"]) + " " + get_parent().infoDict["skin"]);
	
	roadEmpty[0] = roadSceneEmpty.instance();
	roadEmpty[1] = roadSceneEmpty.instance();
	add_child(roadEmpty[0]);
	add_child(roadEmpty[1]);
	roadEmpty[0].translation.z = -8;
	roadEmpty[1].translation.z = 0;
	
	for i in range(0, 3):
		roadArray[i] = roadScene.instance();
		add_child(roadArray[i]);
		roadArray[i].translation.z = distRoads;
		distRoads += 8;
	
	pointsCurrentSession = 0;
	get_node("Control/HighScore - RichTextLabel").bbcode_text = "[center]" + str(pointsCurrentSession) + "[/center]";

func _process(_delta):
	if(get_parent().stopGame == false):
		if(tutorial == true):
			pass
		else:
			if(indRoad == 2 && roadEmpty[1]):
				remove_child(roadEmpty[0]);
				remove_child(roadEmpty[1]);
				
				roadEmpty[0].queue_free();
				roadEmpty[1].queue_free();
				
				roadEmpty[0] = null;
				roadEmpty[1] = null;
			
			if(indRoad > 2):
				indRoad = 0;

			if(roadArray[indRoad].translation.z + 15 < get_node("KinematicBody").translation.z):
				roadArray[indRoad].translation.z = distRoads;
				roadArray[indRoad].get_node("Road#1")._refreshRoad();
				indRoad += 1;
				distRoads += 8;
			
			get_node("Control/HighScore - RichTextLabel").bbcode_text = "[center]" + str(pointsCurrentSession) + "[/center]";
