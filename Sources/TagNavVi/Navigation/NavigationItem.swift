//
//  SwiftUIView 2.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

public struct NavigationItem{
    
    public init<UI:View>(_ v:UI) {
        self.view=AnyView(v)
    }
    
    public var view: AnyView
}
