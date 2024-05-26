extends AnimatedSprite2D

var direction = Vector2.ZERO
var last_direction = Vector2.ZERO

var acceleration = Vector2.ZERO

var SPEED: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):

	if event is InputEventKey:
		print(last_direction)
		match event.keycode:
			KEY_RIGHT:
				if last_direction == Vector2.LEFT:
					self.animation = "front"
					self.frame = 0
				else:
					self.animation = "running"
					self.flip_h = false
					
				last_direction = Vector2.RIGHT
			KEY_UP:
				self.animation = "front"
			KEY_DOWN:
				self.animation = "front"
			KEY_LEFT:
				if last_direction == Vector2.RIGHT:
					self.animation = "front"
					self.frame = 0
				else:
					self.animation = "running"
					self.flip_h = true
					
				last_direction = Vector2.LEFT
					
	if event.is_pressed():
		self.play()
	else:
		self.stop()
		


func _physics_process(delta):
	
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	translate(direction * SPEED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
