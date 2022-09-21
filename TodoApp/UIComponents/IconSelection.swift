//
//  IconSelection.swift
//  TodoApp
//
//  Created by Amini on 20/08/22.
//

import SwiftUI

struct IconSelection: View {
    
    @EnvironmentObject var themeSc: ThemeSource

    var name: String
    var selected: Bool
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "\(name).png") ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(name)
                .font(.system(size: 14, weight: .semibold, design: .default))
                .frame(maxWidth: 100)
                .foregroundColor(themeSc.current.primaryColor)
        }
        .overlay{
            Image(systemName: "checkmark.square.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(selected ? themeSc.current.primaryColor : .clear)
                .offset(x: 24, y: -36)
        }
    }
}

struct IconSelection_Previews: PreviewProvider {
    static var previews: some View {
        IconSelection(name: "white", selected: true)
            .environmentObject(ThemeSource())
    }
}
