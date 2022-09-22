//
//  Extension+String.swift
//  TodoApp
//
//  Created by Amini on 22/09/22.
//

import Foundation
import SwiftUI

extension String {
    func first10() -> String {
        if self.count > 10 {
            return "\(String(self.prefix(10)))..."
        }
        return self
    }
}
