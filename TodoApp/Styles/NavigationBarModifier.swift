//
//  NavigationBarModifier.swift
//  TodoApp
//
//  Created by Amini on 20/08/22.
//

import Foundation
import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    var titleColor: UIColor?
    
    init(titleColor: UIColor?) {
        let coloredApperance = UINavigationBarAppearance()
//        coloredApperance.configureWithTransparentBackground()
        coloredApperance.titleTextAttributes = [.foregroundColor : titleColor ?? .black]
        coloredApperance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor : titleColor ?? .black]
        
        UINavigationBar.appearance().standardAppearance = coloredApperance
        UINavigationBar.appearance().compactAppearance = coloredApperance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredApperance
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
        }
    }
}
