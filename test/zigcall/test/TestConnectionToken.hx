package zigcall.test;

import utest.Assert;


class TestConnectionToken {
    public function new() {
    }

    public function testDisconnect() {
        var disconnectCalled = false;

        function disconnect(token:ConnectionToken) {
            disconnectCalled = true;
        }

        function isConnected(token:ConnectionToken):Bool {
            return true;
        }

        var token = new ConnectionToken({
            disconnect: disconnect,
            isConnected: isConnected
        });
        token.disconnect();

        Assert.isTrue(disconnectCalled);
    }
}
