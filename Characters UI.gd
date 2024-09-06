extends Spatial

var currentCharacter = null;
var unlockTheCurrentCharacter = false;
var priceList = { "m1su": 9500, "male1": 6500, "male2": 7500, "female1": 8000, "female2": 6500 }; 
var noMoney = false;

func _ready():
	#get_parent()._loadFromFile();
	
	pass
#	var _dump = MobileAds.connect("rewarded_ad_loaded", self, "_on_MobileAds_rewarded_ad_loaded");
#	_dump = MobileAds.connect("rewarded_ad_closed", self, "_on_MobileAds_rewarded_ad_closed");

#func _on_MobileAds_rewarded_ad_loaded():
#	MobileAds.show_rewarded();
#
#func _on_MobileAds_rewarded_ad_closed():
#	get_parent().infoDict["coins"] += 50;

func _process(_delta):
	if(unlockTheCurrentCharacter):
		if(currentCharacter):
			if(get_parent().infoDict["coins"] >= priceList[currentCharacter]):
				get_parent().infoDict["coins"] -= priceList[currentCharacter];
				get_parent().characterUnlocked[currentCharacter] = 1;
				get_node("MainUIControl/Panel/" + str(currentCharacter) + "/m1su").show_behind_parent = false;
				unlockTheCurrentCharacter = false;
				currentCharacter = null;
	if(noMoney):
		if(!get_node("MainUIControl/Panel5/AnimationPlayer").is_playing()):
			get_node("MainUIControl/Panel5/AnimationPlayer").play("PanelOut");
			noMoney = false;

func _on_Button_pressed():
	get_parent().charactersButtonPressed = true;

func _on_left_button_pressed():
	if(get_node("MainUIControl/Panel").get_rect().position.x == -700):
		get_node("MainUIControl/AnimationPlayer").play("PanelSwitchBack1");

func _on_right_button_pressed():
	if(get_node("MainUIControl/Panel").get_rect().position.x == 0):
		get_node("MainUIControl/AnimationPlayer").play("PanelSwitch1");

func _on_RichTextLabel_mouse_entered():
	get_node("MainUIControl/Panel2/defaultMale/Panel2/RichTextLabel").bbcode_text = "[center]SELECTED[/center]";
	get_parent().infoDict["skin"] = "defaultMale";
	get_parent().infoDict["skinGender"] = 0;

func _on_RichTextLabel_mouse_exited():
	get_node("MainUIControl/Panel2/defaultMale/Panel2/RichTextLabel").bbcode_text = "[center]SELECT[/center]";

func _on_RichTextLabel2_mouse_entered():
	get_node("MainUIControl/Panel2/defaultFemale/Panel2/RichTextLabel").bbcode_text = "[center]SELECTED[/center]";
	get_parent().infoDict["skin"] = "defaultFemale";
	get_parent().infoDict["skinGender"] = 1;

func _on_RichTextLabel2_mouse_exited():
	get_node("MainUIControl/Panel2/defaultFemale/Panel2/RichTextLabel").bbcode_text = "[center]SELECT[/center]";

func _on_BuyM1SU_mouse_entered():
	get_node("MainUIControl/Panel4/TextAd").bbcode_text = "[center]ARE YOU SURE THAT YOU WANT TO UNLOCK [u][color=red]'M1SU'[/color][/u] SKIN for 9500 points?[/center]"
	get_node("MainUIControl/Panel4/AnimationPlayer").play("PanelOut");
	currentCharacter = "m1su";

func _on_unlockCharacter_pressed():
	if(get_parent().infoDict["coins"] >= priceList[currentCharacter]):
		unlockTheCurrentCharacter = true;
		var node = "MainUIControl/Panel/" + currentCharacter + "/Panel";
		get_node(node).visible = false;
		get_node("MainUIControl/Panel/" + str(currentCharacter) + "/Panel2").visible = false;
		get_node("MainUIControl/Panel/" + str(currentCharacter) + "/Panel3").visible = true;
		get_node("MainUIControl/Panel4/AnimationPlayer").play("PanelSlide");
	else:
		unlockTheCurrentCharacter = false;
		currentCharacter = null;
		get_node("MainUIControl/Panel4/AnimationPlayer").play("PanelSlide");
		noMoney = true;

func _on_not_unlockCharacter_pressed():
	get_node("MainUIControl/Panel4/AnimationPlayer").play("PanelSlide");
	unlockTheCurrentCharacter = false;
	currentCharacter = null;

func _on_M1SUSelect_mouse_entered():
	get_node("MainUIControl/Panel/m1su/Panel3/RichTextLabel").bbcode_text = "[center]SELECTED[/center]";
	get_parent().infoDict["skin"] = "m1su";
	get_parent().infoDict["skinGender"] = 0;

func _on_M1SUSelect_mouse_exited():
	get_node("MainUIControl/Panel/m1su/Panel3/RichTextLabel").bbcode_text = "[center]SELECT[/center]";

func _on_ad_rewarded_pressed():
#	MobileAds.load_rewarded();
	if(get_parent().get_node("yodo1mas").is_rewarded_ad_loaded()):
		get_parent().get_node("yodo1mas").show_rewarded_ad();
	else:
		get_parent().get_node("yodo1mas").show_interstitial_ad();
	get_node("MainUIControl/Panel5/AnimationPlayer").play("PanelSlide");

func _on_ad_rewarded_no_pressed():
	get_node("MainUIControl/Panel5/AnimationPlayer").play("PanelSlide");


func _on_Yodo1Mas_rewarded_ad_earned():
#	var value = get_parent().get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text;
#	get_parent().get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text = str(int(value) + 50);
#	get_parent().infoDict["coins"] = int(get_node("Menu - UI/Main Node - Control/CoinsBar - Panel/Value - Sprite").text);
	get_parent().infoDict["coins"] += 50;
	get_parent()._saveToFile();


func _on_Yodo1Mas_interstitial_ad_closed():
	get_parent()._loadFromFile();
	get_parent().infoDict["coins"] += 50;
	get_parent()._saveToFile();
