module emit

#include <signal.h>

pub enum Trigger {
	abort        = C.SIGABRT
	floating     = C.SIGFPE
	illegal      = C.SIGILL
	interrupt    = C.SIGINT
	segmentation = C.SIGSEGV
	terminated    = C.SIGTERM
}

fn C.signal(int, fn(int)) fn(int)

pub fn on(trigger Trigger, slot fn (trigger int)) {
	unsafe {
		_ := C.signal(int(trigger), slot)
	}
}
