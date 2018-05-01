package zigcall;

import utest.Runner;
import utest.ui.Report;


class TestAll {
    public static function main() {
        var runner = new Runner();
        runner.addCases(zigcall.test);
        Report.create(runner);
        runner.run();
    }
}
