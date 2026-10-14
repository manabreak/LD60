extends Node

const ENABLE_DEBUG := true

enum Level {
	VERBOSE,
	DEBUG,
	INFO,
	WARN,
	ERROR
}

static func v(message: Variant, tag: String = "") -> void:
	if not ENABLE_DEBUG:
		return
	
	_print(Level.VERBOSE, message, tag, Color.GRAY)

static func d(message: Variant, tag: String = "") -> void:
	if not ENABLE_DEBUG:
		return

	_print(Level.DEBUG, message, tag)


static func i(message: Variant, tag: String = "") -> void:
	_print(Level.INFO, message, tag, Color.AQUAMARINE)


static func w(message: Variant, tag: String = "") -> void:
	_print(Level.WARN, message, tag, Color.ORANGE)


static func e(message: Variant, tag: String = "") -> void:
	_print(Level.ERROR, message, tag, Color.RED)


static func _print(level: int, message: Variant, explicit_tag: String, color: Color = Color.WHITE) -> void:
	var color_start := "[color=%s]" % color.to_html()
	var color_end = "[/color]"
	
	var stack := get_stack()

	# 0 = _print
	# 1 = d/i/w/e
	# 2 = caller
	var caller: Dictionary = stack[2] if stack.size() > 2 else {}

	var source: String = caller.get("source", "")
	var tag := explicit_tag

	if tag.is_empty():
		tag = _extract_script_name(source)
	
	tag = tag.rpad(24, " ")
	
	var timestamp := _timestamp()
	var level_prefix := _level_prefix(level)

	print_rich("%s %s %s/%s  %s %s" % [
		color_start,
		timestamp,
		level_prefix,
		tag,
		message,
		color_end
	])


static func _timestamp() -> String:
	var datetime := Time.get_datetime_dict_from_system()
	var millis := Time.get_ticks_msec() % 1000

	return "%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
		datetime.year,
		datetime.month,
		datetime.day,
		datetime.hour,
		datetime.minute,
		datetime.second,
		millis
	]


static func _extract_script_name(path: String) -> String:
	if path.is_empty():
		return "Unknown"

	return path.get_file().get_basename()


static func _level_prefix(level: int) -> String:
	match level:
		Level.VERBOSE:
			return "V"

		Level.DEBUG:
			return "D"

		Level.INFO:
			return "I"

		Level.WARN:
			return "W"

		Level.ERROR:
			return "E"

	return "?"
