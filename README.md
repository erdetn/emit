# emit

The `emit` module provides functionality to handle Unix signals in V. Signals are software interrupts that provide a way to handle asynchronous events, such as exceptions or external interrupts, in a program. This allows users to define custom behavior for various Unix signals by associating signal handlers (functions) with specific signals.

`emit` provides only one function - the `on` funcion. The `on` function allows you to specify a handler function for a given signal.

Syntax:
```v
pub fn on(trigger Trigger, slot fn (trigger int))
```

### Parameters

* `trigger`: The signal to handle, specified using the `Trigger` enum.
* `slot`: The handler function (inspired from Qt) to call when the specified signal is received. The function should accept an int parameter representing the signal number.

#### enum `Trigger`

The `Trigger` enum represents different types of Unix signals that can be handled:
* `abort`: Triggered by `SIGABRT`, used to signal an abnormal termination.
* `floating`: Triggered by `SIGFPE`, used to signal an erroneous arithmetic operation (e.g., division by zero).
* `illegal`: Triggered by `SIGILL`, used to signal an illegal instruction.
* `interrupt`: Triggered by `SIGINT`, used to signal an interrupt from the user (e.g., pressing Ctrl+C).
* `segmentation`: Triggered by `SIGSEGV`, used to signal an invalid memory reference.
* `terminated`: Triggered by `SIGTERM`, used to signal a termination request.

### Notes
However, you can check the buildin function to handle the [signals](https://modules.vlang.io/os.html#signal_opt).

### Example:
```v
module main 

import emit 
import time

fn main() {
	emit.on(.interrupt, fn(trigger int){
		println("Program is interrupted. Code: ${trigger}")
		exit(trigger)
	})

	emit.on(.terminated, fn(trigger int) {
		println("Program is terminated.")
		exit(trigger)
	})

	for  {
		time.sleep(time.second)
	}
}
```