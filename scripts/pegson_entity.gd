extends Node
class_name PegsonEntity
@export var dont_variable_speed = false
@onready var rng = RandomNumberGenerator.new()
@export var anim_node : AnimationPlayer

@export var left_light_target : Marker3D
@export var right_light_target : Marker3D

# Called when the node enters the scene tree for the first time.
func _ready():
	if not dont_variable_speed:
		anim_node.speed_scale += rng.randf_range(-.1, .1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
