class_name StateMachine
extends Node

signal state_changed(from: StringName, to: StringName)
signal transition_started(from: StringName, to: StringName)
signal transition_finished(from: StringName, to: StringName)

@export var states_root: Node
@export var transitions_root: Node
@export var initial_state: State

enum Mode {
	IDLE,
	TRANSITIONING,
}

var mode: Mode = Mode.IDLE

var current_state: State
var current_state_name: StringName = ""
var queued_states: Array[StringName] = []

var states: Dictionary = {}
var transitions: Dictionary = {}

func _ready() -> void:
	_cache_states()
	_cache_transitions()

	if initial_state:
		current_state = initial_state
		current_state_name = initial_state.name
		current_state.enter()


func _cache_states() -> void:
	for child in states_root.get_children():
		if child is State:
			child.machine = self
			states[child.name] = child


func _cache_transitions() -> void:
	for child in transitions_root.get_children():
		if child is Transition:
			transitions[_transition_key(child.from_state, child.to_state)] = child


func add_transition(from: State, to: State, transition: Transition) -> void:
	transitions[_transition_key(from, to)] = transition


func set_initial_state(name: StringName) -> void:
	current_state_name = name
	current_state = states[name]
	current_state.enter()


func request_state(name: StringName) -> void:
	Log.d("FSM.request_state: %s" % name)
	if mode == Mode.TRANSITIONING:
		Log.v("Transitioning, cannot handle immediately")
		queued_states.append(name)
		return
	
	if current_state_name == name:
		return
	
	_change_state(name)


func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _change_state(name: StringName) -> void:
	mode = Mode.TRANSITIONING
	
	var old_name := current_state_name
	var old_state := current_state
	var new_state: State = states[name]
	var transition = transitions.get(_transition_key(old_state, new_state)) as Transition
	if transition:
		if not transition.can_transition(self, old_state, new_state):
			Log.i("Cannot transition")
			mode = Mode.IDLE
			return
	
	transition_started.emit(old_name, name)
	
	if old_state:
		old_state.exit()
	
	if transition:
		Log.v("Transitioning %s -> %s using %s" % [old_name, name, transition.name])
		await transition.run(self, old_state, new_state)
	else:
		Log.v("No transition %s -> %s" % [old_name, name])
	
	current_state = new_state
	current_state_name = name
	current_state.enter()
	
	mode = Mode.IDLE
	
	transition_finished.emit(old_name, name)
	state_changed.emit(old_name, name)
	
	if queued_states.size() > 0:
		var next = queued_states.pop_front()
		request_state(next)


func _transition_key(from: State, to: State) -> String:
	return "%s->%s" % [from.name, to.name]


func _process(delta: float) -> void:
	update(delta)
