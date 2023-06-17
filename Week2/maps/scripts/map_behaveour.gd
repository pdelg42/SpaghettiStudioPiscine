extends TileMap

@onready var houseLayers = $Houses.get_children()

func check_visibles(player_pos_y):
	for l in houseLayers:
		l.modulate.a = max(((player_pos_y - l.global_position.y + 32) / 64), 0)
