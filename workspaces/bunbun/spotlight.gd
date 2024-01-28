extends Node3D

@onready var light_collider : Area3D

@export var use_mouse_controls : bool
@export var mouse_collision_mask : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self._move_light(Vector2.ZERO)
	pass	

func _move_light(move : Vector2):
	
	pass

var last_mouse_pos : Vector2 = Vector2.ZERO
func _light_mouse_controls():
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	
	pass

func _on_enter_spotlight():
	pass

func _on_exit_spotlight():
	pass
