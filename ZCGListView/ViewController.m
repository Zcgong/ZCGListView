//
//  ViewController.m
//  ZCGListView
//
//  Created by LTMacMini on 15/11/17.
//  Copyright © 2015年 LTMacMini. All rights reserved.
//

#import "ViewController.h"
#import "ZCGListViewHeader.h"
@interface ViewController ()<ZCGListViewDelegate>
@property (nonatomic, strong) ZCGListView* listView;
@property (nonatomic, strong) ZCGRefreshHeader* refreshHeader;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ListViewDemo";
    UIBarButtonItem* bbt = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = bbt;
    UIBarButtonItem* bbt2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goToNext)];
    self.navigationItem.leftBarButtonItem = bbt2;
    _data = [NSMutableArray arrayWithArray:@[
                                             @[@[@"zcgong",@"000007"],@"52",@"222",@"555",@"125",@"152",@"12121"],
                                             @[@[@"zcgong",@"000007"],@"23",@"222",@"555",@"125",@"152",@"12121"],
                                             @[@[@"zcgong",@"000007"],@"14",@"222",@"555",@"125",@"152",@"12121"]
                                             ]];
    _listView = [[ZCGListView alloc]initWithFrame:CGRectMake(0, 64,  self.view.frame.size.width,  self.view.frame.size.height)
                                           titles:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]
                                         listData:_data];
    _listView.listViewDelegate = self;
    _listView.rightColumnWidth = 150;
    _listView.leftColumnWidth = 100;
    _listView.headerViewheight = 50;
    //! 这方法不能改变分割线的颜色  by Zcgong
    [_listView setSeparateLineWidth:0.5 Color:[UIColor blackColor]];
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
- (void)listView:(ZCGListView *)listView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSArray* data = [_data objectAtIndex:indexPath.row];
    //    if ([[data objectAtIndex:1] integerValue] < 20) {
    //        NSLog(@"11111111111111111");
    //        ZCGLeftContentTableViewCell* leftCell = [listView.leftContentTableView cellForRowAtIndexPath:indexPath];
    //        [leftCell setCellTextColor:[UIColor greenColor]];
    //        ZCGRightContentTableViewCell* rightCell = [listView.rightContentTableView cellForRowAtIndexPath:indexPath];
    //        NSUInteger len = rightCell.contentView.subviews.count;
    //        for (NSUInteger i = 0; i < len; i ++ ) {
    //            UIView* view = rightCell.contentView.subviews[i];
    //            if ([view isKindOfClass:[UILabel class]]) {
    //                UILabel* lable = (UILabel*)view;
    //                lable.textColor = [UIColor greenColor];
    //            }
    //        }
    //    }
    
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
