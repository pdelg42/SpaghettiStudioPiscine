extends CharacterBody2D


const SPEED = 100.0

@onready var sprite = $Sprite

var direction : Vector2 = Vector2.ZERO

func update_sprite_on_direction():
	if direction.x > 0:
		sprite.frame = 0
	if direction.y > 0:
		sprite.frame = 1
	if direction.x < 0:
		sprite.frame = 2
	if direction.y < 0:
		sprite.frame = 3

func _physics_process(delta):

	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	velocity = direction.normalized() * SPEED
	
	update_sprite_on_direction()

	move_and_slide()
