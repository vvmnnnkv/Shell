# Shell

Execute command from Swift:

```swift

import Shell

let res = shell("/bin/ls", ["-la"])
print("output:\n\(res.output)\n\nexit code: \(res.exitCode)")

print("/bin/ls".shell("-la"))

```
