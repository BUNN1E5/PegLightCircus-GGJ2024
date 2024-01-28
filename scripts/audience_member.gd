extends Node3D
class_name AudienceMember

@export var root_node_path : NodePath
@onready var root_node : Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	AudienceManager.add_member(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
