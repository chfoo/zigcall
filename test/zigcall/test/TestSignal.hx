package zigcall.test;

import utest.Assert;


class TestSignal {
    public function new() {
    }

    public function testEmit() {
        var signal = new Signal();
        var isCalled = false;

        function callback() {
            isCalled = true;
        }

        signal.client.connect(callback);
        signal.emit();

        Assert.isTrue(isCalled);
    }

    public function testConnectDisconnect() {
        var signal = new Signal();

        function callback() {
            Assert.fail();
        }

        Assert.isFalse(signal.isConnected(callback));

        signal.client.connect(callback);
        Assert.isTrue(signal.isConnected(callback));

        signal.client.disconnect(callback);
        Assert.isFalse(signal.isConnected(callback));

        signal.emit();
    }

    public function testTokenDisconnect() {
        var signal = new Signal();

        function callback() {
            Assert.fail();
        }

        var token = signal.client.connect(callback);
        Assert.isTrue(signal.isConnected(callback));
        Assert.isTrue(token.isConnected());

        token.disconnect();
        Assert.isFalse(signal.isConnected(callback));
        Assert.isFalse(token.isConnected());

        signal.emit();
    }
}
