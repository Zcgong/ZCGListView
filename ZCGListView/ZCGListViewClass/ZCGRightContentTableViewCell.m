//
//  RightContentTableViewCell.m
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import "ZCGRightContentTableViewCell.h"
@interface ZCGRightContentTableViewCell()

@end
@implementation ZCGRightContentTableViewCell
{
    NSMutableArray* columnLabels;
    NSInteger tapCount;
}

- (instancetype)initWithColumnWidth:(CGFloat)columnWidth Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowData:(NSArray*)data{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.columns = data.count;
        self.rowData = data;
        self.columnWidth = columnWidth;
        columnLabels = [NSMutableArray new];
        [self initUI];
        tapCount = 0;
    }
    return self;
}
- (void)initUI {
    if (_columns == 0) {
        return;
    }
    for (int idx = 0; idx < _columns; idx ++) {
        UILabel* label = [[UILabel alloc]init];
        label.tag = 500+idx;
        [columnLabels addObject:label];
        [self.contentView addSubview:label];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (NSInteger idx = 0; idx < _columns; idx ++) {
        UILabel* label = columnLabels[idx];
        label.frame = CGRectMake(_columnWidth*idx, 0, _columnWidth, self.frame.size.height);
        label.numberOfLines = 0;
        label.text = self.rowData[idx];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    UIView* bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bgView;
}
- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color {
    for (UILabel* label  in columnLabels) {
        label.layer.borderWidth = width/2;
        label.layer.borderColor = color.CGColor;
    }
}
- (void)setCellTextAlignment:(NSTextAlignment)align {
    for (UILabel* label  in columnLabels) {
        label.textAlignment = align;
    }
}
- (void)setCellTextColor:(UIColor*)color {
    for (UILabel* label  in columnLabels) {
        label.textColor = color;
    }
}
- (void)setCellTextFontSize:(CGFloat)fontSize {
    for (UILabel* label  in columnLabels) {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
}
- (void)setCellBackgroundColor:(UIColor*)bgColor {
    for (UILabel* label  in columnLabels) {
        label.backgroundColor = bgColor;
    }
}

- (void)changeColumnColorWithTag:(NSInteger)tag Color:(UIColor*)columnColor {
    for (UILabel* label  in columnLabels) {
        if (label.tag == tag) {
            label.backgroundColor = columnColor;
        }
    }
}
@end
