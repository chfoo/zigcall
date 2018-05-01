package zigcall.example;

import zigcall.Signal;


class Keyboard {
    public var keyDown(default, null):SignalClient;
    public var keyUp(default, null):SignalClient;

    var _keyDown:Signal;
    var _keyUp:Signal;

    public function new() {
        keyDown = _keyDown = new Signal();
        keyUp = _keyUp = new Signal();
    }

    public function processKeyEvent() {
        _keyDown.emit();
        _keyUp.emit();
    }
}


class KeyHandler {
    var keyboard:Keyboard;

    public function new(keyboard:Keyboard) {
        this.keyboard = keyboard;

        keyboard.keyDown.connect(keyDownHandler);
        keyboard.keyUp.connect(keyUpHandler);
    }

    function keyDownHandler() {
        trace("A key was pressed down.");
    }

    function keyUpHandler() {
        trace("A key was released.");
    }

    public function dispose() {
        keyboard.keyDown.disconnect(keyDownHandler);
        keyboard.keyUp.disconnect(keyUpHandler);
    }
}


class KeyboardExample {
    public static function main() {
        var keyboard = new Keyboard();
        var handler = new KeyHandler(keyboard);

        keyboard.processKeyEvent();
        handler.dispose();
    }
}
