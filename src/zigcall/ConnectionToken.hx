package zigcall;


typedef ConnectionTokenCallbacks = {
    var disconnect:ConnectionToken->Void;
    var isConnected:ConnectionToken->Bool;
};


/**
    Handle to a connection by a signal and slot.
**/
class ConnectionToken {
    var callbacks:ConnectionTokenCallbacks;

    public function new(callbacks:ConnectionTokenCallbacks) {
        this.callbacks = callbacks;
    }

    /**
        Disconnects the slot from the signal.
    **/
    public function disconnect() {
        callbacks.disconnect(this);
    }

    /**
        Returns whether the slot is connected to the signal.
    **/
    public function isConnected():Bool {
        return callbacks.isConnected(this);
    }
}
