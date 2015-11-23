//
//  LeftContentTableViewCell.m
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import "ZCGLeftContentTableViewCell.h"

#define WIDTH  self.frame.size.width
#define HEIGHT self.frame.size.height
#define DefaultSeparateColor [UIColor blackColor]
@implementation ZCGLeftContentTableViewCell
{
    UIView* separateLineView;
    
}

- (instancetype)initWithListCellStyle:(ZCGLeftContentCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =  [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellStyle = style;
        switch (style) {
            case ZCGLeftContentCellStyleSubtitle:{
                self.nameLabel = [[UILabel alloc]init];
                self.subTitleLabel = [[UILabel alloc]init];
                [self.contentView addSubview:self.nameLabel];
                [self.contentView addSubview:self.subTitleLabel];
            }
                break;
                
            default:
                break;
        }
        self.nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLabel];
        separateLineView = [[UIView alloc]init];
        [self.contentView addSubview:separateLineView];
        
    }
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.cellStyle == ZCGLeftContentCellStyleSubtitle) {
        self.nameLabel.frame = CGRectMake(0, 0,WIDTH, HEIGHT/2);
        self.subTitleLabel.frame = CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/2);
    }else{
        self.nameLabel.frame = CGRectMake(0, 0,WIDTH, HEIGHT);
    }
    if (self.separateLineStyle == ZCGListViewSeparateLineStyleSingleLine) {
        separateLineView.frame = CGRectMake(0, HEIGHT-0.5, WIDTH, 0.5);
        separateLineView.backgroundColor = [UIColor redColor];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
//    UIView* bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bgView;
    
}
- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color {
    
    if (self.separateLineStyle == ZCGListViewSeparateLineStyleSingleLine) {
        separateLineView.backgroundColor = color;
        CGRect frame = separateLineView.frame;
        frame.size.height = width/2;
        separateLineView.frame = frame;
    }else{
        if (self.cellStyle == ZCGLeftContentCellStyleSubtitle) {
            self.subTitleLabel.layer.borderWidth = width/2;
            self.subTitleLabel.layer.borderColor = color.CGColor;
        }
        self.nameLabel.layer.borderWidth = width/2;
        self.nameLabel.layer.borderColor = color.CGColor;
    }
    
}
- (void)changeColumnColorWithColor:(UIColor*)columnColor {
    
    if (self.cellStyle == ZCGLeftContentCellStyleSubtitle) {
        self.subTitleLabel.backgroundColor = columnColor;
    }
    self.nameLabel.backgroundColor = columnColor;
}

@end
