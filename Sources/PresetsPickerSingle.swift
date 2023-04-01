//
//  PresetsPickerSingle.swift
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

public struct PresetsPickerSingle<Key, PresettedItem, Label>: View
    where Key: Hashable & CustomStringConvertible,
    PresettedItem: PresettableItem,
    Label: View
{
    public typealias PresetsDictionary = OrderedDictionary<Key, [PresettedItem]>

    // MARK: - Parameters

    private let presets: PresetsDictionary
    private let onSelect: (PresettedItem) -> Void
    private let label: (PresettedItem) -> Label

    public init(presets: PresetsDictionary,
                onSelect: @escaping (PresettedItem) -> Void,
                label: @escaping (PresettedItem) -> Label)
    {
        self.onSelect = onSelect
        self.presets = presets
        self.label = label
    }

    // MARK: - Locals

    @State private var selected: PresettedItem?

    // MARK: - Views

    public var body: some View {
        platformView {
            ForEach(presets.elements, id: \.key) { element in
                Section(header: Text(element.key.description)) {
                    ForEach(element.value, id: \.self) { item in
                        label(item)
                        #if os(watchOS)
                            .onTapGesture {
                                selected = item
                            }
                        #endif
                    }
                }
            }
        }
        .onChange(of: selected) { val in
            guard let val else { return }
            onSelect(val)
        }
    }

    #if os(watchOS)
        private func platformView(content: () -> some View) -> some View {
            List {
                content()
            }
        }
    #endif

    #if !os(watchOS)
        private func platformView(content: () -> some View) -> some View {
            List(selection: $selected) {
                content()
            }
        }
    #endif
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
                PresetsPickerSingle(presets: presets) { _ in

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
