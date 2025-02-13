extends KinematicBody

var gravity = Vector3.DOWN * 15;
var speed = 2.5;
var velocity = Vector3.ZERO;
var score = 50;
var timer = null;
var fadeVal = -15;
var timerStart = false;

onready var textures = {
						"m1su": preload("res://assets/Models/textures/M1SUNew.png"),
						"male1": preload("res://assets/Models/textures/male1.png"),
						"male2": preload("res://assets/Models/textures/male2.png"),
						"defaultMale": preload("res://assets/Models/textures/defaultMale.png"),
						"female1": preload("res://assets/Models/textures/female1.png"),
						"female2": preload("res://assets/Models/textures/female2.png"),
						"defaultFemale": preload("res://assets/Models/textures/defaultFemale.png")
						};

func _ready():
	var material = SpatialMaterial.new();
	material.albedo_texture = textures[get_parent().get_parent().infoDict["skin"]];
	if(get_parent().get_parent().infoDict["skinGender"] == 0):
		get_node("maleNewRun/Armature/Skeleton/characterMedium").set_surface_material(0, material);
		get_node("maleNewRun").visible = true;
		get_node("newFemaleCh").visible = false;
	else:
		get_node("newFemaleCh/Armature/Skeleton/characterMedium").set_surface_material(0, material);
		get_node("maleNewRun").visible = false;
		get_node("newFemaleCh").visible = true;
		
	timer = Timer.new();
	add_child(timer);
	timer.connect("timeout", self, "_on_Timer_Timeout");
	timer.set_wait_time(0.03);
	timer.set_one_shot(false);

func _physics_process(delta):
	if(get_parent().get_parent().stopGame == false && get_parent().tutorial == false):
		get_parent().get_node("Ground").translation.z = translation.z;
		
		velocity += gravity * delta;
		
		var vy = velocity.y;
		velocity = Vector3.ZERO;
		velocity += Vector3.BACK;
		velocity = velocity.normalized() * speed;
		velocity.y = vy;
		
		var _dumpVal = move_and_slide(velocity, Vector3.UP);
		
		if(int(get_parent().get_node("Control/HighScore - RichTextLabel").text) > score):
			score += 50;
			speed += 0.1;
			timer.start();
			timerStart = true;
		if(timerStart):
			if(get_parent().get_node("Control/SpeedText").visible == false):
				get_parent().get_node("Control/SpeedText").visible = true;
			get_parent().get_node("Control/SpeedText").bbcode_text = "[center][shake rate=6 level=5][fade start=" + str(fadeVal) + " length=14]SPEED INCREASED[/fade][/shake][/center]";
			if(fadeVal >= 25):
				get_parent().get_node("Control/SpeedText").visible = false;
				timerStart = false;
				timer.stop();
				fadeVal = -15;

func _on_Timer_Timeout():
	fadeVal += 1;
