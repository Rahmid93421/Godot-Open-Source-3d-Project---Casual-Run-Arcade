extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("TutorialIn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "TutorialIn"):
		$AnimationPlayer.play("Tutorial")
	if(anim_name == "TutorialOut"):
		get_parent().get_parent().tutorial = false

func _on_Button_pressed():
	$AnimationPlayer.play("TutorialOut")
