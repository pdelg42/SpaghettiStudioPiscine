extends CharacterBody2D


signal gas_depleted


const SPEED = 100.0
const MAX_ROT = 20
const GAS_CONSUMPTION = 0.5 #.2


@onready var sprite = $Sprite
@onready var rayAnim = $Sprite/RayAnimation
@onready var shadow = $Sprite/Shadow


var speed_mod : = 0.
var linear_speed : = 0.
var direction : Vector2 = Vector2.ZERO
var current_chilometers : = 0. :
	set = set_curr_chilo
var current_gas : = 100. : 
	set = set_curr_gas
	

func set_curr_chilo(value):
	current_chilometers += value
	if current_chilometers >= 1000.:
		current_chilometers -= 1000.


func set_curr_gas(value):
	current_gas += value
	current_gas = clamp(current_gas, 0, 100.)


func define_rotation():
	var rot_degs = velocity.x / SPEED * MAX_ROT
	sprite.rotation = deg_to_rad(rot_degs)
	shadow.rotation = -sprite.rotation
	shadow.scale.x = -(abs(sprite.rotation) / (PI / 3)) * 0.025 + 0.025
	

func define_animation():
	if velocity.x == 0 and velocity.y == 0:
		if not rayAnim.animation == "Idle":
			rayAnim.play("Idle")
	else:
		rayAnim.play("Moving")


func _physics_process(delta):
	if current_gas <= 0:
		direction = Vector2.ZERO
		if linear_speed < 0.01:
			emit_signal("gas_depleted")
	else:
		direction.x = Input.get_axis("ui_left", "ui_right")
		direction.y = Input.get_axis("ui_up", "ui_down")
		
	if abs(velocity.x) < 0.01:
		velocity.x = 0
	if abs(velocity.y) < 0.01:
		velocity.y = 0
	
	velocity = velocity.move_toward(direction.normalized() * SPEED, 2.5)
	if speed_mod != 0:
		velocity += velocity.normalized() * speed_mod
		speed_mod = 0
	
	linear_speed = clamp(velocity.length(), 0, SPEED)
	set_curr_gas(-(linear_speed / SPEED * GAS_CONSUMPTION))
	set_curr_chilo(linear_speed * delta / 16.)
	
	define_rotation()
	
	define_animation()

	move_and_slide()


func _on_ray_animation_animation_finished():
	rayAnim.stop()
