extends Node2D

@onready var cameraLimits : Array = $CameraLimits.get_children()
@onready var camera : Camera2D = $Camera
@onready var player : CharacterBody2D = $Player
@onready var map : TileMap = $Map
@onready var hud : CanvasLayer = $HUD
@onready var pauseWindow : CanvasLayer = $PauseWindow


func _on_pause_window_toggled():
	pauseWindow.visible = hud.pause_status.is_pressed()
	set_process(not hud.pause_status.is_pressed())
	player.set_physics_process(not hud.pause_status.is_pressed())


func _on_gas_depleted():
	hud.blink_gas_depleted()
	var save = FileAccess.open("save.save", FileAccess.WRITE)
	var kmstring = "%.1f" % player.current_chilometers
	save.store_line(kmstring)
	await get_tree().create_timer(1.).timeout 
	get_tree().change_scene_to_file("res://end_window.tscn")


func _ready():
	camera.set_limit(SIDE_LEFT, cameraLimits[0].global_position.x)
	camera.set_limit(SIDE_RIGHT, cameraLimits[1].global_position.x)
	camera.set_limit(SIDE_TOP, cameraLimits[0].global_position.y)
	camera.set_limit(SIDE_BOTTOM, cameraLimits[1].global_position.y)
	hud.toggle_pause_window.connect(_on_pause_window_toggled)
	player.gas_depleted.connect(_on_gas_depleted)
	pauseWindow.visible = hud.pause_status.is_pressed()


func _process(_delta):
	map.check_visibles(player.position.y)
	hud.velocimeter.value = player.linear_speed
	hud.velocimeter_value.set_text("%d" % player.linear_speed)
	hud.lancetta_tachimetro.material.set_shader_parameter("speed", \
	((player.current_gas / player.SPEED) * (2. * PI) * 3. / 4.) + PI / 2.)
	hud.valore_tachimetro.set_text("%d" % player.current_gas)
	hud.testo_contachilometri.set_text("%.1f" % player.current_chilometers)

