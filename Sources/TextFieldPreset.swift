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
    private let onSelect: (PresettedItem) -> Void

    public init(_ text: Binding<String>,
                prompt: String,
                axis: Axis,
                presets: PresetsDictionary,
                @ViewBuilder buttonLabel: @escaping () -> ButtonLabel = { PresetButtonLabel() },
                @ViewBuilder pickerLabel: @escaping (PresettedItem) -> PickerLabel,
                onSelect: @escaping (PresettedItem) -> Void = { _ in })
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

    @State private var isPresented = false
    @State private var selected: PresettedItem?

    // MARK: - Views

    public var body: some View {
        HStack {
            TextField(text: $text,
                      prompt: Text(prompt),
                      axis: axis) { EmptyView() }

            Button(action: { isPresented = true },
                   label: buttonLabel)
                .buttonStyle(.borderless)
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                PresetsPicker(presets: presets,
                              onSelect: selectAction,
                              label: pickerLabel)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { isPresented = false }
                        }
                    }
            }
            .interactiveDismissDisabled() // NOTE: needed to prevent home button from dismissing sheet
        }
    }

    private func selectAction(_ item: PresettedItem) {
        isPresented = false
        text = item.text
        onSelect(item)
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
                Section("TextField with Preset") {
                    TextFieldPreset($name, prompt: "Enter name", axis: .vertical, presets: presets, pickerLabel: {
                        Text($0.description)
                    })
                }
            }
            .padding()
        }
    }

    static var previews: some View {
        TestHolder()
        // .accentColor(.orange)
    }
}
