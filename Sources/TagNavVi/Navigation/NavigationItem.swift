//
//  SwiftUIView 2.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

struct NavigationItem{
    
    init<UI:View>(_ v:UI) {
        self.view=AnyView(v)
    }
    
    var view: AnyView
}
