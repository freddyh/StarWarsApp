//
//  PersonDetailView.swift
//  Star Wars Peeps
//
//  Created by Freddy Hernandez Jr on 8/23/20.
//

import SwiftUI
import star_wars_api

struct PersonDetailView: View {
    let person: Person
    var body: some View {
        VStack {
            Text(person.id)
            Text(person.birth_year)
            Text(person.eye_color)
            Text(person.gender)
        }
    }
}

//struct PersonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetailView()
//    }
//}
