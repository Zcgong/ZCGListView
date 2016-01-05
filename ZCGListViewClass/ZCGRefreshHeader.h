//
//  ZCGRefreshHeader.h
//  ZCGListView
//
//  Created by LTMacMini on 16/1/5.
//  Copyright © 2016年 LTMacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZCGListView.h"

@class ZCGRefreshHeader;
#define kRefreshHeaderTitleRefreshing @"正在载入……"
#define kRefreshHeaderTitlePullDown @"下拉可刷新"
#define kRefreshHeaderTitleRelease @"松开以刷新"

@interface ZCGRefreshHeader : NSObject
@property(nonatomic,strong) ZCGListView* scrollView;

@property(nonatomic,copy) NSString *titleLoading;
@property(nonatomic,copy) NSString *titlePullDown;
@property(nonatomic,copy) NSString *titleRelease;
@property (nonatomic, assign) BOOL isRefresh;
/**
 *  header's init
 */
-(void)header;

/**
 *  begin refresh
 */
-(void)beginRefreshing;

/**
 *  end refresh
 */
-(void)endRefreshing;


@end
