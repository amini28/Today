//
//  SettingView.swift
//  TodoApp
//
//  Created by Amini on 19/08/22.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var themeSc: ThemeSource
    
    var body: some View {
        VStack {
            ZStack(alignment: .top){
                Form {
                    Section(header: Text("Display").foregroundColor(themeSc.current.secondaryColor),
                            footer: Text("Pick to change Theme and App Icon").foregroundColor(themeSc.current.secondaryColor)) {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(0 ..< themeSc.tema.count, id: \.self) { i in
                                    HStack (spacing: 10) {
                                        if let imagename = themeSc.tema[i]?.name {
                                            if let selected = themeSc.selectedThemeAppStorage == i {
                                                IconSelection(name: imagename, selected: selected)
                                                    .environmentObject(themeSc)
                                                    .onTapGesture(perform: {
    //                                                    let iName = self.themeSc.iconNames.firstIndex(of: UIApplication.shared.alternateIconName)
                                        
                                                        print(themeSc.selectedThemeAppStorage)
                                                        
    //                                                    if themeSc.selectedThemeAppStorage != iName {

                                                            UIApplication.shared.setAlternateIconName(self.themeSc.tema[i]?.name, completionHandler: {
                                                                error in
                                                                if let error = error {
                                                                    print(error.localizedDescription)
                                                                } else {
                                                                    print("Success")
                                                                }
                                                            })

                                                            themeSc.selectedThemeAppStorage = i
                                                            print("the color ::: \(themeSc.current.primaryColor)")

    //                                                    }
                                                    })
                                                    
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(height: 120)
                        }
                    }
                    .listRowBackground(themeSc.current.secondaryColor.opacity(0.1))
                    
                    Section {
                        Label("About", systemImage: "exclamationmark.circle.fill")
                    }
                    .foregroundColor(themeSc.current.primaryColor)
                    .listRowBackground(themeSc.current.secondaryColor.opacity(0.1))
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .background(themeSc.current.baseColor)
            }
            .navigationTitle("")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ThemeSource())
    }
}
