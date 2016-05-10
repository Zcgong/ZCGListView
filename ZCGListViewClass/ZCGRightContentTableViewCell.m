//
//  RightContentTableViewCell.m
//  LeaderWorkGather
//
//  Created by zhengcg on 15/5/15.
//  Copyright (c) 2015年 zhengcg. All rights reserved.
//

#import "ZCGRightContentTableViewCell.h"
#import "MITColorTools.h"

#define WIDTH  self.frame.size.width
#define HEIGHT self.frame.size.height
#define DefaultSeparateColor [UIColor blackColor]


@interface ZCGRightContentTableViewCell()

@end
@implementation ZCGRightContentTableViewCell
{
    NSMutableArray* columnLabels;
    NSInteger tapCount;
    UIView* separateLineView;
}

#pragma mark - Override

- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (NSInteger idx = 0; idx < _columns; idx ++) {
        UILabel* label = columnLabels[idx];
        label.frame = CGRectMake(_columnWidth*idx, 0, _columnWidth, HEIGHT-0.5);
        label.numberOfLines = 0;
        label.text = self.rowData[idx];
        
    }
    if (self.separateLineStyle == ZCGListViewSeparateLineStyleSingleLine) {
        separateLineView.backgroundColor = MIT_GRAY_COLOR;
        separateLineView.frame = CGRectMake(0, HEIGHT-0.5, WIDTH, 0.5);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Public Methods

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

-(instancetype)initWithColumnWidth:(CGFloat)columnWidth Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rowData:(NSArray *)data andIndicatorIndex:(NSInteger)indicator{
    return [self initWithColumnWidth:columnWidth Style:style reuseIdentifier:reuseIdentifier rowData:data];
}

- (void)setCellSeparatLineWidth:(CGFloat)width Color:(UIColor*)color {
    if (self.separateLineStyle == ZCGListViewSeparateLineStyleSingleLine) {
        separateLineView.backgroundColor = color;
        CGRect frame = separateLineView.frame;
        frame.size.height = width/2;
        separateLineView.frame = frame;
    }else{
        for (UILabel* label  in columnLabels) {
            label.layer.borderWidth = width/2;
            label.layer.borderColor = color.CGColor;
        }
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

#pragma mark - Private Methods

- (void)initUI {
    if (_columns == 0) {
        return;
    }
    if (self.separateLineStyle == ZCGListViewSeparateLineStyleSingleLine) {
        separateLineView = [[UIView alloc]init];
        [self.contentView addSubview:separateLineView];
    }
    
    for (int idx = 0; idx < _columns; idx ++) {
        UILabel* label = [[UILabel alloc]init];
        label.tag = 500+idx;
        [columnLabels addObject:label];
        [self.contentView addSubview:label];
    }
}

@end
