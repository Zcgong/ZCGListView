# ZCGListView

##简介

这是一个表格控件，通过两个TableviewView和两个ScrollView加Label实现。

##功能
1. 根据需要设置行高，列宽
2. 根据需要设置每一行的字体大小，颜色，背景色
3. 根据需要设置整体的背景颜色
4. 根据需要设置分隔线颜色和宽度
5. 首列固定 

##使用

#####属性和方法

<pre><code>
@property (nonatomic, strong) NSMutableArray *listData;//数据
@property (nonatomic, weak) id<ZCGListViewDelegate> delegate;
@property (nonatomic, strong) UIView* leftHeadView;//左侧表头
@property (nonatomic, strong) UILabel* leftLabel;//左侧表格
@property (nonatomic, strong) UIView* rightHeadView;//右侧表头
@property (nonatomic, strong) UITableView* leftContentTableView;//左侧Tableview
@property (nonatomic, strong) UITableView* rightContentTableView;//右侧Tableview
//列宽 
@property (nonatomic, assign) CGFloat rightColumnWidth;//右侧列宽
@property (nonatomic, assign) CGFloat leftColumnWidth;//左侧列宽

@property (nonatomic, assign) CGFloat headerViewheight;//表头高度
//字体大小
@property (nonatomic, assign) CGFloat leftFontSize;//左侧列表字体大小
@property (nonatomic, assign) CGFloat rightFontSize;//右侧列表字体大小
@property (nonatomic, assign) CGFloat headerFontSize;//表头字体大小
//文字颜色
@property (nonatomic, strong) UIColor *headerTextColor;//表头文字颜色
@property (nonatomic, strong) UIColor *leftTextColor;//左侧列表文字颜色
@property (nonatomic, strong) UIColor *rightTextColor;//右侧列表文字颜色
//文字对齐格式
@property (nonatomic, assign) NSTextAlignment rightTextAlign;
@property (nonatomic, assign) NSTextAlignment leftTextAlign;
@property (nonatomic, assign) NSTextAlignment headerTextAlign;
//背景颜色
@property (nonatomic, strong) UIColor *headerViewBackgroundColor;
@property (nonatomic, strong) UIColor *leftViewBackgroundColor;
@property (nonatomic, strong) UIColor *rightViewBackgroundColor;
@property (nonatomic, strong) UIColor *viewBgColor;
//选中风格
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

//初始化
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles listData:(NSMutableArray*)data;
//重新加载数据
- (void)listViewReloadData;
//设置分隔线 宽度和颜色
- (void)setSeparateLineWidth:(CGFloat)width Color:(UIColor*)color;
//改变某一列的颜色 注意：tag 是指500 + 列数
- (void)listViewRightCell:(ZCGRightContentTableViewCell*)cell changeColumnColorWithTag:(NSInteger)tag color:(UIColor *)color;

</code></pre>

#####添加
<pre><code>
    //表头数据  是表头数组
    //表格内容  是数据数组 例如：@[@[1,2,...],@[1,2,...],@[1,2,...]]
    _listView = [[ZCGListView alloc]initWithFrame:FRAME titles:表头数组 listData:表格内容];
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
    [_listView setSeparateLineWidth:1 Color:[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0]]
    [self.view addSubview:_listView];
</code></pre>

#####协议方法——这些方法为可选方法

1. -(void)listView:(ZCGListView*)listView didSelectCellAtIndexPath:(NSIndexPath*)indexPath;
2. -(CGFloat)listView:(ZCGListView*)listView heightForRowIndexPath:(NSIndexPath *)indexPath;

##改进

需要进一步封装，实现单元格中View的自定义
