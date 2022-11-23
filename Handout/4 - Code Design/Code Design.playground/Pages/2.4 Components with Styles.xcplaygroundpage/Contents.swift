//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 # Components with Styles
 */

/*:
 For components that need to be configurable, and may want to have configuration that conflicts with the environment, we can  use a style configure all of those view via the environment.
 */

//: First we need to define what we'll be storing in the style
protocol FancyQuoteStyle {
    var quoteColor: Color? { get }
    var quoteFont: Font { get }
}

//: Then we create concrete style implementations for the various styles
struct StandardFancyQuoteStyle: FancyQuoteStyle {
    let quoteColor: Color? = .secondary
    let quoteFont = Font.body
}

struct LargeFancyQuoteStyle: FancyQuoteStyle {
    var quoteColor: Color? = nil
    var quoteFont = Font.largeTitle
}

//: And we can create some helpers to make it easier to apply these styles
extension FancyQuoteStyle where Self == StandardFancyQuoteStyle {
    static var standard: some FancyQuoteStyle { StandardFancyQuoteStyle() }
}

extension FancyQuoteStyle where Self == LargeFancyQuoteStyle {
    static var large: some FancyQuoteStyle { LargeFancyQuoteStyle() }
}


//: After that, we need to add an environment value to propagate the style to all child views
extension EnvironmentValues {
    var fancyQuoteStyle: FancyQuoteStyle? {
        get { self[FancyQuotedStyleKey.self] }
        set { self[FancyQuotedStyleKey.self] = newValue }
    }
}

struct FancyQuotedStyleKey: EnvironmentKey {
    static var defaultValue: FancyQuoteStyle?
}

extension View {
    func fancyQuoteStyle(_ style: FancyQuoteStyle?) -> some View {
        self.environment(\.fancyQuoteStyle, style)
    }
}

struct FancyQuoted: ViewModifier {
    //: We can read the current quote style from the environment
    @Environment(\.fancyQuoteStyle) private var quoteStyle

    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            if let quoteStyle {
                if let quoteColor = quoteStyle.quoteColor {
                    //: if we have a style, and a color we apply both
                    openQuote
                        .font(quoteStyle.quoteFont)
                        .foregroundColor(quoteColor)
                    content
                    closeQuote
                        .font(quoteStyle.quoteFont)
                        .foregroundColor(quoteColor)
                } else {
                    //: If we just have a font, we apply that
                    openQuote
                        .font(quoteStyle.quoteFont)
                    content
                    closeQuote
                        .font(quoteStyle.quoteFont)
                }
            } else {
                //: otherwise, we don't apply anything, so that we inherit values from the environemnt
                openQuote
                content
                closeQuote
            }
        }
    }

    private var openQuote: some View {
        Image(systemName: "quote.opening")
    }

    private var closeQuote: some View {
        Image(systemName: "quote.closing")
    }
}


extension View {
    func withFancyQuotes() -> some View {
        self.modifier(FancyQuoted())
    }
}

struct ComponentsView: View {
    let string = "Test"
    let key = LocalizedStringKey("Localized")

    var body: some View {
        VStack {
            Text("Test")
                .withFancyQuotes()
                .font(.body)
                .fancyQuoteStyle(.large)
            //: We can locally override a style
            Rectangle()
                .frame(width: 200, height: 20)
                .withFancyQuotes()
            Text(string)
                .withFancyQuotes()
                .font(.largeTitle)
                .fancyQuoteStyle(.none)
            //: Or clear a style to follow the local environment
            Text(key)
                .withFancyQuotes()
                .foregroundColor(.red)
                .fancyQuoteStyle(.standard)
                .font(.body.bold())
            Text(key)
                .redacted(reason: .placeholder)
                .withFancyQuotes()
        }
        .fancyQuoteStyle(.standard)
        //: We can now style all of the quotes without styling the text
    }
}

PlaygroundPage.current.setLiveView(ComponentsView().padding())


//: [Next](@next)
