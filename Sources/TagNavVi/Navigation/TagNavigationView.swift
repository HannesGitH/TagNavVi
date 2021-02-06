//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

public struct TagNavigationView<Tag:Hashable> : View {

    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    let tag : Tag
    var headline : AnyView?
    var withHomeButton = false
    
    public init<Content:View>(tag : Tag , @ViewBuilder _ content: () -> Content){
        self.tag = tag
        self.body = AnyView(
            TagNavigationView_(tag: self.tag, headline: self.headline, withHomeButton: self.withHomeButton){
                AnyView(content())
            }.environmentObject(NavigationStackCollection<Int>([:]))
        )
    }
    public var body: AnyView
    
}

extension TagNavigationView{
    
    public init(
        tag : Tag ,
        headline : AnyView?,
        withHomeButton: Bool,
        content: () -> AnyView
    ){
        self.tag = tag
        self.headline = headline
        self.withHomeButton = withHomeButton
        self.body = AnyView(
            TagNavigationView_(tag: self.tag, headline: self.headline, withHomeButton: self.withHomeButton){
                content()
            }.environmentObject(NavigationStackCollection<Int>([:]))
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
            content: {self.body}
        )
    }
}


//TODO: add navigationBar
struct TagNavigationView_<Tag:Hashable> : View {

    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    let tag : Tag
    
    init<Content:View>(tag : Tag , @ViewBuilder _ content: () -> Content){
        self.tag = tag
        let newStack = (
            k:tag,
            v:NavigationStack(
                tag: tag,
                NavigationItem(
                    content().environmentObject(navs)
                )
            )
        )
        navs.observeChildrenChanges().append(k:newStack.k,v:newStack.v)
    }
    var currentContent : AnyView {
        navs.dict[tag]?.currentView.view ?? AnyView(EmptyView())
    }
    var headline : AnyView?
    var withHomeButton = false
    var body: some View{
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

extension TagNavigationView_{
    
    init(
        tag : Tag ,
        headline : AnyView?,
        withHomeButton: Bool,
        content: () -> AnyView
    ){
        self.headline = headline
        self.withHomeButton = withHomeButton
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
    
    func withTitle<HeadlineV:View>(
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
