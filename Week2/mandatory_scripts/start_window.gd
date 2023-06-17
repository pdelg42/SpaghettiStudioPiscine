extends Control


@onready var gO = $GameOverContainer/GameOver


var kilos_to_disp : String


func _on_button_pressed():
	get_tree().change_scene_to_file("res://mandatory.tscn")
	
func _ready():
	if "End" in name:
		var load = FileAccess.get_file_as_string("save.save")
		$KMDone.set_text("KM " + load)
