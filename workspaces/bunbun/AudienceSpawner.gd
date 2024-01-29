extends Node3D

@export var num_audience : int = 100
@export var audience_spawn_points : Array[Node]
@export var possible_audience : Array[PackedScene] 
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	audience_spawn_points = self.get_children(true)
	var tmp : Array[Node] = []
	for spawn_point in audience_spawn_points:
		tmp.append_array(spawn_point.get_children(true))
	audience_spawn_points = tmp
	
	tmp = []
	for spawn_point in audience_spawn_points:
		tmp.append_array(spawn_point.get_children(true))
	audience_spawn_points = tmp
	
	if(len(possible_audience) == 0):
		return
	
	if(len(possible_audience) == 0):
		return
	
	var count = len(audience_spawn_points)
	var possible : Array[int]
	for i in range(0, count): #This is bad :(
		possible.append(i)
	
	for i in range(0, num_audience):
		var hit : int = rng.randi_range(0, len(possible)-1)
		var member = possible_audience[rng.randi_range(0, len(possible_audience)-1)].instantiate()
		audience_spawn_points[possible[hit]].add_child(member)
		member.position = Vector3.ZERO
		member.add_child(AudienceMember.new())
		possible.remove_at(hit)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
