//
//  Theme.swift
//  TodoApp
//
//  Created by Amini on 18/08/22.
//

import Foundation
import UIKit
import SwiftUI

let selectedThemeKey = "selectedThemeKey"
class ThemeSource: ObservableObject {
    @AppStorage(selectedThemeKey, store: UserDefaults(suiteName: "group.com.vree.today")) var selectedThemeAppStorage = Theme.white {
        didSet {
            print("did set")
            updateTheme()
        }
    }
    
    init() {
        updateTheme()
    }
    
    @Published var current: Theme = .white
    
    func updateTheme() {
        if let newCurrent = Theme(rawValue: selectedThemeAppStorage.rawValue) {
            current = newCurrent
        } else {
            current = .white
        }
    }
    
}

public enum Theme: String, CaseIterable {
    
    case white
    case black
    case lightBlue
    case darkBlue
    case lightOrange
    
    public var appearance: ColorScheme {
        switch self {
        case .white, .lightBlue, .lightOrange:
            return .light
        case .black, .darkBlue:
            return .dark
        }
    }
    
    public var baseColor: Color {
        switch self {
        case .white: return Color(red: 1, green: 1, blue: 1)
        case .black: return Color(red: 0, green: 0, blue: 0)
        case .lightBlue: return Color(red: 0.875, green: 0.886, blue: 0.916)
        case .darkBlue: return Color(red: 0.171, green: 0.217, blue: 0.283)
        case .lightOrange: return Color(red: 0.925, green: 0.925, blue: 0.925)
        }
    }
    
    public var primaryColor: Color {
        switch self {
        case .white: return Color(red: 0, green: 0, blue: 0)
        case .black: return Color(red: 1, green: 1, blue: 1)
        case .lightBlue: return Color(red: 0.180, green: 0.341, blue: 0.631)
        case .darkBlue: return Color(red: 0.196, green: 0.525, blue: 0.875)
        case .lightOrange: return Color(red: 0.973, green: 0.392, blue: 0.008)
        }
    }
    
    public var secondaryColor: Color {
        switch self {
        case .white: return Color(red: 0.52, green: 0.52, blue: 0.52)
        case .black: return Color(red: 0.52, green: 0.52, blue: 0.52)
        case .lightBlue: return Color(red: 0.361, green: 0.461, blue: 0.482)
        case .darkBlue: return Color(red: 0.906, green: 0.957, blue: 1)
        case .lightOrange: return Color(red: 0.424, green: 0.424, blue: 0.424)
        }
    }
}


