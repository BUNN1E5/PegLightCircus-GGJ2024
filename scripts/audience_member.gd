extends Node
class_name AudienceMember

@onready var root_node : Node3D = get_node("..")

var pegson_entity : PegsonEntity
# Called when the node enters the scene tree for the first time.
func _ready():
	pegson_entity = get_node("../PegsonEntity")
	AudienceManager.add_member(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
