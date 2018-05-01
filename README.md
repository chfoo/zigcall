ZigCall
=======

ZigCall is, yet another, a simple [Signals and Slots](https://en.wikipedia.org/wiki/Signals_and_slots) implementation of the observer pattern for the Haxe programming language.

ZigCall's feature set is intentionally limited when compared to other Haxe signal & slot libraries. Its goal is to provide a clean and minimal interface to the user.


General comparison of event dispatcher to signal and slots:

| Event Dispatcher | Signal and Slots |
|------------------|------------------|
| Events | Signals |
| Listeners | Slots |
| Dispatch | Emit |
| Add | Connect |
| Remove | Disconnect |
| String event types | Objects for each signal |
| Dispatcher uses inheritance | Emitter uses composition |
| Event object | Parameters |
| Capturing & bubbling  | None |
| Cancelling | Typically none |


Quick Start
===========

Installation
------------

Install the library:

        haxelib install zigcall


Connecting signals and slots
----------------------------

In your class that emits signals, add a `Signal` field for each signal:

```haxe
import zigcall.Signal;

class Keyboard {
    var _keyDown:Signal;
    var _keyUp:Signal;
}
```

Expose a public version of `Signal` to users:

```haxe
class Keyboard {
    // [...]
    public var keyDown(default, null):SignalClient;
    public var keyUp(default, null):SignalClient;
}
```

Initialize the fields:

```haxe
class Keyboard {
    // [...]
    public function new() {
        keyDown = _keyDown = new Signal();
        keyUp = _keyUp = new Signal();
    }
}
```

In your class that contains the slots for processing the signals, connect them:

```haxe
class KeyHandler {
    public function new() {
        // [...]
        keyboard.keyDown.connect(keyDownHandler);
        keyboard.keyUp.connect(keyUpHandler);
    }

    function keyDownHandler() {
        trace("A key was pressed down.");
    }

    function keyUpHandler() {
        trace("A key was released.");
    }
}
```

Emitting signals
----------------

Send a signal by calling `emit()`:

```haxe
class Keyboard {
    // [...]
    public function processKeyEvent() {
        // [...]
        _keyDown.emit();
    }
}
```

Disconnecting
-------------

To stop receiving signals, call `disconnect()`:

```haxe
class KeyHandler {
    // [...]
    public function dispose() {
        keyboard.keyDown.disconnect(keyDownHandler);
        keyboard.keyUp.disconnect(keyUpHandler);
    }
}
```

Parameters
----------

If you need to pass data, use the generic version `SignalP`:

```haxe
import zigcall;

typedef ClickedParams = {
    x:Int,
    y:Int
};

class MouseExample {
    public static function main() {
        var clicked = new SignalP<ClickedParams>();

        clicked.client.connect(clickedHandler);
        clicked.emit({ x: 10, y: 15 });
    }

    static function clickedHandler(params:ClickedParams) {
        trace('Clicked ${params.x} ${params.y}');
    }
}
```

Anonymous slots
---------------

If you have anonymous functions as slots, use the `ConnectionToken` provided when connecting:

```haxe
class PingedExample {
    public static function main() {
        var pinged = new Signal();

        var token = pinged.client.connect(function () {
            trace("Pinged!");
        });

        pinged.emit();
        token.disconnect();
    }
}
```

If you need to check whether something is connected, use `isConnected()`:

```haxe
class IsConnectedExample {
    public static function main() {
        // [...]
        if (mySignal.isConnected(mySlot)) {
            // [...]
        }
        if (myToken.isConnected()) {
            // [...]
        }
    }
}
```

For details, please check the examples and source code.
