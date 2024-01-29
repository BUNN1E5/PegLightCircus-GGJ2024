extends SpotLight3D

@export var camera_node_path : NodePath
@onready var camera_node : Camera3D = get_node(camera_node_path)

@onready var marker = Marker3D.new()

@onready var light_collider : Area3D = $Area3D

@export var input_name_prefix : String
@export var mouse_collision_mask : int
@export var use_mouse : bool = false

@export var speed : float
@export var smooth_value : float

@export var spotlight_on : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	light_collider.connect("body_entered", _on_enter_spotlight)
	light_collider.connect("body_exited", _on_exit_spotlight)
	self.look_at(Vector3.ZERO)
	marker.set_gizmo_extents(10)
	AudienceManager.add_target(marker)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self._move_light(_controller_stick())
	pass

func _move_light(move : Vector2):
	var z_relative = camera_node.transform.basis * Vector3(move.x, -move.y, 0)
	z_relative.y = 0
	marker.position += z_relative
	self.look_at(marker.position)
	pass

func _set_light(enabled : bool):
	if enabled:
		AudienceManager.add_target(marker)
	else:
		AudienceManager.remove_target(marker)
	self.visisble = enabled
	spotlight_on = enabled
	light_collider.set_process(enabled)
	self.set_process(enabled)

	

func _controller_stick(): # Do we wanna make the curse a x^2 curve it's normalized to 1 anyways and will make joystick easier
	var input = Input.get_vector(input_name_prefix + "_left", input_name_prefix + "_right", input_name_prefix + "_up", input_name_prefix + "_down")
	return input * speed

func _input(event):
	if event.is_action_pressed(input_name_prefix + "_toggle"):
		_set_light(!spotlight_on)
	
	if event is InputEventMouseMotion:
		if not use_mouse:
			return
		var from = camera_node.project_ray_origin(event.position)
		var to = from + camera_node.project_ray_normal(event.position) * 10000
		var space = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space.intersect_ray(query)
		
		if result:
			marker.position = result.position
		self.look_at(marker.position)


func _on_enter_spotlight(body : Node3D):
	
	pass

func _on_exit_spotlight(body : Node3D):
	pass
