extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1000



	
func _physics_process(_delta):
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("side")
		$Sprite.flip_h = true
		$Sprite/Particles2D.position.x = -55
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("side")
		$Sprite.flip_h = false
		$Sprite/Particles2D.position.x = 55
	elif Input.is_action_pressed("forward"):
		velocity.y = -SPEED
		$Sprite.play("back")
		$Sprite/Particles2D.z_index = 1
		$Sprite/Particles2D.position.x = 0
	elif Input.is_action_pressed("backward"):
		velocity.y = SPEED
		$Sprite.play("default")
		$Sprite/Particles2D.z_index = -1
		$Sprite/Particles2D.position.x = 0
	if Input.is_action_pressed("right") and Input.is_action_pressed("forward"):
		velocity.x = SPEED
		velocity.y = -SPEED
		$Sprite.play("side.back")
		$Sprite.flip_h = true
		$Sprite/Particles2D.z_index = 1
		$Sprite/Particles2D.position.x = -30
	if Input.is_action_pressed("right") and Input.is_action_pressed("backward"):
		velocity.x = SPEED
		velocity.y = SPEED
		$Sprite.play("side.front")
		$Sprite.flip_h = true
		$Sprite/Particles2D.z_index = -1
		$Sprite/Particles2D.position.x = -30
	if Input.is_action_pressed("left") and Input.is_action_pressed("forward"):
		velocity.x = -SPEED
		velocity.y = -SPEED
		$Sprite.play("side.back")
		$Sprite.flip_h = false
		$Sprite/Particles2D.z_index = 1
		$Sprite/Particles2D.position.x = 30
	if Input.is_action_pressed("left") and Input.is_action_pressed("backward"):
		velocity.x = -SPEED
		velocity.y = SPEED
		$Sprite.play("side.front")
		$Sprite.flip_h = false
		$Sprite/Particles2D.z_index = -1
		$Sprite/Particles2D.position.x = 30
		
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.1)
	velocity.y = lerp(velocity.y,0,0.1)
