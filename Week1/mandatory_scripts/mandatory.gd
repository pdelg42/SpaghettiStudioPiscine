extends Node2D

@onready var cameraLimits : Array = $CameraLimits.get_children()
@onready var camera : Camera2D = $Camera
@onready var player : CharacterBody2D = $Player
@onready var map : TileMap = $Map

func _ready():
	camera.set_limit(SIDE_LEFT, cameraLimits[0].global_position.x)
	camera.set_limit(SIDE_RIGHT, cameraLimits[1].global_position.x)
	camera.set_limit(SIDE_TOP, cameraLimits[0].global_position.y)
	camera.set_limit(SIDE_BOTTOM, cameraLimits[1].global_position.y)
	
func _process(delta):
	map.check_visibles(player.position.y)
	
