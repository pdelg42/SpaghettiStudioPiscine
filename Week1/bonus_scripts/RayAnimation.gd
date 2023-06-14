extends AnimatedSprite2D

var x_scale : float = 1.
var t_dir : float = 1.0

func _physics_process(delta):
	if is_playing():
		x_scale = 1.
		scale.x = x_scale
		return
	if x_scale >= 0.99 and t_dir == 1.:
		t_dir = 0.
	if x_scale <= 0.5 and t_dir == 0.:
		t_dir = 1.0
	x_scale = lerp(x_scale, t_dir + 0.1, 0.1)
	scale.x = x_scale
