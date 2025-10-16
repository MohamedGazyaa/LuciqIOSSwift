// CheckboxToggleStyle.swift
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(configuration.isOn ? Color.accentColor : Color.secondary, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if configuration.isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(3)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                }

                configuration.label
                    .foregroundColor(.primary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Checkbox"))
        .accessibilityValue(Text(configuration.isOn ? "Checked" : "Unchecked"))
    }
}
