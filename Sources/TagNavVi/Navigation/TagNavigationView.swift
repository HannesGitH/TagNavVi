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
                    content().environmentObject(navs)
                )
            )
        )
    }
    var headline : AnyView?
    var withHomeButton = false
    public var body: some View{
        VStack{
            if let hl = headline {
                TagNavigationBar(tag: tag, withHomeButton : withHomeButton){
                    hl
                }
            }
            navs.dict[tag]?.currentView.view ?? AnyView(EmptyView())
        }
    }
    
    public mutating func withTitle<HeadlineV:View>(
        withHomeButton : Bool = false,
        @ViewBuilder _ headline: @escaping () -> HeadlineV
    )->some View{
        self.headline = AnyView(headline())
        self.withHomeButton = withHomeButton
        return self
    }
    
}
