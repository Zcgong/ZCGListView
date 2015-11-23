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
@interface ViewController ()<ZCGListViewDelegate>
@property (nonatomic, strong) ZCGListView* listView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listView = [[ZCGListView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)
                                           titles:@[@"1",@"2",@"3",@"4",@"5",@"6"]
                                         listData:@[@[@[@"zcgong",@"000007"],@"58",@"222",@"555",@"125",@"152"],@[@[@"zcgong",@"000007"],@"58",@"222",@"555",@"125",@"152"],@[@[@"zcgong",@"000007"],@"58",@"222",@"555",@"125",@"152"]]];
    _listView.delegate = self;
    _listView.rightColumnWidth = 150;
    _listView.leftColumnWidth = 100;
    _listView.headerViewheight = 50;
    _listView.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    _listView.rightViewBackgroundColor = [UIColor blackColor];
    _listView.leftViewBackgroundColor = [UIColor blackColor];
    _listView.rightTextColor = [UIColor whiteColor];
    _listView.leftTextColor = [UIColor whiteColor];
    _listView.headerTextColor = [UIColor orangeColor];
    _listView.backgroundColor = [UIColor blackColor];
    _listView.headerViewBackgroundColor = [UIColor colorWithRed:0.1673 green:0.5995 blue:1.0 alpha:1.0];
//    [_listView.leftLabel removeFromSuperview];
//    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
//    label1.text = @"邮票";
//    label1.textColor = [UIColor orangeColor];
//    UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 25)];
//    label2.text = @"000008";
//    label2.textColor = [UIColor orangeColor];
//    [_listView.leftHeadView addSubview:label1];
//    [_listView.leftHeadView addSubview:label2];
    [_listView setSeparateLineWidth:1 Color:[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0]];
   
    [self.view addSubview:_listView];
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

@end
