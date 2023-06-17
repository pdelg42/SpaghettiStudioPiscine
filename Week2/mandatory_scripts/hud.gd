extends CanvasLayer


signal toggle_pause_window


@onready var velocimeter : TextureProgressBar = $Control/Velocimeter
@onready var velocimeter_value : Label = $Control/ValoreVelocimetro/Margini/Testo
@onready var lancetta_tachimetro : TextureRect = $Control/Tachimetro/Lancetta
@onready var valore_tachimetro : Label = $Control/ContaCarburante/Margini/Testo
@onready var testo_contachilometri : Label = $Control/Contachilometri/Margini/Testo
@onready var pause_status : CheckButton = $PauseActive
@onready var gas_depleted_message : Label = $Control/GasDepletedCont/GasDepletedMessage


var gas_depletion_flag = false
var gas_message_tween : Tween


func _ready():
	gas_message_tween = get_tree().create_tween().set_loops()
	gas_message_tween.bind_node(self)
	gas_message_tween.set_ease(Tween.EASE_IN_OUT)
	gas_message_tween.set_trans(Tween.TRANS_SINE)
	gas_message_tween.tween_property(gas_depleted_message, "modulate", Color("#e55b5dff"), .2)
	gas_message_tween.tween_property(gas_depleted_message, "modulate", Color("#e55b5d00"), .2)
	gas_depleted_message.modulate.a = 0
	gas_message_tween.stop()

func _on_pause_active_toggled(_button_pressed):
	emit_signal("toggle_pause_window")
	
func blink_gas_depleted():
	if not gas_depletion_flag:
		gas_depletion_flag = true
		gas_message_tween.play()
		
		
	
