extends Area2D

var visible_rect: Rect2 = Rect2(0,0,0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport = self.get_viewport();
	visible_rect = viewport.get_visible_rect()
	var new_scale = remap(self.position.y,0, visible_rect.size.y, 0.2, 1.5)
	self.scale = Vector2(new_scale, new_scale)
	self.body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		print("hit")
		self.queue_free()
