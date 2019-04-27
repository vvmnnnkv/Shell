import XCTest
@testable import Shell

final class ShellTests: XCTestCase {
    func testShell() {

        let res1 = shell("wrong_command")
        XCTAssertEqual(res1.output, "")
        XCTAssertEqual(res1.exitCode, 127)

        let res2 = shell("/bin/bash", ["-c", "echo hi; sleep 2; echo there"])
        XCTAssertEqual(res2.output, "hi\nthere")
        XCTAssertEqual(res2.exitCode, 0)
    }

    func testStringShell() {
        XCTAssertEqual("/bin/bash".shell("-c", "echo hi; echo there"), "hi\nthere")
    }

    func testBang() {
        XCTAssertEqual(!"echo hi there!", "hi there!")
        XCTAssertEqual(!"booooom!", "/bin/bash: booooom!: command not found")
    }

    static var allTests = [
        ("testShell", testShell),
        ("testStringShell", testStringShell),
        ("testBang", testBang),
    ]
}
