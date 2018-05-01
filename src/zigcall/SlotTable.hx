package zigcall;

/**
    Data structure for managing slots.
**/
class SlotTable<F> {
    public var length(get, null):Int;

    var callbacks:Array<F>;
    var tokens:Array<ConnectionToken>;

    public function new() {
        callbacks = new Array<F>();
        tokens = new Array<ConnectionToken>();
    }

    function get_length():Int {
        return callbacks.length;
    }

    public function add(callback:F):ConnectionToken {
        var index = callbacks.indexOf(callback);

        if (index < 0) {
            var token = new ConnectionToken({
                disconnect: tokenRemove,
                isConnected: tokenExists
            });

            callbacks.push(callback);
            tokens.push(token);

            return token;

        } else {
            return tokens[index];
        }
    }

    public function remove(callback:F) {
        var index = callbacks.indexOf(callback);

        if (index >= 0) {
            callbacks.remove(callback);
            tokens.remove(tokens[index]);
        }
    }

    public function tokenRemove(slotToken:ConnectionToken) {
        var index = tokens.indexOf(slotToken);

        if (index >= 0) {
            tokens.remove(slotToken);
            callbacks.remove(callbacks[index]);
        }
    }

    public function exists(callback:F):Bool {
        return callbacks.indexOf(callback) >= 0;
    }

    public function tokenExists(slotToken:ConnectionToken) {
        return tokens.indexOf(slotToken) >= 0;
    }

    public function iterator():Iterator<F> {
        return callbacks.iterator();
    }
}
