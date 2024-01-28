extends Resource
class_name PegsonData

@export var randomize = true
@export_range (-.1, .1) var animation_speed_modifier

var rng
func new():
	rng = RandomNumberGenerator.new()
	animation_speed_modifier = rng.randf_range(-0.1, 0.1)
