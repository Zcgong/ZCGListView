//
//  LeftContentTableViewCell.m
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import "ZCGLeftContentTableViewCell.h"

@implementation ZCGLeftContentTableViewCell
{
    BOOL taped;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height);
    self.nameLabel.userInteractionEnabled = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    UIView* bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bgView;
}
- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color {
    
        self.nameLabel.layer.borderWidth = width/2;
        self.nameLabel.layer.borderColor = color.CGColor;
}
- (void)changeColumnColorWithColor:(UIColor*)columnColor {
    self.nameLabel.backgroundColor = columnColor;
}

@end
