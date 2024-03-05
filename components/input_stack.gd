extends Object
class_name TimedInputQueue
# technically, pop is O(n), not O(1). This isn't a leetcode problem, so it doesn't really matter

var input_lifespan = 0.1  # lifespan of inputs in seconds. Inputs that are "older" than this number will be thrown out
var _inputs: Array[String] = []
var _times: Array[float] = []

func push(input: String):
	_inputs.append(input)
	_times.append(Time.get_unix_time_from_system())

# may return an empty string if the queue is empty
func pop() -> String:
	var currentTime = Time.get_unix_time_from_system()
	while len(_times) > 0:
		var time = _times.pop_front()
		var input = _inputs.pop_front()
		
		if time + input_lifespan >= currentTime:
			return input
		
	return ""
