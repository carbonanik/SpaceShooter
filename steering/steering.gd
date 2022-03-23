extends Node

const DEFAULT_MASS: = 20.0
const DEFAULT_MAX_SPEED: = 400.0
const DEFAULT_SLOW_RADIOUS: = 200.0

static func follow(
		velocity: Vector2,
		gloabal_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		mass: = DEFAULT_MASS
	) -> Vector2:
		
	var desired_velocity: = (target_position - gloabal_position).normalized() * max_speed
	var steering: = (desired_velocity - velocity) / mass
	
	return velocity + steering

static func arrive_to(
		velocity: Vector2,
		gloabal_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		slow_radious: = DEFAULT_SLOW_RADIOUS,
		mass: = DEFAULT_MASS
	) -> Vector2:
	
	var to_target: = gloabal_position.distance_to(target_position)
	var desired_velocity: = (target_position - gloabal_position).normalized() * max_speed
	
	if to_target < slow_radious:
		desired_velocity *= (to_target / slow_radious) * 0.8 + 0.2
	
	var steering: = (desired_velocity - velocity) / mass
	
	return velocity + steering
