//
//  PresetButtonLabel.swift
//
// Copyright 2023 OpenAlloc LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Collections
import SwiftUI

public struct PresetButtonLabel: View {
    private let systemImageName: String

    public init(systemImageName: String = "line.3.horizontal.decrease") {
        self.systemImageName = systemImageName
    }

    public var body: some View {
        Image(systemName: systemImageName)
            .imageScale(.large)
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.tint)
    }
}

struct PresetButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        PresetButtonLabel()
            .accentColor(.green)
    }
}
