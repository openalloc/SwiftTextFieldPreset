//
//  PresetsPicker.swift
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
import os
import SwiftUI

struct PresetsPicker<Key, PresettedItem, Label>: View
    where Key: Hashable & CustomStringConvertible,
    PresettedItem: PresettableItem,
    Label: View
{
    typealias PresetsDictionary = OrderedDictionary<Key, [PresettedItem]>

    // MARK: - Parameters

    let presets: PresetsDictionary
    let onSelect: (PresettedItem) -> Void
    let label: (PresettedItem) -> Label

    // MARK: - Views

    var body: some View {
        List {
            ForEach(presets.elements, id: \.key) { element in
                Section(header: Text(element.key.description)) {
                    ForEach(element.value, id: \.self) { item in
                        Button(action: { onSelect(item) },
                               label: { label(item) })
                    }
                }
            }
        }
    }
}

struct PresetsPickerSingle_Previews: PreviewProvider {
    struct TestHolder: View {
        let presets: OrderedDictionary = [
            "Machine/Free Weights": [
                "Abdominal",
                "Arm Curl",
                "Arm Ext",
            ],
            "Bodyweight": [
                "Crunch",
                "Jumping-jack",
                "Jump",
            ],
        ]

        @State var showPresets = false
        @State var selected: String?
        var body: some View {
            NavigationStack {
                PresetsPicker(presets: presets) { _ in

                } label: {
                    Text($0.text)
                }
            }
        }
    }

    static var previews: some View {
        TestHolder()
    }
}
