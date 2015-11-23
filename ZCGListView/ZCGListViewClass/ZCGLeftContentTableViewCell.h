//
//  LeftContentTableViewCell.h
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCGLeftContentTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *nameLabel;
- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color;
- (void)changeColumnColorWithColor:(UIColor*)columnColor;
@end
