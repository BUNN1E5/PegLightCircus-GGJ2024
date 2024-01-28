extends Node

@export var targets : Array[Node3D]
@onready var audience_members : Array[AudienceMember]

func add_member(member : AudienceMember):
	audience_members.append(member)

func add_target(target : Node3D):
	targets.append(target)
	
func look_at_nearest_target():
	for audience_member in audience_members:
		for target in targets:
			audience_members.
		pass
	



