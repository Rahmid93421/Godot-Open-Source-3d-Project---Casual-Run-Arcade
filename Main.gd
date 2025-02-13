extends Spatial

onready var animationNode = get_node("AnimationPlayer");
export var changeScene = false;
export var stopGame = false;
export var saveGamePath = "user://saveGame.save";
export var characterUnlockd = "user://chUnlocked.save";

var gameOver = false;
var playButtonPressed = false;
var playOrNah = false;
var charactersButtonPressed = false;
var chOrNah = false;
var scoreFromSession = null;
var showBanner = false;
var side = null;

var infoDict = { "highscore": 0, "coins": 0, "lives": 5, "hour": 0, "minute": 0, "day": 0, "month": 0, "year": 0, "skinGender": -1, "skin": "defaultMale" };
var characterUnlocked = { "m1su": 0, "male1": 0, "male2": 0, "female1": 0, "female2": 0 };

func _ready():
	get_node("AudioStreamPlayer").autoplay = true;
	get_node("AudioStreamPlayer").play();
	
	$yodo1mas.init()
	
	$yodo1mas.load_banner_ad("AdaptiveBanner", "RIGHT", "BOTTOM")
	$yodo1mas.load_rewarded_ad()
	$yodo1mas.load_interstitial_ads()
	
#	$yodo1mas.show_banner_ad_with_align($yodo1mas.BannerAlign.BANNER_RIGHT | $yodo1mas.BannerAlign.BANNER_BOTTOM)
	
#	print(str(get_instance_id()));

#	MobileAds.request_user_consent();
#	var _dump = MobileAds.connect("banner_loaded", self, "_on_MobileAds_banner_loaded");
#	_dump = MobileAds.connect("interstitial_loaded", self, "_on_MobileAds_interstitial_loaded");
#	_dump = MobileAds.connect("initialization_complete", self, "_on_MobileAds_initialization_complete");

#func _on_MobileAds_initialization_complete(_status : int, _adapter_name : String):
#	MobileAds.load_banner();
#	MobileAds.load_interstitial();
#
#func _on_MobileAds_banner_loaded():
#	MobileAds.show_banner();
#
#func _on_MobileAds_interstitial_loaded():
#	pass
#	MobileAds.show_interstitial();

func _reload_ads():
	$yodo1mas.load_banner_ad("AdaptiveBanner", "RIGHT", "BOTTOM")
	$yodo1mas.load_rewarded_ad()
	$yodo1mas.load_interstitial_ads()

func _saveToFile():
	var file = File.new();
	file.open(saveGamePath, File.WRITE);
	file.store_var(infoDict);
	file.close();
	
	file = File.new();
	file.open(characterUnlockd, File.WRITE);
	file.store_var(characterUnlocked);
	file.close();

func _loadFromFile():
	var file = File.new();
	file.open(saveGamePath, File.READ);
	infoDict = file.get_var();
	print(infoDict);
	file.close();
	
	file = File.new();
	file.open(characterUnlockd, File.READ);
	characterUnlocked = file.get_var();
	print(characterUnlocked);
	file.close();

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		_saveToFile();

func _process(_delta):
	if(gameOver == true):
		animationNode.play("FadeIn");
		stopGame = true;
		gameOver = false;
	else:
		if(playButtonPressed == true):
			if(int(get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text) > 0):
				animationNode.play("FadeIn");
				playButtonPressed = false;
				playOrNah = true;
			else:
				playButtonPressed = false;
				if(get_node("Menu - UI/Main Node - Control/Panel3").get_rect().position.y < 193 && !get_node("Menu - UI/Main Node - Control/Panel3/AnimationPlayer").is_playing()):
					get_node("Menu - UI/Main Node - Control/Panel3/AnimationPlayer").play("PanelSlide");
		else:
			if(charactersButtonPressed):
				animationNode.play("FadeIn");
				charactersButtonPressed = false;
				chOrNah = true;
	
	if(changeScene == true):
		changeScene = false;
		_changeScene();

func _changeScene():
	if(get_node_or_null("ActualGame")):
		var node = get_node("ActualGame");
		
#		MobileAds.load_interstitial();
		$yodo1mas.show_interstitial_ad();
		
		scoreFromSession = node.pointsCurrentSession;
		print(scoreFromSession);
		infoDict["coins"] += scoreFromSession;
		print(infoDict["coins"]);
		infoDict["lives"] -= 1;
		_saveToFile();
		
		remove_child(node);
		node.queue_free();
		
		node = preload("res://Menu - UI.tscn");
		node = node.instance();
		add_child(node);
	else:
		if(get_node_or_null("Menu - UI")):
			match playOrNah:
				true:
					var node = get_node("Menu - UI");
					remove_child(node);
					node.queue_free();
					
					node = preload("res://ActualGame.tscn");
					node = node.instance();
					add_child(node);
					playOrNah = false;
				false:
					if(chOrNah):
						var node = get_node("Menu - UI");
						remove_child(node);
						node.queue_free();
						
						node = preload("res://Characters UI.tscn");
						node = node.instance();
						add_child(node);
						chOrNah = false;
		else:
			if(get_node_or_null("CharactersSpatial")):
				var node = get_node("CharactersSpatial");
				remove_child(node);
				node.queue_free();
				
				_saveToFile();
				
				node = preload("res://Menu - UI.tscn");
				node = node.instance();
				add_child(node);
	
	var node = get_node("ColorRect");
	remove_child(node);
	add_child(node);
	animationNode.play("FadeOut");

func _on_Yodo1Mas_rewarded_ad_earned():
	match side:
		1:
			var value = get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			side = null;
		2:
			var value = get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			side = null;
		null:
			var value = get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
	infoDict["coins"] = int(get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text)
	infoDict["lives"] = int(get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text);
	_saveToFile();

func _on_yodo1mas_interstitial_ad_closed():
	match side:
		1:
			var value = get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			infoDict["coins"] = int(get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text)
			side = null;
		2:
			var value = get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			infoDict["lives"] = int(get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text);
			side = null;
		null:
			infoDict["coins"] += 50;
	_saveToFile();

func _give_reward():
	var value = get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
	get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
	infoDict["coins"] = int(get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text)
	side = null;
	_saveToFile();

func _on_yodo1mas_rewarded_ad_earned():
	match side:
		1:
			var value = get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			infoDict["coins"] = int(get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text)
			side = null;
		2:
			var value = get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			infoDict["lives"] = int(get_node("Menu - UI/Main Node - Control/Lives - Panel/Value - Label").text);
			side = null;
		null:
			infoDict["coins"] += 50;
	_saveToFile();

func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "FadeOut"):
		_reload_ads()
