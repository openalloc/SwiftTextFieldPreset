//
//  TextFieldPreset.swift
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

public struct TextFieldPreset<ButtonLabel, GroupKey, PresettedItem, PickerLabel>: View
    where ButtonLabel: View,
    GroupKey: Hashable & CustomStringConvertible,
    PresettedItem: PresettableItem,
    PickerLabel: View
{
    public typealias PresetsDictionary = OrderedDictionary<GroupKey, [PresettedItem]>

    // MARK: - Parameters

    @Binding private var text: String
    private let prompt: String
    private let axis: Axis
    private let presets: PresetsDictionary
    private let buttonLabel: () -> ButtonLabel
    private let pickerLabel: (PresettedItem) -> PickerLabel
    private let onSelect: (GroupKey, PresettedItem) -> Void

    public init(_ text: Binding<String>,
                prompt: String,
                axis: Axis,
                presets: PresetsDictionary,
                @ViewBuilder buttonLabel: @escaping () -> ButtonLabel = { PresetButtonLabel() },
                @ViewBuilder pickerLabel: @escaping (PresettedItem) -> PickerLabel,
                onSelect: @escaping (GroupKey, PresettedItem) -> Void = { _, _ in })
    {
        _text = text
        self.prompt = prompt
        self.axis = axis
        self.presets = presets
        self.buttonLabel = buttonLabel
        self.pickerLabel = pickerLabel
        self.onSelect = onSelect
    }

    // MARK: - Locals

    @State private var showPresetNames = false

    // MARK: - Views

    public var body: some View {
        HStack {
            TextField(text: $text,
                      prompt: Text(prompt),
                      axis: axis) { EmptyView() }
//            #if os(iOS)
//                .lineLimit(5)
//            #endif

            Button(action: { showPresetNames = true }, label: buttonLabel)
                .buttonStyle(.borderless)
        }
        .sheet(isPresented: $showPresetNames) {
            NavigationStack {
                PresetsPicker(presets: presets,
                              showPresets: $showPresetNames,
                              onSelect: { groupKey, presetValue in
                                  // set the hard-coded name from the preset
                                  text = presetValue.text
                                  // allow caller to assign other fields
                                  onSelect(groupKey, presetValue)
                              },
                              label: pickerLabel)
            }
            .interactiveDismissDisabled() // NOTE: needed to prevent home button from dismissing sheet
        }
    }
}

struct TextFieldWithPresets_Previews: PreviewProvider {
    struct TestHolder: View {
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
            .padding()
        }
    }

    static var previews: some View {
        TestHolder()
            .accentColor(.orange)
    }
}
