package zigcall.test;

import utest.Assert;


class TestSlotTable {
    public function new() {
    }

    public function testAddRemove() {
        var table = new SlotTable<Void->Void>();

        function callback() {
        }

        Assert.equals(0, table.length);

        var token = table.add(callback);
        Assert.equals(1, table.length);
        Assert.isTrue(table.exists(callback));
        Assert.isTrue(table.tokenExists(token));

        table.remove(callback);
        Assert.equals(0, table.length);
        Assert.isFalse(table.exists(callback));
        Assert.isFalse(table.tokenExists(token));
    }

    public function testTokenRemove() {
        var table = new SlotTable<Void->Void>();

        function callback() {
        }

        var token = table.add(callback);
        Assert.isTrue(table.tokenExists(token));

        table.tokenRemove(token);
        Assert.isFalse(table.exists(callback));
        Assert.isFalse(table.tokenExists(token));
    }

    public function testDoubleCalls() {
        var table = new SlotTable<Void->Void>();

        function callback() {
        }

        var token = table.add(callback);
        var token2 = table.add(callback);
        Assert.equals(1, table.length);
        Assert.equals(token, token2);

        table.remove(callback);
        table.remove(callback);
        table.tokenRemove(token);
        table.tokenRemove(token);

        Assert.equals(0, table.length);
    }
}
