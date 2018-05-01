package zigcall;


typedef SignalClientP<P> = ISignalClient<P->Void>;

/**
    A signal that passes one argument to a slot.
**/
class SignalP<P> extends BaseSignal<P->Void> {
    /**
        Emits the signal to all connected slots.
    **/
    public function emit(item:P) {
        for (slot in slots) {
            slot(item);
        }
    }
}
