//
//  SidebarView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject var rootLoader: RootLoader
    @Binding var selectedRootItem: String?
    @Binding var selectedContentItem: ContentItem?
    
    var body: some View {
        List(selection: $selectedRootItem) {
            ForEach(Array(rootLoader.root.keys.sorted()), id: \.self) { index in
                NavigationLink(
                    destination:
                        ContentItemList(title: index,
                                        items: rootLoader.contentItems,
                                        isLoading: rootLoader.isLoadingContentItems,
                                        selectedContentItem: $selectedContentItem)
                        .onAppear {
                            rootLoader.loadContentItems(index)
                        },
                    label: {
                        Label(index.localizedCapitalized, systemImage: imageName(index)).font(.headline)
                    })
            }
        }.listStyle(SidebarListStyle())
    }
    
    private func imageName(_ key: String) -> String {
        switch key {
        case "people":
            return "person.3"
        case "starships":
            return "airplane"
        case "vehicles":
            return "car"
        case "species":
            return "ant"
        case "films":
            return "tv"
        case "planets":
            return "leaf.arrow.circlepath"
        default:
            return ""
        }
    }
}

let testLoader = RootLoader()
struct SidebarView_Previews: PreviewProvider {
    @State static var rootItem: String?
    @State static var contentItem: ContentItem?
    static var previews: some View {
        SidebarView(rootLoader: testLoader,
                    selectedRootItem: $rootItem,
                    selectedContentItem: $contentItem)
            .onAppear {
                testLoader.start()
            }
    }
}
