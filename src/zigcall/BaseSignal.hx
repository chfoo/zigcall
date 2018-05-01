package zigcall;


/**
   Base class for a signal that can be emitted.

   This class is not useful by itself. Use an appropriate subclass that
   provides the `emit()` implementation with the appropriate parameters.
**/
class BaseSignal<F> implements ISignalClient<F> {
    /**
        Signal client instance for users to connect slots.
    **/
    public var client(get, never):ISignalClient<F>;

    var slots:SlotTable<F>;

    public function new() {
        slots = new SlotTable();
    }

    function get_client():ISignalClient<F> {
        return this;
    }

    /**
        Connects a slot to this signal.
    **/
    public function connect(callback:F):ConnectionToken {
        return slots.add(callback);
    }

    /**
        Disconnects a slot from this signal.
    **/
    public function disconnect(callback:F) {
        slots.remove(callback);
    }

    /**
        Returns whether a slot is connected to this signal.
    **/
    public function isConnected(callback:F):Bool {
        return slots.exists(callback);
    }

    // Implementors must define an appropriate emit() function.
}
