//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//TODO: add navigationBar
public struct TagNavigationView<Tag:Hashable,Content:View> : View {

    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    let tag : Tag
    
    public init(tag : Tag , @ViewBuilder content: () -> Content){
        
        self.tag = tag
        /*navs = */navs.observeChildrenChanges().append(
            k: tag,
            v: NavigationStack(
                tag: tag,
                NavigationItem(
                    content()
                )
            )
        )
    }

    public var body: some View{
        navs.dict[tag]?.currentView.view ?? AnyView(EmptyView())
    }
}
