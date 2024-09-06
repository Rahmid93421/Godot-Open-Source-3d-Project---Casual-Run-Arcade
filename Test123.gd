extends Spatial

var filePath = "user://saveGame.save";
var data = { "highscore": 0, "coins": 0, "lives": 5, "hour": 0, "minute": 0, "day": 0, "month": 0, "year": 0, "skinGender": -1, "skin": "defaultMale" };

func _ready():
	print(data);
	print(OS.get_time());
	print(OS.get_date());
	
	var file = File.new();
	file.open(filePath, File.WRITE);
	file.store_var(data);
	file.close();
	
	file = File.new();
	file.open(filePath, File.READ);
	var newData = file.get_var();
	print(newData);
	file.close();
