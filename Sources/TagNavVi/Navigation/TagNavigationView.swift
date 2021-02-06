//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//TODO: add navigationBar
public struct TagNavigationView<Tag:Hashable> : View {

    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    let tag : Tag
    
    public init<Content:View>(tag : Tag , @ViewBuilder _ content: () -> Content){
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
    var currentContent : AnyView {
        navs.dict[tag]?.currentView.view ?? AnyView(EmptyView())
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
            currentContent
        }
    }
    
}

extension TagNavigationView{
    
    public init(
        tag : Tag ,
        headline : AnyView,
        withHomeButton: Bool,
        content: () -> AnyView
    ){
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
    
    public func withTitle<HeadlineV:View>(
        withHomeButton : Bool = false,
        @ViewBuilder _ headline: @escaping () -> HeadlineV
    )->some View{
        return TagNavigationView(
            tag: self.tag,
            headline : AnyView(headline()),
            withHomeButton: withHomeButton,
            content: {self.currentContent}
        )
    }
}
