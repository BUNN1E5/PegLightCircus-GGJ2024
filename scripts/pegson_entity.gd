extends Node
class_name PegsonEntity
@export var in_stretcher = false
@export var dont_variable_speed = false
@onready var rng = RandomNumberGenerator.new()
@export var anim_node : AnimationPlayer

@export var left_light_target : Marker3D
@export var right_light_target : Marker3D

@export var active_nodes_path : Array[NodePath]
@onready var active_nodes : Array[Node] = _load_nodes(active_nodes_path)

func _load_nodes(node_paths : Array[NodePath]) -> Array[Node]:
	var nodes :Array[Node] = []
	for node_path in node_paths:
		var node : Node = get_node(node_path)
		if node != null:
			nodes.append(node)
	return nodes

func _set_active_nodes(state : bool) -> void:
	for node in active_nodes:
		node.set_process(state)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	if not dont_variable_speed:
		anim_node.speed_scale += rng.randf_range(-.1, .1)
	_set_active_nodes(!in_stretcher)
	pass # Replace with function body.

func put_in_stretcher():
	in_stretcher = true
	_set_active_nodes(!in_stretcher)
	pass

func take_from_stretcher():
	in_stretcher = true
	_set_active_nodes(!in_stretcher)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
