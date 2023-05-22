extends CharacterBody2D


const SPEED = 100.0
const MAX_ROT = 20

@onready var sprite = $Sprite
@onready var rayAnim = $Sprite/RayAnimation



var direction : Vector2 = Vector2.ZERO

func define_rotation():
	var rot_degs = velocity.x / SPEED * MAX_ROT
	sprite.rotation = deg_to_rad(rot_degs)

func define_animation():
	if velocity.x == 0 and velocity.y == 0:
		if not rayAnim.animation == "Idle":
			rayAnim.play("Idle")
	else:
		rayAnim.play("Moving")

func _physics_process(delta):

	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if abs(velocity.x) < 0.01:
		velocity.x = 0
	if abs(velocity.y) < 0.01:
		velocity.y = 0
	
	velocity = velocity.move_toward(direction.normalized() * SPEED, 0.85)
	
	define_rotation()
	
	define_animation()

	move_and_slide()


func _on_ray_animation_animation_finished():
	rayAnim.stop()
