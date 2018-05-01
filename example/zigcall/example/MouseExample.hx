package zigcall.example;

import zigcall.SignalP;


typedef ClickedParams = {
    x:Int,
    y:Int
};


class Mouse {
    public var clicked(default, null):SignalClientP<ClickedParams>;

    var _clicked:SignalP<ClickedParams>;

    public function new() {
        clicked = _clicked = new SignalP<ClickedParams>();
    }

    public function processClicks() {
        _clicked.emit({ x: 10, y: 15 });
    }
}


class ClickHandler {
    var mouse:Mouse;

    public function new(mouse:Mouse) {
        this.mouse = mouse;

        mouse.clicked.connect(clickedHandler);
    }

    function clickedHandler(params:ClickedParams) {
        trace('Clicked ${params.x} ${params.y}');
    }

    public function dispose() {
        mouse.clicked.disconnect(clickedHandler);
    }
}


class MouseExample {
    public static function main() {
        var mouse = new Mouse();
        var handler = new ClickHandler(mouse);

        mouse.processClicks();
        handler.dispose();
    }
}
