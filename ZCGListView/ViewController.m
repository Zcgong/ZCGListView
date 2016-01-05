//
//  ViewController.m
//  ZCGListView
//
//  Created by LTMacMini on 15/11/17.
//  Copyright © 2015年 LTMacMini. All rights reserved.
//

#import "ViewController.h"
#import "ZCGRightContentTableViewCell.h"
#import "ZCGLeftContentTableViewCell.h"
#import "ZCGRefreshHeader.h"
@interface ViewController ()<ZCGListViewDelegate>
@property (nonatomic, strong) ZCGListView* listView;
@property (nonatomic, strong) ZCGRefreshHeader* refreshHeader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ListViewDemo";
    UIBarButtonItem* bbt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = bbt;
    UIBarButtonItem* bbt2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goToNext)];
    self.navigationItem.leftBarButtonItem = bbt2;
    _listView = [[ZCGListView alloc]initWithFrame:CGRectMake(0, 64,  self.view.frame.size.width,  self.view.frame.size.height)
                                           titles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]
                                         listData:@[@[@[@"zcgong",@"000007"],@"58",@"222",@"555",@"125",@"152",@"12121"],@[@[@"zcgong",@"000007"],@"58",@"222",@"555",@"125",@"152",@"12121"],@[@[@"zcgong",@"000007"],@"58",@"222",@"555",@"125",@"152",@"12121"]]];
    _listView.listViewDelegate = self;
    _listView.rightColumnWidth = 150;
    _listView.leftColumnWidth = 100;
    _listView.headerViewheight = 50;
    _refreshHeader = [[ZCGRefreshHeader alloc]init];
    _refreshHeader.scrollView = _listView;
    [_refreshHeader header];
    [self refresh];
    
    [self.view addSubview:_listView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshNotification:) name:@"isRefreshing" object:nil];
}
- (void)goToNext {
    
}
- (void)refresh{
    // 是否在进入该界面的时候就开始进入刷新状态
    [_refreshHeader beginRefreshing];
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2];
}
- (void)endRefresh{
    [_refreshHeader endRefreshing];
}
- (void)refreshNotification:(NSNotification*)noti {
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:2];
}
- (void)listView:(ZCGListView *)listView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectCell:%ld",indexPath.row);
    
}

- (CGFloat)listView:(ZCGListView *)listView heightForRowIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"isRefreshing" object:nil];
}
@end
