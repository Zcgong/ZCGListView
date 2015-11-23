//
//  LeftContentTableViewCell.h
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCGEnumClass.h"
@interface ZCGLeftContentTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (nonatomic, assign) ZCGLeftContentCellStyle cellStyle;
@property (nonatomic, assign) ZCGListViewSeparateLineStyle separateLineStyle;

- (instancetype)initWithListCellStyle:(ZCGLeftContentCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color;
- (void)changeColumnColorWithColor:(UIColor*)columnColor;
@end
