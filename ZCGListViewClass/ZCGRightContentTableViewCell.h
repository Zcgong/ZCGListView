//
//  RightContentTableViewCell.h
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCGEnumClass.h"

@interface ZCGRightContentTableViewCell : UITableViewCell
@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, assign) CGFloat columnWidth;
@property (nonatomic, strong)  NSArray* rowData;
@property (nonatomic, assign) ZCGListViewSeparateLineStyle separateLineStyle;

- (instancetype)initWithColumnWidth:(CGFloat)columnWidth Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowData:(NSArray*)data;

//初始化方法  indicator： 用indicator来指定data中影响该cell中文本颜色的数据所在的位置
-(instancetype)initWithColumnWidth:(CGFloat)columnWidth Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowData:(NSArray *)data andIndicatorIndex:(NSInteger)indicator;

- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color;
- (void)setCellTextAlignment:(NSTextAlignment)align;
- (void)setCellTextColor:(UIColor*)color;
- (void)setCellTextFontSize:(CGFloat)fontSize;
- (void)setCellBackgroundColor:(UIColor*)bgColor;

- (void)changeColumnColorWithTag:(NSInteger)tag Color:(UIColor*)columnColor;
@end
