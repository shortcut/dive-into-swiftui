//
//  Settings.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi

struct Settings: View {
    @Binding var query: ItunesSearchQuery
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Picker(L10n.Settings.mediaType, selection: $query.mediaType) {
                    ForEach(ItunesSearchQuery.Media.allCases) { item in
                        Text(item.description)
                    }
                }
                Picker(L10n.Settings.attribute, selection: $query.attribute) {
                    ForEach(query.mediaType.allowedAttributes) { attribute in
                        Text(attribute.description)
                    }
                }
                Picker(L10n.Settings.entity, selection: $query.entity) {
                    ForEach(query.mediaType.allowedEntities) { entity in
                        Text(entity.description)
                    }
                }
                Picker(L10n.Settings.country, selection: $query.country) {
                    ForEach(ItunesSearchQuery.Country.allCases) { entity in
                        Text(entity.description)
                    }
                }
                Toggle(L10n.Settings.allowExplicit, isOn: $query.allowExplicitContent)
            }
            .toolbar {
                closeItem
            }
            .navigationBarTitle(Text(L10n.Settings.title))
        }
    }

    private var closeItem: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                Label(L10n.Settings.Toolbar.done, systemImage: "xmark")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(query: .constant(ItunesSearchQuery()))
    }
}
