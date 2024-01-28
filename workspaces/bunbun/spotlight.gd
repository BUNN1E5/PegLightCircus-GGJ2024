extends Node3D

@export var camera_node_path : NodePath
@onready var camera_node : Camera3D = get_node(camera_node_path)

@onready var light_collider : Area3D = $Area3D

@export var mouse_collision_mask : int
# Called when the node enters the scene tree for the first time.
func _ready():
	light_collider.connect("body_entered", _on_enter_spotlight)
	light_collider.connect("body_exited", _on_exit_spotlight)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self._move_light(self.rotation + Vector3.ZERO)
	pass
	
func _physics_process(delta):
	pass

func _move_light(move : Vector3):
	self.rotation_degrees = Vector3(move.x, move.y, 0)
	pass
	
@onready var marker = Marker3D.new()
func _input(event):
	if event is InputEventMouseMotion:
		var from = camera_node.project_ray_origin(event.position)
		var to = from + camera_node.project_ray_normal(event.position) * 1000
		var space = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space.intersect_ray(query)
		print(result)
		if result:
			#marker.position = result[0].position
			pass
		marker.gizmo_extents = 1
		self.look_at(marker.position)


func _on_enter_spotlight(body : Node3D):
	pass

func _on_exit_spotlight(body : Node3D):
	pass
