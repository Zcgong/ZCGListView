//
//  QDListView.m
//  StampApp
//
//  Created by LTMacMini on 15/11/16.
//
//

#import "ZCGListView.h"
#import "ZCGLeftContentTableViewCell.h"
#import "ZCGRightContentTableViewCell.h"

#define ContentWidth (_rightColumnWidth*_columns)
#define DefaultFontSize 21
#define DefaultTextColor [UIColor blackColor]
#define DefaultTextAlign NSTextAlignmentLeft
#define DefaultSeparateWidth 1
#define DefaultViewBGColor [UIColor clearColor]
#define DefaultSelectStyle UITableViewCellSelectionStyleDefault

@interface ZCGListView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *rightHeaderLabels;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) UIScrollView* rightAllContentScrollView;
@property (nonatomic, assign) NSInteger columns;
@end

@implementation ZCGListView
{
    CGFloat cellSeparateWidth;
    UIColor* cellSeparateColor;
    NSInteger cellTag;
    UIColor* tagCellBgColor;
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles listData:(NSMutableArray*)data{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArr = [NSMutableArray arrayWithArray:titles];
        _listData = [NSMutableArray arrayWithArray:data];
        _rightHeaderLabels = [NSMutableArray new];
        self.columns = titles.count - 1;
        [self initUI];
    }
    return self;
}

- (void) initUI{
    self.leftContentTableView = [[UITableView alloc]init];
    self.leftContentTableView.dataSource = self;
    self.leftContentTableView.delegate = self;
    self.rightContentTableView = [[UITableView alloc]init];
    self.rightContentTableView.dataSource = self;
    self.rightContentTableView.delegate = self;
    self.rightAllContentScrollView = [[UIScrollView alloc]init];
    [self addSubview:self.leftContentTableView];
    [self addSubview:self.rightAllContentScrollView];
    [self.rightAllContentScrollView addSubview:self.rightContentTableView];
  
}
- (void)layoutSubviews{
    [super layoutSubviews];
        //左侧内容表
    self.leftContentTableView.frame = CGRectMake(0, 0, _leftColumnWidth, self.frame.size.height);
    self.leftContentTableView.showsVerticalScrollIndicator = NO;
    self.leftContentTableView.showsHorizontalScrollIndicator = NO;
    self.leftContentTableView.alwaysBounceVertical = YES;
    self.leftContentTableView.separatorStyle = _cellSelectionStyle?_cellSelectionStyle:DefaultSelectStyle;
    self.leftContentTableView.backgroundColor = _viewBgColor?_viewBgColor:DefaultViewBGColor;
    //右侧内容表
    self.rightContentTableView.frame = CGRectMake(0, 0, ContentWidth, self.rightAllContentScrollView.frame.size.height);
    self.rightContentTableView.showsHorizontalScrollIndicator = NO;
    self.rightContentTableView.showsVerticalScrollIndicator = NO;
    self.rightContentTableView.separatorStyle = _cellSelectionStyle?_cellSelectionStyle:DefaultSelectStyle;
    self.rightContentTableView.backgroundColor = _viewBgColor?_viewBgColor:DefaultViewBGColor;
    self.rightContentTableView.alwaysBounceVertical = YES;
    //右侧滚动视图
    self.rightAllContentScrollView.frame = CGRectMake(_leftColumnWidth, 0, self.frame.size.width - _leftColumnWidth, self.frame.size.height);
    self.rightAllContentScrollView.backgroundColor = _viewBgColor?_viewBgColor:DefaultViewBGColor;
    self.rightAllContentScrollView.contentSize = CGSizeMake(ContentWidth, self.frame.size.height);
    self.rightAllContentScrollView.alwaysBounceHorizontal = _bouncesRight?_bouncesRight:YES;
    self.rightAllContentScrollView.directionalLockEnabled = YES;
    [self headerViewBackgroundColor];
    [self tableviewFooterViewHidden];
    
    self.contentSize = CGSizeMake(_leftColumnWidth + ContentWidth, self.frame.size.height);
    self.alwaysBounceVertical = YES;
    
}

#pragma mark
#pragma mark - DataSource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listData.count;
}
static NSString* identifierL = @"leftCell";
static NSString* identifierR = @"rightCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* obj = self.listData[indexPath.row];
    if ([tableView isEqual:self.leftContentTableView]) {
        ZCGLeftContentTableViewCell* cell = [[ZCGLeftContentTableViewCell alloc]initWithListCellStyle:self.leftCellStyle?self.leftCellStyle:ZCGLeftContentCellStyleDefault
                                                                                      reuseIdentifier:identifierL];
        cell.nameLabel.text = obj.firstObject[0];
        cell.subTitleLabel.text = obj.firstObject[1];
        [self configeLeftCell:cell];
        return cell;
    }else if ([tableView isEqual:self.rightContentTableView]){
        ZCGRightContentTableViewCell* cell1 = [[ZCGRightContentTableViewCell alloc]initWithColumnWidth:_rightColumnWidth
                                                                                                 Style:UITableViewCellStyleDefault
                                                                                       reuseIdentifier:identifierR
                                                                                               rowData:[obj subarrayWithRange:NSMakeRange(1, obj.count-1)]];
        [self configeRightCell:cell1];
        return cell1;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftContentTableView]) {
        [self.rightContentTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else {
        [self.leftContentTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    if ([self.delegate respondsToSelector:@selector(listView:didSelectCellAtIndexPath:)]) {
        [self.listViewDelegate listView:self didSelectCellAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    if ([scrollView isEqual:self.leftContentTableView]) {
        self.rightContentTableView.contentOffset = self.leftContentTableView.contentOffset;
    } else if ([scrollView isEqual:self.rightContentTableView]) {
        self.leftContentTableView.contentOffset = self.rightContentTableView.contentOffset;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(listView:heightForRowIndexPath:)]) {
        return [self.listViewDelegate listView:self heightForRowIndexPath:indexPath];
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _headerViewheight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:self.leftContentTableView]) {
        self.leftHeadView = [[UIView alloc]init];
        self.leftHeadView.frame = CGRectMake(0, 0, _leftColumnWidth, _headerViewheight);
        self.leftLabel = [[UILabel alloc]init];
        self.leftLabel.text = _titleArr.firstObject?_titleArr.firstObject:@"";
        self.leftLabel.frame = CGRectMake(0, 0, _leftColumnWidth, _headerViewheight);
        self.leftLabel.textAlignment = _headerTextAlign?_headerTextAlign:DefaultTextAlign;
        self.leftLabel.font = [UIFont systemFontOfSize:_headerFontSize?_headerFontSize:DefaultFontSize];
        self.leftLabel.backgroundColor = self.headerViewBackgroundColor ? _headerViewBackgroundColor:DefaultViewBGColor;
        self.leftLabel.textColor = _headerTextColor ? _headerTextColor : DefaultTextColor;
        [self.leftHeadView addSubview:self.leftLabel];
        return self.leftHeadView;
    }else if([tableView isEqual:self.rightContentTableView]){
        self.rightHeadView = [[UIView alloc] init];
        self.rightHeadView.frame = CGRectMake(0, 0, ContentWidth , _headerViewheight);
        for (int i = 0; i < _titleArr.count-1; i++) {
            UILabel* label = [[UILabel alloc]init];
            label.frame = CGRectMake(_rightColumnWidth*i, 0, _rightColumnWidth, _headerViewheight);
            NSString* textObj = _titleArr[i+1];
            label.text = textObj?textObj:@"";
            label.font = [UIFont systemFontOfSize:_headerFontSize?_headerFontSize:DefaultFontSize];
            label.textAlignment = _headerTextAlign?_headerTextAlign:DefaultTextAlign;
            label.backgroundColor = self.headerViewBackgroundColor ? _headerViewBackgroundColor:DefaultViewBGColor;
            label.textColor = _headerTextColor ? _headerTextColor : DefaultTextColor;
            [self.rightHeadView addSubview:label];
        }
        return self.rightHeadView;
    }
    return nil;
}
#pragma mark
#pragma mark - Private Methods
- (void)tableviewFooterViewHidden{
    self.leftContentTableView.tableFooterView = [[UIView alloc]init];
    self.rightContentTableView.tableFooterView = [[UIView alloc]init];
}
- (void)listViewReloadData{
    [self.leftContentTableView reloadData];
    [self.rightContentTableView reloadData];
}
- (void)setSeparateLineWidth:(CGFloat)width Color:(UIColor*)color {
    cellSeparateWidth = width;
    cellSeparateColor = color;
    if (self.separateLineStyle == ZCGListViewSeparateLineStyleAround) {
        self.leftLabel.layer.borderWidth = width/2;
        self.leftLabel.layer.borderColor = color.CGColor;
        for (UILabel* label in _rightHeaderLabels) {
            label.layer.borderWidth = width/2;
            label.layer.borderColor = color.CGColor;
        }
    }
       [self listViewReloadData];
}

- (void)configeLeftCell:(ZCGLeftContentTableViewCell*)cell {
    
    cell.nameLabel.font = [UIFont systemFontOfSize:_leftFontSize?_leftFontSize:DefaultFontSize];
    cell.nameLabel.textColor = _leftTextColor?_leftTextColor:DefaultTextColor;
    cell.nameLabel.textAlignment = _leftTextAlign?_leftTextAlign:DefaultTextAlign;
    cell.nameLabel.backgroundColor = _leftViewBackgroundColor?_leftViewBackgroundColor:DefaultViewBGColor;
    if (cell.cellStyle == ZCGLeftContentCellStyleSubtitle) {
        cell.subTitleLabel.font = [UIFont systemFontOfSize:_leftFontSize?_leftFontSize:DefaultFontSize];
        cell.subTitleLabel.textColor = _leftTextColor?_leftTextColor:DefaultTextColor;
        cell.subTitleLabel.textAlignment = _leftTextAlign?_leftTextAlign:DefaultTextAlign;
        cell.subTitleLabel.backgroundColor = _leftViewBackgroundColor?_leftViewBackgroundColor:DefaultViewBGColor;
        
    }
    cell.separateLineStyle = self.separateLineStyle?self.separateLineStyle:ZCGListViewSeparateLineStyleSingleLine;
    [cell setCellSeparatLineWidth:cellSeparateWidth?cellSeparateWidth:DefaultSeparateWidth
                            Color:cellSeparateColor?cellSeparateColor:DefaultTextColor];
    [cell setSelectionStyle:_cellSelectionStyle?_cellSelectionStyle:DefaultSelectStyle];
}

- (void)configeRightCell:(ZCGRightContentTableViewCell*)cell {
    
    [cell setCellSeparatLineWidth:cellSeparateWidth?cellSeparateWidth:DefaultSeparateWidth
                            Color:cellSeparateColor?cellSeparateColor:DefaultTextColor];
    [cell setCellTextAlignment:_rightTextAlign?_rightTextAlign:DefaultTextAlign];
    [cell setCellTextColor:_rightTextColor?_rightTextColor:DefaultTextColor];
    [cell setCellTextFontSize:_rightFontSize?_rightFontSize:DefaultFontSize];
    [cell setCellBackgroundColor:_rightViewBackgroundColor?_rightViewBackgroundColor:DefaultViewBGColor];
    [cell setSelectionStyle:_cellSelectionStyle?_cellSelectionStyle:DefaultSelectStyle];
    cell.separateLineStyle = self.separateLineStyle?self.separateLineStyle:ZCGListViewSeparateLineStyleSingleLine;
    if (cellTag && tagCellBgColor) {
        [cell changeColumnColorWithTag:cellTag Color:tagCellBgColor];
    }
}
- (void)listViewRightCell:(ZCGRightContentTableViewCell*)cell changeColumnColorWithTag:(NSInteger)tag color:(UIColor*)color {
    cellTag = tag;
    tagCellBgColor = color;
    [self listViewReloadData];
}
@end
