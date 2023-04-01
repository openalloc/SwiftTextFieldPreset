//
//  PresetsPickerMulti.swift
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

// TODO: replace with @available
#if !os(watchOS)

    public struct PresetsPickerMulti<Key, PresettedItem, Label>: View
        where Key: Hashable & CustomStringConvertible,
        PresettedItem: PresettableItem,
        Label: View
    {
        public typealias PresetsDictionary = OrderedDictionary<Key, [PresettedItem]>

        // MARK: - Parameters

        @Binding private var selected: Set<PresettedItem>
        private let presets: PresetsDictionary
        private let label: (PresettedItem) -> Label

        public init(selected: Binding<Set<PresettedItem>>,
                    presets: PresetsDictionary,
                    label: @escaping (PresettedItem) -> Label)
        {
            _selected = selected
            self.presets = presets
            self.label = label
        }

        // MARK: - Views

        public var body: some View {
            List(selection: $selected) {
                ForEach(presets.elements, id: \.key) { element in
                    Section(header: Text(element.key.description)) {
                        ForEach(element.value, id: \.self) { item in
                            label(item)
                        }
                    }
                }
            }
            #if os(iOS)
            // force edit mode
            .environment(\.editMode, .constant(.active))
            #endif
            .toolbar {
                Button(action: selectAllAction) { Text("Select All") }
                Button(action: clearAction) { Text("Clear All") }
            }
        }

        private func selectAllAction() {
            presets.forEach { $0.value.forEach { selected.insert($0) } }
        }

        private func clearAction() {
            selected.removeAll()
        }
    }

    struct PresetsPickerMulti_Previews: PreviewProvider {
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
            @State var selected: Set<String> = .init()
            var body: some View {
                NavigationStack {
                    PresetsPickerMulti(selected: $selected, presets: presets) {
                        Text($0.text)
                    }
                }
            }
        }

        static var previews: some View {
            TestHolder()
        }
    }

#endif
