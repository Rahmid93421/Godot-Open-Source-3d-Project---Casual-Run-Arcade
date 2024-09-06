extends StaticBody

export onready var housesArray = [preload("res://House1.tscn"), preload("res://House2.tscn"),
									preload("res://House3.tscn"), preload("res://House4.tscn"),
									preload("res://House5.tscn")];

var randGen = RandomNumberGenerator.new();
var genNum = null;
var houseObj = null;

func _ready():
	randGen.randomize();
	genNum = randGen.randi_range(0, 4);
	houseObj = housesArray[genNum].instance();
	add_child(houseObj);

func _refreshHouse():
	randGen.randomize();
	var newNum = randGen.randi_range(0, 4);
	if(genNum != newNum):
		remove_child(houseObj);
		houseObj.queue_free();
		genNum = newNum;
		houseObj = housesArray[genNum].instance();
		add_child(houseObj);
