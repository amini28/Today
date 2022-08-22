//
//  Theme.swift
//  TodoApp
//
//  Created by Amini on 18/08/22.
//

import Foundation
import UIKit
import SwiftUI

class ThemeSource: ObservableObject {
    @AppStorage("selectedTheme") var selectedThemeAppStorage = 0 {
        didSet {
            print("did set")
            updateTheme()
        }
    }
    
    init() {
        getAlternateIcons()
    }
    
    @Published var current: Tema = Tema(isLight: true, name: "White")
    
    func updateTheme() {
        if let newCurrent = tema[selectedThemeAppStorage] {
            current = newCurrent
        } else {
            current = Tema(isLight: true, name: "White")
        }
    }
    
    var iconNames: [String?] = []
    var tema: [Tema?] = []
    
    struct Tema {
        var isLight: Bool
        var name: String
        
        var baseColor: Color {
            
            if name == "White" {
                return .white
            }
            if name == "Black" {
                return .black
            }
            return Color("\(name)_baseColor")
        }
        var primaryColor: Color {
            if name == "White" {
                return .black
            }
            if name == "Black" {
                return .white
            }
            return Color("\(name)_primaryColor")
        }
        var secondaryColor: Color {
            if name == "White" || name == "Black" {
                return .gray
            }
            return Color("\(name)_secondaryColor")
        }
    }
    
    
    func getAlternateIcons() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            
            for(_, value) in alternateIcons {
                
                guard let iconList = value as? Dictionary<String, Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                
                guard let icon = iconFiles.first else { return }
                
                guard let theme = iconList["isLight"] as? Bool else { return }
                
                tema.append(Tema(isLight: theme, name: icon))
                
                iconNames.append(icon)
            }
            
        }
        
//        if let currentIcon = UIApplication.shared.alternateIconName {
//            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
//        }
        updateTheme()
    }

}

