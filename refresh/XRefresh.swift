//
//  XRefresh.swift
//  lejia
//
//  Created by X on 15/9/25.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

import UIKit

typealias RefreshBlock = ()->Void

typealias RefreshProgressBlock = (UIView,Double)->Void
typealias RefreshViewBlock = (UIView)->Void

//状态
enum XRefreshState : NSInteger{
    case Normal
    case Pulling
    case Refreshing
    case WillRefreshing
    case End
}

private var headerV: XHeaderRefreshView?
private var footerV: XFooterRefreshView?

private var RefreshHeaderViewKey : CChar?
private var RefreshFooterViewKey : CChar?

var XRefreshHeaderProgressBlock:RefreshProgressBlock?
var XRefreshHeaderBeginBlock:RefreshViewBlock?
var XRefreshHeaderEndBlock:RefreshViewBlock?

var XRefreshFooterProgressBlock:RefreshProgressBlock?
var XRefreshFooterBeginBlock:RefreshViewBlock?
var XRefreshFooterEndBlock:RefreshViewBlock?
var XRefreshFooterNoMoreBlock:RefreshViewBlock?

var XRefreshEnable = true

func XRefreshConfig(headerProgress:RefreshProgressBlock?,headerBegin:RefreshViewBlock?,headerEnd:RefreshViewBlock?,footerProgress:RefreshProgressBlock?,footerBegin:RefreshViewBlock?,footerEnd:RefreshViewBlock?,noMore:RefreshViewBlock?)
{
    XRefreshHeaderProgressBlock = headerProgress
    XRefreshHeaderBeginBlock = headerBegin
    XRefreshHeaderEndBlock = headerEnd
    
    XRefreshFooterProgressBlock = footerProgress
    XRefreshFooterBeginBlock = footerBegin
    XRefreshFooterEndBlock = footerEnd
    XRefreshFooterNoMoreBlock = noMore
}

extension UIScrollView
{

    func headRefreshHide()
    {
        if(self.headRefresh != nil)
        {
            self.headRefresh!.hide()
        }
    }
    
    func headRefreshShow()
    {
        if(self.headRefresh != nil)
        {
            self.headRefresh!.show()
        }
    }
    
    func footRefreshHide()
    {
        if(self.footRefresh != nil)
        {
            self.footRefresh!.hide()
        }
    }
    
    func footRefreshShow()
    {
        if(self.footRefresh != nil)
        {
            self.footRefresh!.show()
        }
    }
    
    func setHeaderRefresh(block:RefreshBlock)
    {
        let headerRefreshView:XHeaderRefreshView=XHeaderRefreshView(frame: CGRectZero)
        self.addSubview(headerRefreshView)
        self.headRefresh=headerRefreshView
        headerRefreshView.block = block
        
    }
    
    weak var headRefresh:XHeaderRefreshView?
        {
        get
        {
            return objc_getAssociatedObject(self, &RefreshHeaderViewKey) as? XHeaderRefreshView
        }
        set(newValue) {
            self.willChangeValueForKey("RefreshHeaderViewKey")
            objc_setAssociatedObject(self, &RefreshHeaderViewKey, newValue,
            .OBJC_ASSOCIATION_ASSIGN)
            self.didChangeValueForKey("RefreshHeaderViewKey")
            
        }
    }
    
    weak var footRefresh:XFooterRefreshView?
        {
        get
        {
            return objc_getAssociatedObject(self, &RefreshFooterViewKey) as? XFooterRefreshView
        }
        set(newValue) {
            self.willChangeValueForKey("RefreshFooterViewKey")
            objc_setAssociatedObject(self, &RefreshFooterViewKey, newValue,
                .OBJC_ASSOCIATION_ASSIGN)
            self.didChangeValueForKey("RefreshFooterViewKey")
            
        }
    }
    
    func beginHeaderRefresh()
    {
        if(self.headRefresh != nil)
        {
            self.headRefresh!.beginRefresh()
        }
       
    }
    
    func endHeaderRefresh()
    {
        if(self.headRefresh != nil)
        {
            self.headRefresh!.endRefresh()
        }
    }
    
    
    func setFooterRefresh(block:RefreshBlock)
    {
        let footerRefreshView:XFooterRefreshView=XFooterRefreshView(frame: CGRectMake(0, 0, self.frame.width, 0))
        self.addSubview(footerRefreshView)
        self.footRefresh=footerRefreshView
        footerRefreshView.block=block
    }
    
    func beginFooterRefresh()
    {
        if(self.footRefresh != nil)
        {
           self.footRefresh!.beginRefresh()
        }
        
    }
    
    func endFooterRefresh()
    {
        if(self.footRefresh != nil)
        {
            self.footRefresh!.endRefresh()
        }
        
    }
    
    func LoadedAllDate()
    {
        if(self.footRefresh != nil)
        {
            self.footRefresh!.end = true
            self.footRefresh!.setState(.End)
            
        }
        
    }
    
    
}



