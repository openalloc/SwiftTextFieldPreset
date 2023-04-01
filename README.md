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

* [SwiftNumberPad](https://github.com/openalloc/SwiftNumberPad) - multi-platform SwiftUI component for numeric input
* [SwiftDetailer](https://github.com/openalloc/SwiftDetailer) - multi-platform SwiftUI component for editing fielded data
* [SwiftDetailerMenu](https://github.com/openalloc/SwiftDetailerMenu) - optional menu support for _SwiftDetailer_
* [SwiftCompactor](https://github.com/openalloc/SwiftCompactor) - formatters for the concise display of Numbers, Currency, and Time Intervals
* [SwiftModifiedDietz](https://github.com/openalloc/SwiftModifiedDietz) - A tool for calculating portfolio performance using the Modified Dietz method
* [SwiftNiceScale](https://github.com/openalloc/SwiftNiceScale) - generate 'nice' numbers for label ticks over a range, such as for y-axis on a chart
* [SwiftRegressor](https://github.com/openalloc/SwiftRegressor) - a linear regression tool that’s flexible and easy to use
* [SwiftSeriesResampler](https://github.com/openalloc/SwiftSeriesResampler) - transform a series of coordinate values into a new series with uniform intervals
* [SwiftSimpleTree](https://github.com/openalloc/SwiftSimpleTree) - a nested data structure that’s flexible and easy to use

And open source apps using this library (by the same author):

* [Gym Routine Tracker](https://open-trackers.github.io/grt/) - minimalist workout tracker, for the Apple Watch, iPhone, and iPad
* [Daily Calorie Tracker](https://open-trackers.github.io/dct/) - minimalist calorie tracker, for the Apple Watch, iPhone, and iPad

* [FlowAllocator](https://openalloc.github.io/FlowAllocator/index.html) - portfolio rebalancing tool for macOS
* [FlowWorth](https://openalloc.github.io/FlowWorth/index.html) - a new portfolio performance and valuation tracking tool for macOS

## License

Copyright 2023 OpenAlloc LLC

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Contributing

Contributions are welcome. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features. 

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.
