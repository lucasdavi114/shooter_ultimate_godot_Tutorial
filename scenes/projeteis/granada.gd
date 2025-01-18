extends RigidBody2D

const speed: int = 750

func explosion():
	$granadeAnimation.play("explosion")
