//
//  InfoLabel.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

struct InfoLabelWidthKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        switch (value, nextValue()) {
        case (.some(let initial), .some(let update)):
            value = max(initial, update)
        case (.none, .some(let update)):
            value = update
        case (.none, .none), (.some, .none):
            break
        }
    }
}

struct InfoLabelWidthEnvironment: EnvironmentKey {
    static var defaultValue: CGFloat?
}

extension EnvironmentValues {
    var infoLabelWidth: CGFloat? {
        get { self[InfoLabelWidthEnvironment.self] }
        set { self[InfoLabelWidthEnvironment.self] = newValue }
    }
}

extension InfoLabel where Content == Text {
    init?(label: String, content: String?) {
        guard let content else { return nil }
        self.label = label
        self.content = { Text(content) }
    }
}

struct InfoLabel<Content: View>: View {

    let label: String
    @Environment(\.infoLabelWidth) var labelWidth
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @ViewBuilder private(set) var content: () -> Content

    var body: some View {
        let layout = dynamicTypeSize <= .xLarge ? AnyLayout(HStackLayout(alignment: .firstTextBaseline)) :
            AnyLayout(VStackLayout(alignment: .leading))
        layout {
            Text(label)
                .font(.caption)
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .overlay {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: InfoLabelWidthKey.self, value: proxy.size.width)
                    }
                }
                .frame(width: labelWidth,
                       alignment: .leading)
                .foregroundColor(.secondary)
            content()
                .frame(maxWidth: .infinity,
                       alignment: .leading)
        }
        .multilineTextAlignment(.leading)
    }
}

struct InfoLabel_Previews: PreviewProvider {
    static var previews: some View {
        InfoLabel(label: "Test", content: "Test")
            .previewLayout(.sizeThatFits)
    }
}
