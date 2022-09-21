//
//  SettingView.swift
//  TodoApp
//
//  Created by Amini on 19/08/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var themeSc: ThemeSource
        
    var body: some View {
        VStack {
            ZStack(alignment: .top){
                Form {
                    Section(header: header(string: "Display", foregroundColor: themeSc.current.secondaryColor),
                            footer: footer(string: "Pick to change Theme and App Icon", foregroundColor: themeSc.current.secondaryColor)) {
                            
                        ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach(Theme.allCases, id: \.self) { theme in
                                        HStack (spacing: 10) {
                                            if let imagename = theme.rawValue {
                                                if let selected = themeSc.current == theme {
                                                    IconSelection(name: imagename, selected: selected)
                                                        .environmentObject(themeSc)
                                                        .onTapGesture(perform: {
                                                            
                                                            changeTheme(theme: theme)

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
                        
                    if #available(iOS 16.1, *) {
                        ToggleActivityView()
                            .environmentObject(themeSc)
                    }

                }
                .scrollContentBackground(.hidden)
                .background(themeSc.current.baseColor)

            }
            .navigationTitle("")
       
        }
    }
    
    private func changeTheme(theme : Theme) {
        if UIApplication.shared.supportsAlternateIcons {
            print("supported Alternate Icons")
        } else {
            print("unsuppported Alternate Icons")
        }

        let appIconName = theme.rawValue

        if themeSc.current.rawValue != appIconName {
            UIApplication.shared.setAlternateIconName(appIconName) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    themeSc.selectedThemeAppStorage = theme
                    print("change icon and theme success")
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ThemeSource())
    }
}
