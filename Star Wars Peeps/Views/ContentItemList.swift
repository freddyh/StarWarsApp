//
//  ContentItemList.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import SwiftUI

struct ContentItemList: View {
    let title: String
    var items: [ContentItem]
    var isLoading: Bool
    @Binding var selectedContentItem: ContentItem?
    var body: some View {
        List(selection: $selectedContentItem) {
            ForEach(items) {
                item in
                NavigationLink(
                    destination: ContentItemDetailView(item: item),
                    tag: item,
                    selection: $selectedContentItem,
                    label: {
                        Text(item.id)
                    })
            }
        }
        .overlay(
            ProgressView().opacity(isLoading ? 1 : 0)
        )
        .navigationTitle(title.localizedCapitalized)
    }
}

//struct ContentItemList_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentItemList()
//    }
//}
