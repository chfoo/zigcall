package zigcall;


typedef SignalClient = ISignalClient<Void->Void>;

/**
    A signal that passes no arguments to slots.
**/
class Signal extends BaseSignal<Void->Void>{
    /**
        Emits the signal to all connected slots.
    **/
    public function emit() {
        for (slot in slots) {
            slot();
        }
    }
}
