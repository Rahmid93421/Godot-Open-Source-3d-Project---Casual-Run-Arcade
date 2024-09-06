extends StaticBody

export onready var housesArray = [preload("res://House1.tscn"), preload("res://House2.tscn"),
									preload("res://House3.tscn"), preload("res://House4.tscn"),
									preload("res://House5.tscn")];
export onready var pointScene = preload("res://Points.tscn");
export onready var objectScene = preload("res://Object.tscn");

var pointsArray = [null, null, null,
					null, null, null,
					null, null, null,
					null, null, null,
					null, null, null];
					
var objectsArray = [null, null];
var objectsPos = [Vector3(-1.3, 0, 0), Vector3(0, 0, 0), Vector3(1.3, 0, 0)];

var posPoints = Vector3(0, 1.2, -3.5);   # translation.y = 1.2 , translation.z = -3.5;

var randGen = RandomNumberGenerator.new();
var genNum = null;
var houseObj = null;
var playCoinSound = false;

func _ready():
	_createObjects();
	_createPoints();
	
	randGen.randomize();
	genNum = randGen.randi_range(0, 4);
	houseObj = housesArray[genNum].instance();
	add_child(houseObj);

func _process(_delta):
	if(playCoinSound):
		playCoinSound = false;
		get_parent().get_node("AudioStreamPlayer").play();

func _refreshRoad():
	randGen.randomize();
	var newNum = randGen.randi_range(0, 4);
	if(genNum != newNum):
		remove_child(houseObj);
		houseObj.queue_free();
		genNum = newNum;
		houseObj = housesArray[genNum].instance();
		add_child(houseObj);
	
#	for i in pointsArray.size():
#		if(pointsArray[i]):
#			remove_child(pointsArray[i]);
	for i in objectsArray.size():
		if(objectsArray[i]):
			remove_child(objectsArray[i]);
			objectsArray[i].queue_free();
	_createObjects();
	_createPoints();

func _createObjects():
	for i in objectsArray.size():
		objectsArray[i] = objectScene.instance();
		add_child(objectsArray[i]);
		randGen.randomize();
		genNum = randGen.randi_range(0, objectsPos.size()-1);
		objectsArray[i].translation = objectsPos[genNum];
		match genNum:
			0:
				objectsPos[0] = objectsPos[objectsPos.size() - 1];
				objectsPos.resize(objectsPos.size() - 1);
			1:
				objectsPos[1] = objectsPos[objectsPos.size() - 1];
				objectsPos.resize(objectsPos.size() - 1);
			2:
				objectsPos.resize(objectsPos.size() - 1);
		print(objectsArray[i].translation);
	
	objectsPos = [Vector3(-1.3, 0, 0), Vector3(0, 0, 0), Vector3(1.3, 0, 0)];

func _createPoints():
	for i in range(0, pointsArray.size(), 3):
		randGen.randomize();
		genNum = randGen.randi_range(0, 1);
		
		if(genNum):
			pointsArray[i] = pointScene.instance();
		else:
			pointsArray[i] = null;
		
		randGen.randomize();
		genNum = randGen.randi_range(0, 1);
		
		if(genNum):
			pointsArray[i+1] = pointScene.instance();
		else:
			pointsArray[i+1] = null;
			
		randGen.randomize();
		genNum = randGen.randi_range(0, 1);
		
		if(genNum):
			pointsArray[i+2] = pointScene.instance();
		else:
			pointsArray[i+2] = null;

		if(pointsArray[i]):
			add_child(pointsArray[i]);
			pointsArray[i].translation.x = -1.3;
			pointsArray[i].translation += posPoints;
			pointsArray[i].scale = Vector3(.05, .05, .05);
			
		if(pointsArray[i+1]):
			add_child(pointsArray[i+1]);
			pointsArray[i+1].translation += posPoints;
			pointsArray[i+1].scale = Vector3(.05, .05, .05);
			
		if(pointsArray[i+2]):
			add_child(pointsArray[i+2]);
			pointsArray[i+2].translation.x = 1.3;
			pointsArray[i+2].translation += posPoints;
			pointsArray[i+2].scale = Vector3(.05, .05, .05);
			
		posPoints.z += 1.0;

	posPoints = Vector3(0, 1.2, -3.5);
