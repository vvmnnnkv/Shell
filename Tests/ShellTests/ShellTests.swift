import XCTest
@testable import Shell

final class ShellTests: XCTestCase {
    func testShell() {

        var res1 = shell("wrong_command")
        XCTAssertEqual(res1.output, "")
        XCTAssertEqual(res1.exitCode, 127)

        var res2 = shell("/bin/bash", ["-c", "echo hi; sleep 2; echo there"])
        XCTAssertEqual(res2.output, "hi\nthere")
        XCTAssertEqual(res2.exitCode, 0)
    }

    func testStringShell() {
        XCTAssertEqual("/bin/bash".shell("-c", "echo hi; echo there"), "hi\nthere")
    }

    static var allTests = [
        ("testShell", testShell),
        ("testStringShell", testStringShell),
    ]
}
