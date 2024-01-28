extends Node

@export var targets : Array[Marker3D]
@export var audience_members : Array[AudienceMember]

func add_member(member : AudienceMember):
	audience_members.append(member)

func remove_member(member : AudienceMember):
	var index = audience_members.find(member)
	if index == -1:
		print(str(member) + " not found in AudienceManager")
		return
	audience_members.remove_at(index)

func add_target(target : Marker3D):
	targets.append(target)
	
func remove_target(target : Marker3D):
	var index = target.find(target)
	if index == -1:
		print(str(target) + " not found in AudienceManager")
		return
	targets.remove_at(index)

func _look_at_nearest_target():
	for audience_member in audience_members:
		if audience_member.pegson_entity.in_stretcher:
			continue
		var closest_target : Marker3D = Marker3D.new()
		var closed_dist : float = INF
		for target in targets:
			var dist = audience_member.root_node.position.distance_squared_to(target.position)
			if(dist < closed_dist):
				closed_dist = dist
				closest_target = target
		audience_member.root_node.look_at(-closest_target.position)
		pass
	

func _process(delta):
	_look_at_nearest_target()
