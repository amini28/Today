//
//  Tabs.swift
//  TodoApp
//
//  Created by Amini on 17/08/22.
//

import SwiftUI

struct Tab {
    var title: String
}

struct Tabs: View {
    
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    
    @EnvironmentObject var themeSc: ThemeSource
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack (alignment: .center) {
                    HStack (alignment: .lastTextBaseline) {
                        ForEach(0..<tabs.count, id:\.self) { row in
                                Text(tabs[row].title)
                                    .font(row == selectedTab ? .title : .callout)
                                    .fontWeight(row == selectedTab ? .bold : .light)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(row == selectedTab ? themeSc.current.primaryColor : themeSc.current.secondaryColor)
                                    .textCase(.uppercase)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)

                        }
                        .onChange(of: selectedTab) { target in
                            withAnimation {
                                proxy.scrollTo(target)
                            }
                        }
                    }
                }
                .frame(width: geoWidth)                
            }
        }
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(fixed: false,
             tabs: [.init(title: "Yesterday"),
                    .init(title: "Today"),
                    .init(title: "Tomorrow")],
             geoWidth: UIScreen.main.bounds.width,
             selectedTab: .constant(1))
    }
}
