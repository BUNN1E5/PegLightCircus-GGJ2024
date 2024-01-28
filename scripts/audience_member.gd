extends Node
class_name AudienceMember

@export var root_node_path : NodePath
@onready var root_node : Node3D = get_node(root_node_path)

@export var pegson_entity_path : NodePath
@onready var pegson_entity : PegsonEntity = get_node(pegson_entity_path)


# Called when the node enters the scene tree for the first time.
func _ready():
	AudienceManager.add_member(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
