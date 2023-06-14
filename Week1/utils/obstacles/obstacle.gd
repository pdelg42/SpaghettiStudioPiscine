extends Area2D

@export var bonus_malus : float = 0

@onready var sprite = $Sprite
@onready var shadow = $Shadow
@onready var hitParticles : GPUParticles2D = $HitParticles
@onready var shader_overlay : Vector3 = Vector3.ZERO

var time = 0.

func animate():
	var sprite_tween := get_tree().create_tween().set_loops()
	var shadow_tween := get_tree().create_tween().set_loops()
	sprite_tween.set_ease(Tween.EASE_IN_OUT)
	sprite_tween.set_trans(Tween.TRANS_SINE)
	shadow_tween.set_ease(Tween.EASE_IN_OUT)
	shadow_tween.set_trans(Tween.TRANS_SINE)
	sprite_tween.tween_property(sprite, "position", Vector2.UP*5, 1).as_relative()
	sprite_tween.tween_property(sprite, "position", Vector2.DOWN*5, 1).as_relative()
	shadow_tween.tween_property(shadow, "scale", Vector2.LEFT * 0.010, 1).as_relative()
	shadow_tween.tween_property(shadow, "scale", Vector2.RIGHT * 0.010, 1).as_relative()


func _ready():
	if sprite.material:
		shader_overlay = sprite.material.get_shader_parameter("noise").noise.offset
	else:
		set_process(false)
	animate()


func _process(delta):
	time += delta * 10
	shader_overlay.x = cos(deg_to_rad(time)) * 64.
	shader_overlay.y = sin(deg_to_rad(time)) * 64.
	print(shader_overlay)
	sprite.material.get_shader_parameter("noise").noise.offset = shader_overlay
	sprite.material.get_shader_parameter("noise").noise.fractal_ping_pong_strength \
		= abs(shader_overlay.normalized().y * 6.) + 2
	if time >= 360:
		time -= 360
	

func _on_hurt_box_area_entered(area):
	if not "HitBox" in area.name:
		return
	area.get_parent().speed_mod = bonus_malus
	if "Booster" in name or "Sloower" in name:
		hitParticles.look_at((area.global_position))
	hitParticles.restart()
