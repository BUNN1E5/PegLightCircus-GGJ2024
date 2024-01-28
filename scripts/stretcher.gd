extends Node

@export var stretcher_node_path : NodePath
@onready var stretcher_node : Node3D = get_node(stretcher_node_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func put_in_stretcher(obj : Node3D):
	obj.reparent(stretcher_node, false)
	obj.rotation_degrees.x = -90
	obj.position = Vector3(0, 0.15, 0.5)
	pass
