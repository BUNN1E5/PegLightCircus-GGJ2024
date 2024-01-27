extends CharacterBody3D

const UNIT_SPEED = 2
const ACCELERATION = 10
const CIRCLE_SIZE = 10

# https://www.youtube.com/watch?v=EOocBMBbL-E
@onready var agent: NavigationAgent3D = $NavigationAgent3D
@onready var entrancePoint: Marker3D = get_node("/root/MiguelWorkspace/Targets/Entrance")
var identifier = 0


func _ready():
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	# set at spawn point
	#self.global_position = entrancePoint.position <-THIS WAS your problem
	# static points don't work for multiple units.
	#agent.set_target_position(Vector3(-3.654545, 0, 7.622066))
	# randomized locations work for more than 1 unit.
	pickNewLocation(Vector3(-3.654545, 0, 7.622066))


func _physics_process(delta):
	moveToLocation(delta)
	
	
func moveToLocation(delta):
	var direction = Vector3()
	
	direction = agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * UNIT_SPEED, ACCELERATION * delta)
	
	move_and_slide()

func pickNewLocation(target):
	if target == null:
		target = random_inside_unit_circle()
		target = target * CIRCLE_SIZE # <- This was the verdict
	print(target)
	agent.set_target_position(target)

# https://www.reddit.com/r/godot/comments/vjge0n/could_anyone_share_some_code_for_finding_a/
func random_inside_unit_circle() -> Vector3:
	var theta : float = randf() * 2 * PI
	return Vector3(cos(theta),0, sin(theta)) * sqrt(randf())

# https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
#func _on_navigation_agent_3d_navigation_finished():
	#pickNewLocation()
