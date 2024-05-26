extends AnimatedSprite2D

var direction = Vector2.ZERO
var last_direction = Vector2.ZERO

var turn_frames: int = 0
var MAX_TURN_FRAMES: int = 8
var acceleration = Vector2.ZERO

var SPEED: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):

	#if event is InputEventKey:
		#match event.keycode:
#
			#KEY_RIGHT:
				#if last_direction == Vector2.LEFT:
					#self.animation = "front"
					#self.frame = 0
				#else:
					#self.animation = "running"
					#self.flip_h = false
					#
				#last_direction = Vector2.RIGHT
			#KEY_UP:
				#self.animation = "front"
			#KEY_DOWN:
				#self.animation = "front"
			#KEY_LEFT:
				#if last_direction == Vector2.RIGHT:
					#self.animation = "front"
					#self.frame = 0
					#self.speed_scale = 4
				#else:
					#self.speed_scale = 1
					#self.animation = "running"
					#self.flip_h = true
					#
				#last_direction = Vector2.LEFT
					#
	if event.is_pressed():
		self.play()
	else:
		self.stop()

func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	translate(direction * SPEED)
	if direction == Vector2.RIGHT:
		
		if last_direction == Vector2.LEFT:
			self.animation = "front"
			
			if turn_frames >= MAX_TURN_FRAMES:
				turn_frames = 0
				last_direction = Vector2.RIGHT
			else:
				turn_frames += 1
		else:
			self.animation = "running"
			self.flip_h = false
			last_direction = Vector2.RIGHT
	elif direction == Vector2.LEFT:
		
		if last_direction == Vector2.RIGHT:
			self.animation = "front"
			
			if turn_frames >= MAX_TURN_FRAMES:
				turn_frames = 0
				last_direction = Vector2.LEFT
			else:
				turn_frames += 1
		else:
			self.animation = "running"
			self.flip_h = true
	
			last_direction = Vector2.LEFT
	elif direction == Vector2.UP:
		self.animation = "front"
		self.flip_h = false
	elif direction == Vector2.DOWN:
		self.animation = "front"
		self.flip_h = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
