import Foundation

@discardableResult
public func shell(_ cmd: String, _ args: [String] = []) -> (output: String, exitCode: Int) {
    let task = Process()
    let pipe = Pipe()

    task.executableURL = URL(string: cmd)
    task.environment = ProcessInfo.processInfo.environment
    task.currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
    task.arguments = args

    task.standardOutput = pipe
    task.standardError = pipe

    var exitCode = 127
    var output = ""
    do {
        try task.run()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        exitCode = Int(task.terminationStatus)
        output = String(data: data, encoding: .utf8) ?? ""
    } catch {
        print("Failed to execute '\(cmd)': \(error)")
    }

    return (output.trimmingCharacters(in: ["\n", "\r"]), exitCode)
}

extension String {
    func shell(_ args: String...) -> String {
        let res = Shell.shell(self, args)
        return res.output
    }
}

@discardableResult
prefix func ! (_ cmd: String) -> String {
    let shellCmd = ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/bash"
    let (out, err) = shell(shellCmd, ["-c", cmd])
    print(out)
    if err != 0 {
        print("Command returned error code: \(err)")
    }
    return out
}
