package zigcall.test;

import utest.Assert;


class TestSignalP {
    public function new() {
    }

    public function testEmit() {
        var signal = new SignalP<Int>();
        var isCalled = 0;

        function callback(value:Int) {
            isCalled = value;
        }

        signal.client.connect(callback);
        signal.emit(10);

        Assert.equals(10, isCalled);
    }

    public function testConnectDisconnect() {
        var signal = new SignalP<Int>();

        function callback(value:Int) {
            Assert.fail();
        }

        Assert.isFalse(signal.isConnected(callback));

        signal.client.connect(callback);
        Assert.isTrue(signal.isConnected(callback));

        signal.client.disconnect(callback);
        Assert.isFalse(signal.isConnected(callback));

        signal.emit(123);
    }

    public function testTokenDisconnect() {
        var signal = new SignalP<Int>();

        function callback(value:Int) {
            Assert.fail();
        }

        var token = signal.client.connect(callback);
        Assert.isTrue(signal.isConnected(callback));
        Assert.isTrue(token.isConnected());

        token.disconnect();
        Assert.isFalse(signal.isConnected(callback));
        Assert.isFalse(token.isConnected());

        signal.emit(123);
    }
}
