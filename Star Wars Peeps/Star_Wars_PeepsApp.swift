//
//  Star_Wars_PeepsApp.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/3/20.
//

import SwiftUI

@main
struct Star_Wars_PeepsApp: App {
    @StateObject var rootLoader = RootLoader()
    @State var selectedRootItem: String? = "starships"
    @State var selectedContentItem: ContentItem?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SidebarView(rootLoader: rootLoader,
                            selectedRootItem: $selectedRootItem,
                            selectedContentItem: $selectedContentItem)
                
                if let rootItem = self.selectedRootItem {
                    ContentItemList(title: rootItem,
                                    items: rootLoader.contentItems,
                                    isLoading: rootLoader.isLoadingContentItems,
                                    selectedContentItem: $selectedContentItem)
                } else {
                    Text("Select a Root Item")
                }
                
                if let selectedItem = self.selectedContentItem {
                    ContentItemDetailView(item: selectedItem)
                } else {
                    Text("Select an item")
                }
                
            }
            .onAppear(perform: {
                rootLoader.start(contentItemsKey: selectedRootItem)
            })
        }
    }
}
