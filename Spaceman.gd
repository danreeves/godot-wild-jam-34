extends KinematicBody

export var DRAG = 0.8
export var GRAVITY = 0.1
export var MAX_VELOCITY = 50

var gravities = []
var velocity = Vector3.ZERO

func add_gravity(node: Area):
	if not gravities.has(node):
		gravities.append(node)

func remove_gravity(node: Area):
	if gravities.has(node):
		gravities.remove(gravities.find(node))

func get_up():
	if gravities.size() > 0:
		var top_gravity = gravities.back()
		var up = -(top_gravity.global_transform.origin - global_transform.origin).normalized()
		return up
	return Vector3.UP

func dir_to(a: Node, b: Node):
	return (a.global_transform.origin.direction_to(b.global_transform.origin)).normalized()
	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
	
func _process(delta: float) -> void:
	var gravity_up = get_up()
	
	global_transform = global_transform.interpolate_with(
		align_with_y(global_transform, gravity_up), 
		0.05
	)
	
	var up = dir_to($Character/Bottom, $Character/Top)
	var down = dir_to($Character/Top, $Character/Bottom)
	var forward = dir_to($Character/Back, $Character/Front)
	var boosting = false
		
	if Input.is_action_pressed("space"):
		boosting = true
		velocity += up
			
	if Input.is_action_pressed("down"):
		boosting = true
		velocity += down
	
	if Input.is_action_pressed("forward"):
		boosting = true
		velocity += forward
		
	if Input.is_action_pressed("left"):
		boosting = true
		rotate_object_local(Vector3.UP, 1.0 * delta)
		
	if Input.is_action_pressed("right"):
		boosting = true
		rotate_object_local(Vector3.UP, -1.0 * delta)

	$Character/Jetpack/Particles.emitting = boosting
	$Character/Jetpack/Particles2.emitting = boosting

	if velocity.length() > MAX_VELOCITY:
		velocity = velocity.normalized() * MAX_VELOCITY

	if !is_on_floor():
		velocity += -gravity_up * GRAVITY
	else:
		velocity = velocity * DRAG

	velocity = move_and_slide(velocity, gravity_up)
