class_name DropBehaviorSwap extends DropBehavior

func evaluate(zone: DropZone, dropped_area: Area2D) -> DropPlan:
	var plan := DropPlan.new()
	
	var prev_zone := dropped_area.get_parent() as DropZone
	if !prev_zone:
		return plan
	var spot := DropUtils.closest_spot(prev_zore, dropped_area)
	
	var result := DropUtils.evaluate_drop_target(zone, dropped_area, false)
	if not result.can_drop:
		return plan
	plan.can_drop = true
	plan.drop_target = result.target
	
	if plan.drop_target and plan.drop_target.occupant and plan.drop_target.occupant != dropped_area:
		if spot:
			plan.actions.append(ActionRelocate.new(plan.drop_target.occupant, spot))
		else:
			plan.can_drop = false 
	
	return plan
