# SwiftTextFieldPreset

_A multi-platform SwiftUI component for text input with presets support_

Available as an open source library to be incorporated in SwiftUI apps.

_SwiftTextFieldPreset_ is part of the [OpenAlloc](https://github.com/openalloc) family of open source Swift software tools.

## Features

Text Field | Presets Picker
:---:|:---:
![](https://github.com/openalloc/SwiftTextFieldPreset/blob/main/Images/TextField.png)  |  ![](https://github.com/openalloc/SwiftTextFieldPreset/blob/main/Images/PresetsPicker.png)

* Builds on existing `TextField` component
* Presently targeting .macOS(.v13), .iOS(.v16), .watchOS(.v9)
* Only Apple's _Collections_ as an external dependency

## Installation

In your `Package.swift`:

To package `.dependencies` add

```swift
.package(url: "https://github.com/openalloc/SwiftTextFieldPreset.git", .upToNextMajor(from: "1.1.2")),
```

To product `.dependencies` add

```swift
.product(name: "TextFieldPreset", package: "SwiftTextFieldPreset"),
```

## Example

A simple example where the presets are `String` type:

```swift
import SwiftUI
import TextFieldPreset
import Collections

struct MyView: View {
    let presets: OrderedDictionary = [
        "Machine/Free Weights": [
            "Abdominal",
            "Arm Curl",
        ],
        "Bodyweight": [
            "Crunch",
            "Jumping-jack",
        ],
    ]
    
    @State var name: String = "New Exercise"
    
    var body: some View {
        Form {
            TextFieldPreset($name, prompt: "Enter name", axis: .vertical, presets: presets, pickerLabel: {
                Text($0.description)
            })
        }
    }
}
```

Note that presets can be more than `String`, such as `struct`s with additional values that can used to populate your target value/object via the `onSelect` callback.

## TODO

Please submit pull requests if you'd like to tackle any of these. Thanks!

* Image in this README
* Usage documentation in this README
* See if earlier versions of platforms can be supported

## See Also

This library is a member of the _OpenAlloc Project_.

* [_OpenAlloc_](https://openalloc.github.io) - product website for all the _OpenAlloc_ apps and libraries
* [_OpenAlloc Project_](https://github.com/openalloc) - Github site for the development project, including full source code

## License

Copyright 2023 OpenAlloc LLC

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Contributing

Contributions are welcome. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features. 

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.
