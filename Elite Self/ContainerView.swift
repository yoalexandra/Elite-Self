//
//  ContainerView.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 23.12.2020.
//

//enum Translation {
//
//    static var welcomeToMyApp: LocalizedStringKey {
//        return "Welcome into my app"
//    }
//
//    static var startByTappingThisButton: LocalizedStringKey {
//        return "Start by tapping this button"
//    }
//
//    static var startBrowsing: LocalizedStringKey {
//        return "Start browsing"
//    }
//}

import SwiftUI

struct ContainerView: View {
    var body: some View {
        //Text(Translation.welcomeToMyApp)
        Text("Hello, world!")
            .foregroundColor(.accentColor)
            .padding()
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
