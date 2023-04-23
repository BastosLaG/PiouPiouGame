extends ParallaxLayer

export(float) var bckg_speed = -35

func _process(delta) -> void:
	self.motion_offset.x += bckg_speed * delta
