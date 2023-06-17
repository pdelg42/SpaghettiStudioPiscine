extends Camera2D

func _physics_process(_delta):
	if global_position.x < limit_left:
		global_position.x = limit_left
	if global_position.x > limit_right:
		global_position.x = limit_right
#	if global_position.x < limit_left:
#		global_position.x = limit_left
#	if global_position.x < limit_left:
#		global_position.x = limit_left
