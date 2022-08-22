//
//  Extension+View.swift
//  TodoApp
//
//  Created by Amini on 20/08/22.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: ()-> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func placeholder(_ text: String,
                     when show: Bool,
                     alignment: Alignment = .leading) -> some View {
        
        placeholder(when: show, alignment: alignment) {
            Text(text).foregroundColor(.gray)
        }
    }
    
    func navigationBarColor(titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(titleColor: titleColor))
    }
    
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
    }
}

