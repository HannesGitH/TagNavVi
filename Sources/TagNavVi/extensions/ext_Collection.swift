//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import Foundation

public extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
