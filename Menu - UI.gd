extends Spatial

var side = null;

func _ready():
	get_node("AnimationPlayer").play("Gradient");
	var parentNode = get_parent();
	
	var file = File.new();
	if(file.file_exists("user://saveGame.save")):
		parentNode._loadFromFile();
	else:
		parentNode._saveToFile();
	if(parentNode.scoreFromSession != null):
		if(parentNode.scoreFromSession > parentNode.infoDict["highscore"]):
			parentNode.infoDict["highscore"] = parentNode.scoreFromSession;
			parentNode._saveToFile();
	
	get_node("Main Node - Control/HighScore - RichTextLabel").bbcode_text = "[center]" + str(parentNode.infoDict["highscore"]) + "[/center]";
	get_node("Main Node - Control/Lives - Panel/Value - Label").text = str(parentNode.infoDict["lives"]);
	get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(parentNode.infoDict["coins"]);
	
#	var _dump = MobileAds.connect("rewarded_ad_loaded", self, "_on_MobileAds_rewarded_ad_loaded");
#	_dump = MobileAds.connect("rewarded_ad_closed", self, "_on_MobileAds_rewarded_ad_closed");
	
	if(get_parent().infoDict["skinGender"] == -1):
		get_node("Main Node - Control/Panel4/AnimationPlayer").play("PanelSlide");
	
	get_parent().get_node("yodo1mas").show_banner_ad();
	
#func _on_MobileAds_rewarded_ad_loaded():
#	MobileAds.show_rewarded();

func _on_MobileAds_rewarded_ad_closed():
	match side:
		1:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			side = null;
		2:
			var value = get_node("Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			side = null;
	get_parent().infoDict["lives"] = int(get_node("Main Node - Control/Lives - Panel/Value - Label").text);

func _on_PlayBTN_pressed():
	get_parent().playButtonPressed = true;

func _on_Lives__Panel_mouse_entered():
	if(int(get_node("Main Node - Control/Lives - Panel/Value - Label").text) < 10):
		if(!get_node("Main Node - Control/Panel/AnimationPlayer").is_playing() && get_node("Main Node - Control/Panel").get_rect().position.x > 12):
			if(get_node("Main Node - Control/Panel2").get_rect().position.x < 12):
				get_node("Main Node - Control/Panel/AnimationPlayer").play("PanelSlide");

func _on_close_AdRequest_pressed():
	if(!get_node("Main Node - Control/Panel/AnimationPlayer").is_playing()):
		get_node("Main Node - Control/Panel/AnimationPlayer").play("PanelOut");
		if(get_parent().infoDict["coins"] >= 1000):
			get_parent().infoDict["coins"] -= 1000;
			get_parent().infoDict["lives"] += 1;
		else:
			get_node("Main Node - Control/Panel5/AnimationPlayer").play("PanelOut");
		get_node("Main Node - Control/Lives - Panel/Value - Label").text = str(get_parent().infoDict["lives"]);
		get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(get_parent().infoDict["coins"]);


func _on_CoinsBar__Panel_mouse_entered():
	if(!get_node("Main Node - Control/Panel2/AnimationPlayer").is_playing() && get_node("Main Node - Control/Panel2").get_rect().position.x < 12):
		if(get_node("Main Node - Control/Panel").get_rect().position.x > 12):
			get_node("Main Node - Control/Panel2/AnimationPlayer").play("PanelSlide");

func _on_close_AdRequest2_pressed():
	if(!get_node("Main Node - Control/Panel2/AnimationPlayer").is_playing()):
		get_node("Main Node - Control/Panel2/AnimationPlayer").play("PanelOut");

func _on_show_AdRequest2_pressed():
#	MobileAds.load_rewarded();
	if(get_parent().get_node("yodo1mas").is_rewarded_ad_loaded()):
		get_parent().get_node("yodo1mas").show_rewarded_ad();
	else:
		get_parent().get_node("yodo1mas").show_interstitial_ad();
	get_node("Main Node - Control/Panel2/AnimationPlayer").play("PanelOut");
	get_parent().side = 1;

func _on_show_AdRequest_pressed():
#	MobileAds.load_rewarded();
	if(get_parent().get_node("yodo1mas").is_rewarded_ad_loaded()):
		get_parent().get_node("yodo1mas").show_rewarded_ad();
	else:
		get_parent().get_node("yodo1mas").show_interstitial_ad();
	get_node("Main Node - Control/Panel/AnimationPlayer").play("PanelOut");
	get_parent().side = 2;

func _on_close_AdRequest3_pressed():
	if(!get_node("Main Node - Control/Panel3/AnimationPlayer").is_playing()):
		get_node("Main Node - Control/Panel3/AnimationPlayer").play("PanelOut");

func _on_show_AdRequest3_pressed():
#	MobileAds.load_rewarded();
	if(get_parent().get_node("yodo1mas").is_rewarded_ad_loaded()):
		get_parent().get_node("yodo1mas").show_rewarded_ad();
	else:
		get_parent().get_node("yodo1mas").show_interstitial_ad();
	get_node("Main Node - Control/Panel3/AnimationPlayer").play("PanelOut");
	get_parent().side = 2;

func _on_CharactersBTN_pressed():
	get_parent().charactersButtonPressed = true;

func _on_Button_Male_pressed():
	get_parent().infoDict["skinGender"] = 0;
	get_parent()._saveToFile();
	get_node("Main Node - Control/Panel4/AnimationPlayer").play("PanelOut");

func _on_Button_Female_pressed():
	get_parent().infoDict["skinGender"] = 1;
	get_parent().infoDict["skin"] = "defaultFemale";
	get_parent()._saveToFile();
	get_node("Main Node - Control/Panel4/AnimationPlayer").play("PanelOut");
	
func _on_ad_rewarded_pressed():
#	MobileAds.load_rewarded();
	if(get_parent().get_node("yodo1mas").is_rewarded_ad_loaded()):
		get_parent().get_node("yodo1mas").show_rewarded_ad();
	else:
		get_parent().get_node("yodo1mas").show_interstitial_ad();
	get_parent().side = 1;
	get_node("Main Node - Control/Panel5/AnimationPlayer").play("PanelSlide");

func _on_ad_rewarded_no_pressed():
	get_node("Main Node - Control/Panel5/AnimationPlayer").play("PanelSlide");


func _on_yodo1mas_ready():
	pass
#	$yodo1mas.init(); # than let me put it inside Game node's script or there is another solution
#	$yodo1mas.show_banner_ad();
#	$yodo1mas.show_interstitial_ad();

func _on_yodo1mas_rewarded_ad_earned():
	match side:
		1:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			side = null;
		2:
			var value = get_node("Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			side = null;
		null:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
	get_parent().infoDict["lives"] = int(get_node("Main Node - Control/Lives - Panel/Value - Label").text);


func _on_Yodo1Mas_rewarded_ad_earned():
	match side:
		1:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			side = null;
		2:
			var value = get_node("Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			side = null;
		null:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
	get_parent().infoDict["lives"] = int(get_node("Main Node - Control/Lives - Panel/Value - Label").text);
	get_parent()._saveToFile();

func _on_yodo1mas_interstitial_ad_closed():
	match side:
		1:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
			side = null;
		2:
			var value = get_node("Main Node - Control/Lives - Panel/Value - Label").text;
			get_node("Main Node - Control/Lives - Panel/Value - Label").text = str(int(value) + 1);
			side = null;
		null:
			var value = get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
			get_node("Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
	get_parent().infoDict["lives"] = int(get_node("Main Node - Control/Lives - Panel/Value - Label").text);
	get_parent()._saveToFile();
