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
    typealias OnSelect = (Key, PresettedItem) -> Void

    // MARK: - Parameters

    private let presets: PresetsDictionary
    @Binding private var showPresets: Bool
    private let onSelect: OnSelect
    private let label: (PresettedItem) -> Label

    init(presets: PresetsPicker.PresetsDictionary,
         showPresets: Binding<Bool>,
         onSelect: @escaping OnSelect,
         @ViewBuilder label: @escaping (PresettedItem) -> Label)
    {
        self.presets = presets
        _showPresets = showPresets
        self.onSelect = onSelect
        self.label = label
    }

    // MARK: - Views

    var body: some View {
        List {
            ForEach(presets.keys, id: \.self) { key in // .sorted(by: <)
                Section(header: Text(key.description)) {
                    ForEach(presets[key]!, id: \.self) { value in // .sorted(by: <)
                        Button {
                            onSelect(key, value)
                            showPresets = false
                        } label: {
                            label(value)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { showPresets = false }
            }
        }
    }
}

struct PresetsPicker_Previews: PreviewProvider {
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
        var body: some View {
            NavigationStack {
                PresetsPicker(presets: presets, showPresets: $showPresets) {
                    print("\(#function): Selected \($0) \($1)")
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
