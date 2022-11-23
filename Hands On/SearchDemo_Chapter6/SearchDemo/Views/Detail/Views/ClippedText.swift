//
//  ClippedText.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

private struct FullTextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        switch (value, nextValue()) {
        case (.some, .some(let update)),
            (.none, .some(let update)):
            value = update
        case (.none, .none), (.some, .none):
            break
        }
    }
}

private struct ClippedTextHeightKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        switch (value, nextValue()) {
        case (.some, .some(let update)),
            (.none, .some(let update)):
            value = update
        case (.none, .none), (.some, .none):
            break
        }
    }
}

struct ClippedText: View {
    @State private var clippedHeight: CGFloat?
    @State private var fullHeight: CGFloat?
    @State private var expanded = false
    @State private var hasShownMore = false

    let text: AttributedString
    let previewLimit: Int

    init(_ text: String, previewLimit: Int = 5) {
        self.text = AttributedString(text)
        self.previewLimit = previewLimit
    }

    init(_ text: AttributedString, previewLimit: Int = 5) {
        self.text = text
        self.previewLimit = previewLimit
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .lineLimit(expanded ? nil : previewLimit)
                .background {
                    clippedReader
                }
                .background {
                    fullReader
                }
            if showMoreButton {
                Button(expanded ? L10n.ClippedText.less : L10n.ClippedText.more) {
                    withAnimation {
                        expanded.toggle()
                        hasShownMore = true
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .onPreferenceChange(FullTextHeightKey.self) { update in
            fullHeight = update
        }
        .onPreferenceChange(ClippedTextHeightKey.self) { update in
            clippedHeight = update
        }
    }

    private var showMoreButton: Bool {
        hasShownMore || (fullHeight ?? 0) > (clippedHeight ?? 0)
    }

    private var fullReader: some View {
        Text(text)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: FullTextHeightKey.self,
                                    value: proxy.size.height)
                }
            }
            .opacity(0)
    }

    private var clippedReader: some View {
        GeometryReader { proxy in
            Color.clear.opacity(0.25)
                .preference(key: ClippedTextHeightKey.self,
                            value: proxy.size.height)
        }
    }
}

struct ClippedText_Previews: PreviewProvider {
    // swiftlint:disable line_length
    static let text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Est sit amet facilisis magna etiam tempor orci eu. Dolor morbi non arcu risus quis. Pharetra vel turpis nunc eget lorem dolor. Risus sed vulputate odio ut enim blandit. Dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu. Vitae congue eu consequat ac felis donec. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Sodales ut etiam sit amet nisl. Enim lobortis scelerisque fermentum dui faucibus. Imperdiet sed euismod nisi porta lorem mollis aliquam. Leo in vitae turpis massa sed. Elit ullamcorper dignissim cras tincidunt. Nullam vehicula ipsum a arcu cursus. Tincidunt vitae semper quis lectus nulla at. Et leo duis ut diam quam nulla porttitor massa id. Massa massa ultricies mi quis hendrerit. Id ornare arcu odio ut sem nulla pharetra.

Feugiat scelerisque varius morbi enim nunc faucibus a pellentesque. Bibendum neque egestas congue quisque egestas diam in arcu cursus. Amet justo donec enim diam vulputate. In nibh mauris cursus mattis molestie a iaculis. Habitant morbi tristique senectus et netus et. Sit amet dictum sit amet justo donec enim diam vulputate. Faucibus purus in massa tempor nec feugiat. Sed odio morbi quis commodo odio aenean sed adipiscing diam. Elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at. Ut ornare lectus sit amet est placerat in egestas. Cursus euismod quis viverra nibh cras pulvinar mattis nunc. Fermentum posuere urna nec tincidunt praesent semper feugiat nibh. Cursus mattis molestie a iaculis. Aenean sed adipiscing diam donec adipiscing tristique risus nec feugiat. Sit amet massa vitae tortor condimentum lacinia.

Fermentum posuere urna nec tincidunt. Lorem ipsum dolor sit amet consectetur adipiscing elit. Enim nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. Morbi quis commodo odio aenean sed adipiscing diam. Mauris rhoncus aenean vel elit scelerisque mauris. Vel turpis nunc eget lorem dolor sed viverra ipsum nunc. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus. Convallis posuere morbi leo urna molestie. Viverra tellus in hac habitasse platea. Interdum posuere lorem ipsum dolor sit.

Pretium nibh ipsum consequat nisl vel pretium lectus quam. Porta non pulvinar neque laoreet suspendisse interdum. Feugiat pretium nibh ipsum consequat nisl. Sit amet porttitor eget dolor morbi non arcu risus quis. Sollicitudin tempor id eu nisl nunc mi ipsum. Enim tortor at auctor urna. Fames ac turpis egestas sed. Nisi quis eleifend quam adipiscing vitae proin sagittis nisl rhoncus. Fermentum iaculis eu non diam phasellus vestibulum lorem sed. Sed faucibus turpis in eu mi bibendum. Pharetra pharetra massa massa ultricies mi quis hendrerit dolor. Urna condimentum mattis pellentesque id nibh tortor. Purus in massa tempor nec. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Vel eros donec ac odio tempor orci. Elit pellentesque habitant morbi tristique senectus et. Amet est placerat in egestas erat imperdiet sed euismod nisi.

Proin libero nunc consequat interdum varius sit. Et pharetra pharetra massa massa. Leo urna molestie at elementum eu facilisis. Sagittis aliquam malesuada bibendum arcu vitae elementum curabitur. Nulla aliquet enim tortor at. Neque volutpat ac tincidunt vitae semper. Etiam sit amet nisl purus in mollis nunc sed id. Risus sed vulputate odio ut enim blandit volutpat. Consectetur a erat nam at. Sapien eget mi proin sed. Sit amet justo donec enim diam vulputate. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat.

"""
    // swiftlint:enable line_length

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ClippedText(text)

                ClippedText("Short Text")
            }
            .padding()
        }
    }
}
