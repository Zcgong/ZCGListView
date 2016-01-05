//
//  ZCGRefreshHeader.m
//  ZCGListView
//
//  Created by LTMacMini on 16/1/5.
//  Copyright © 2016年 LTMacMini. All rights reserved.
//

#import "ZCGRefreshHeader.h"
@interface ZCGRefreshHeader ()
{
    CGFloat lastPosition;
    CGFloat contentHeight;
    CGFloat headerHeight;
    
    UILabel* headerLabel;
    UIView* headerView;
    UIImageView* headerImageView;
    UIActivityIndicatorView* activityView;
}
@end
@implementation ZCGRefreshHeader
- (instancetype)init{
    self = [super init];
    if (self) {
        _titleLoading=kRefreshHeaderTitleRefreshing;
        _titlePullDown=kRefreshHeaderTitlePullDown;
        _titleRelease=kRefreshHeaderTitleRelease;
        
    }
    return self;
}
- (void)header
{
    _isRefresh = NO;
    lastPosition = 0;
    headerHeight = 35;
    float scrollWidth = _scrollView.frame.size.width;
    float imageWidth = 13;
    float imageHeight = headerHeight;
    float labelWidth = 130;
    float labelHeight = headerHeight;
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -headerHeight-10, [UIScreen mainScreen].bounds.size.width, headerHeight)];
    [_scrollView addSubview:headerView];
    [_scrollView bringSubviewToFront:headerView];
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2, 0, labelWidth, labelHeight)];
    [headerView addSubview:headerLabel];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text=_titlePullDown;
    headerLabel.font=[UIFont systemFontOfSize:14];
    
    headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight)];
    [headerView addSubview:headerImageView];
    headerImageView.image=[UIImage imageNamed:@"down"];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame=CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight);
    [headerView addSubview:activityView];
    
    activityView.hidden=YES;
    headerImageView.hidden=NO;
    
    // 为_scrollView设置KVO的观察者对象，keyPath为contentOffset属性
    [_scrollView.leftContentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_scrollView.rightContentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

/**
 *  当属性的值发生变化时，自动调用此方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
    // 获取_scrollView的contentSize
    contentHeight = _scrollView.contentSize.height;
    
    // 判断是否在拖动_scrollView
    if (_scrollView.leftContentTableView.dragging || _scrollView.rightContentTableView.dragging) {
        int currentPostion;
        if (_scrollView.leftContentTableView.dragging) {
            currentPostion = _scrollView.leftContentTableView.contentOffset.y;
        }else{
            currentPostion = _scrollView.rightContentTableView.contentOffset.y;
        }
        // 判断是否正在刷新  否则不做任何操作
        if (!_isRefresh) {
            [UIView animateWithDuration:0.3 animations:^{
                // 当currentPostion 小于某个值时 变换状态
                if (currentPostion<-headerHeight*1.5) {
                    headerLabel.text=_titleRelease;
                    headerImageView.transform = CGAffineTransformMakeRotation(M_PI);
                }else {
                    int currentPostion = _scrollView.contentOffset.y;
                    // 判断滑动方向 以让“松开以刷新”变回“下拉可刷新”状态
                    if (currentPostion - lastPosition > 5) {
                        lastPosition = currentPostion;
                        headerImageView.transform = CGAffineTransformMakeRotation(M_PI*2);
                        headerLabel.text=_titlePullDown;
                    }else if (lastPosition - currentPostion > 5) {
                        lastPosition = currentPostion;
                    }
                }
            }];
        }
    }else {
        // 进入刷新状态
        if ([headerLabel.text isEqualToString:_titleRelease]) {
            [self beginRefreshing];
        }
    }
}

/**
 *  开始刷新操作  如果正在刷新则不做操作
 */
- (void)beginRefreshing
{
    if (!_isRefresh) {
        _isRefresh=YES;
        headerLabel.text=_titleLoading;
        headerImageView.hidden=YES;
        activityView.hidden=NO;
        [activityView startAnimating];
        
        // 设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point= _scrollView.contentOffset;
            if (point.y>-headerHeight*1.5) {
                _scrollView.contentOffset=CGPointMake(0, point.y-headerHeight*1.5);
            }
            _scrollView.contentInset=UIEdgeInsetsMake(headerHeight*1.5, 0, 0, 0);
        }];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"isRefreshing" object:nil];
    }
    
}

/**
 *  关闭刷新操作  请加在UIScrollView数据刷新后，如[tableView reloadData];
 */
- (void)endRefreshing
{
    _isRefresh=NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point= _scrollView.contentOffset;
            if (point.y!=0) {
                _scrollView.contentOffset = CGPointMake(0, point.y+headerHeight*1.5 + 64);
            }
            headerLabel.text=_titlePullDown;
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            headerImageView.hidden=NO;
            headerImageView.transform = CGAffineTransformMakeRotation(M_PI*2);
            [activityView stopAnimating];
            activityView.hidden=YES;
        }];
    });
}

- (void)dealloc
{
    [_scrollView.leftContentTableView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView.rightContentTableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end

