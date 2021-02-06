//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//TODO: add navigationBar
public struct TagNavigationView<Content> : View where Content : View {

    @ObservedObject var nav: NavigationStack
    
    init(@ViewBuilder content: () -> Content){
        self.nav=NavigationStack(NavigationItem(content()))
    }

    public var body: some View{
        nav.currentView.view
    }
}
