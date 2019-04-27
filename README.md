# Shell

Execute command from Swift:

```swift

import Shell

// dull function
let res = shell("/bin/ls", ["-la"])
print("output:\n\(res.output)\n\nexit code: \(res.exitCode)")

// string extension
print("/bin/ls".shell("-la"))

// bang prefix func
!"ls -la"

```
