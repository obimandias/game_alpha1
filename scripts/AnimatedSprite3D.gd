extends AnimatedSprite3D

var direction = Vector2.ZERO
var facing_direction = Vector2.ZERO

var visible_rect: Rect2 = Rect2(0,0,0,0)

var turn_frames: int = 0
@export var MAX_TURN_FRAMES: int = 8
@export var ANIMATION_WALK_SPEED: float = 2.0
@export var ANIMATION_RUN_SPEED: float = 5.0

var SPEED: float = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	self.speed_scale = ANIMATION_WALK_SPEED
	var viewport = self.get_viewport();
	visible_rect = viewport.get_visible_rect()


func _input(event):
				#
	if event.is_pressed():
		self.play()
	else:
		self.stop()

func set_animation_by_angle(angle: float):
	
	if abs(angle) < PI / 2:
		self.flip_h = false
	else:
		if angle > 0:
			angle = PI - angle
		else:
			angle = -PI - angle
		self.flip_h = true
			
	if angle < - PI / 3:
		self.animation = "back"
	elif angle < - PI / 6:
		self.animation = "up_diagonal"
	elif angle < PI / 6:
		self.animation = "running"
	elif angle < PI / 3:
		self.animation = "diagonal"
	else:
		self.animation = "front"

func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if Input.is_action_just_pressed("Run"):
		SPEED = 5.0
		self.speed_scale = ANIMATION_RUN_SPEED
	elif Input.is_action_just_released("Run"):
		SPEED = 2.0
		self.speed_scale = ANIMATION_WALK_SPEED
	
	direction *= SPEED
	translate(Vector3(direction.y, 0, -direction.x))
	
	if direction != Vector2.ZERO:
		facing_direction = facing_direction.slerp(direction, 0.15)

	set_animation_by_angle(facing_direction.angle())
	
	#var new_scale = remap(self.position.y,0, visible_rect.size.y, 0, 1.1)
	#self.scale = Vector2(new_scale, new_scale)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
