//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 ## Explicit Identity
 
 Explicit identity is powerful and flexible, but does require that someone, somewhere to assign an identifier.

 One form of explicit identity you may already be used to is pointer identity, which is used throughout UIKit and AppKit. Since UIViews and NSViews are classes, they each have a unique pointer to their memory allocation. The pointer is a natural source of explicit identity. If two views share the same pointer, we can guarantee that they are really the same view.
 
 But SwiftUI doesn't use pointers because SwiftUI views are value types, represented as structs instead of classes. Value types do not have a canonical reference that SwiftUI can use as a persistent identity for its views. Instead, SwiftUI relies on other forms of explicit identity.
 
 1. the id(_:) modifier
 2. ForEach's (and List's) id parameter or the collection’s elements must conform to Identifiable
 
 Now, let's recognize these explicit identities in the following examples!
 */

struct ExplicitIdentityExample1: View {
    @State var items = ["Apple", "Mango", "Orange"]

    var body: some View {
        ZStack(alignment: .top) {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            plusButton
        }
        .frame(width: 400, height: 700, alignment: .top)
    }
    
    var plusButton: some View {
        HStack(alignment: .center) {
            Button {
                withAnimation {
                    items.append("Bananas")
                }
            } label: {
                Image(systemName: "plus")
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ExplicitIdentityExample1())

/*:
 One property of good identifiers is **uniqueness**. Each identifier should map to a single view. This ensures that animations look great, performance is smooth, and the dependencies of your hierarchy are reflected in the most efficient form.
 
 Another property is **stability**. An identifier that isn't stable can result in a shorter view lifetime; a new identifier represents a new item with a new lifetime. And having a stable identifier also helps performance.
 */

class ItemModel: Identifiable {
    let title: String
    // The problem is that this identifier isn't stable, so anytime the data changes, we get a new identifier.
//    var id: UUID { UUID() }
    let id: UUID
    
    init(title: String) {
        self.title = title
        self.id = UUID()
    }
}

struct ExplicitIdentityExample2: View {
    @State var items: [ItemModel] = [.init(title: "Apple"), .init(title: "Mango"), .init(title: "Orange")]

    var body: some View {
        ZStack(alignment: .top) {
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            HStack(alignment: .center) {
                Button {
                    withAnimation {
                        items.insert(.init(title: "Banana"), at: 0)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
        }
        .frame(width: 400, height: 700, alignment: .top)
    }
}

PlaygroundPage.current.setLiveView(ExplicitIdentityExample2())

/*:
 We don't have to explicitly identify every view, just the ones we need to refer to elsewhere in the code, for example in a ScrollViewReader.
 */

struct ExplicitIdentityExample3: View {
    let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                Button("Jump to #8") {
                    withAnimation {
                        value.scrollTo(8, anchor: .top)
                    }
                }
                .padding()

                // The simplest form of ForEach is one that takes a constant range. SwiftUI is going to use the offset in this range to identify the views produced by the view builder.
                ForEach(0..<100) { i in
                    Text("Example \(i)")
                        .font(.title)
                        .frame(width: 200, height: 200)
                        .background(colors[i % colors.count])
                        .id(i)
                }
            }
        }
        .frame(width: 400, height: 700, alignment: .top)
    }
}

PlaygroundPage.current.setLiveView(ExplicitIdentityExample3())

//: [Next](@next)
