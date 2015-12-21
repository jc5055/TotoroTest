//
//  TotoroViewController.m
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "TotoroViewController.h"
#import "TotoroToolBar.h"
#import "TotoroWindow.h"
#import "AppDelegate.h"
//#import "PRIS_iPhoneAppDelegate.h"

typedef NS_ENUM(NSUInteger, TotoroExplorerMode) {
    TotoroDefault,
    TotoroMove,
    TotoroScreenShow,
    TotoroPaintLine,
    TotoroPaintRectangle,
    TotoroSetting,
    TotoroWords
};




@interface TotoroViewController ()
//toolbar工具栏
@property (nonatomic, strong) TotoroToolBar *explorerToolbar;
//toolbar拖动前的位置
@property (nonatomic, assign) CGRect toolbarFrameBeforeDragging;
//当前toolbar的模式
@property (nonatomic, assign) TotoroExplorerMode currentMode;
//绘图图层
@property (nonatomic, strong) UIImageView *paintLineImageView;
@property (nonatomic, strong) UIView * drawRectangleTempView;
@property (nonatomic) CGPoint beginPoint;
@property (nonatomic, strong) UITextView *wordsTextViewTemp;
@property (nonatomic, strong) NSMutableArray *wordsTextViewArray;
@property (nonatomic, strong) NSMutableArray *drawRectangleViewArray;
@property (nonatomic, strong) NSMutableData *data;


@end

@implementation TotoroViewController

+(UIColor*)defaultColor{
    return [UIColor redColor];
}
+(float )defaultLineSize{
    return 2.0f;
}

+(float)lineSize{
    return 2.0f;
}

+(UIColor*)lineColor{
    return [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 显示toolbar
    self.explorerToolbar = [[TotoroToolBar alloc] init];
    self.explorerToolbar.frame = CGRectMake(self.view.frame.origin.x, 500, [self.explorerToolbar getToolbarItemsNum]*[TotoroToolBar toolBarWidth] , [TotoroToolBar toolBarHight]);
    [self.explorerToolbar setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:self.explorerToolbar];
    
    //    添加toolbar的响应事件
    [self setupToolbarActions];
    self.currentMode = TotoroDefault;
    
//    添加手势
    [self setupToolbarGestures];
//     [self.view addSubview:self.drawRectView];
    self.drawRectangleViewArray = [NSMutableArray array];
    self.wordsTextViewArray = [NSMutableArray array];

    
    
    _data = [[NSMutableData alloc] init];
    NSString *urlstr = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@", @"php"];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];

}


// 分批返回数据
- (void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    [_data appendData:data];
    NSLog(@"%@", _data);
}

// 数据完全返回完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *dataString =  [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", dataString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set toobbar status
-(void)setCurrentMode:(TotoroExplorerMode)currentMode{
    if (_currentMode != currentMode) {
        _currentMode = currentMode;
    }
    [self updateButtonStates];
}


- (void)updateButtonStates
{
    
    self.explorerToolbar.paintToolBarItem.selected = self.currentMode == TotoroPaintLine;
    self.explorerToolbar.screenShotToolBarItem.selected = self.currentMode == TotoroScreenShow;
    self.explorerToolbar.moveToolBarItem.selected = self.currentMode == TotoroMove;
    self.explorerToolbar.rectangleToolBarItem.selected = self.currentMode == TotoroPaintRectangle;
    self.explorerToolbar.wordsToolBarItem.selected = self.currentMode == TotoroWords;
    self.explorerToolbar.settingToolBarItem.selected = self.currentMode == TotoroSetting;
    // 绘图成功后，将绘图层移除
    if (self.currentMode != TotoroScreenShow) {
        [self clearPaint];
    }
    
}

-(void) clearPaint{
    [self.paintLineImageView removeFromSuperview];
    for (UIView *rectangleTemp in self.drawRectangleViewArray) {
        [rectangleTemp removeFromSuperview];
    }
    [self.drawRectangleViewArray removeAllObjects];
    
    for (UITextView *wordsTemp in self.wordsTextViewArray) {
        [wordsTemp removeFromSuperview];
    }
    [self.wordsTextViewArray removeAllObjects];
}




#pragma mark paint
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    self.beginPoint = location;
    if (self.currentMode == TotoroPaintLine) {
        if (NULL != UIGraphicsBeginImageContextWithOptions)
            UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0);
        else
            UIGraphicsBeginImageContext(self.view.frame.size);
        [self.paintLineImageView.image drawInRect:self.view.frame];
    }else if (self.currentMode == TotoroPaintRectangle){
        self.drawRectangleTempView = [UIView new];
        self.drawRectangleTempView.frame = CGRectMake(self.beginPoint.x, self.beginPoint.y, 0, 0);
        self.drawRectangleTempView.layer.borderColor = [TotoroViewController defaultColor].CGColor;
        self.drawRectangleTempView.layer.borderWidth = [TotoroViewController defaultLineSize];
        [self.view addSubview:self.drawRectangleTempView];
    }else if (self.currentMode == TotoroWords){
        self.wordsTextViewTemp = [UITextView new];
        self.wordsTextViewTemp.frame = CGRectMake(self.beginPoint.x, self.beginPoint.y, 0, 0);
        self.wordsTextViewTemp.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.wordsTextViewTemp.layer.borderColor = [TotoroViewController defaultColor].CGColor;
        self.wordsTextViewTemp.layer.borderWidth = [TotoroViewController defaultLineSize];
        [self.view addSubview:self.wordsTextViewTemp];
    }
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CGPoint pastLoacation = [touch previousLocationInView:self.view];
    if (self.currentMode == TotoroPaintLine)
    {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, pastLoacation.x, pastLoacation.y);
        CGContextAddLineToPoint(context, location.x, location.y);
        CGContextSetStrokeColorWithColor(context, [TotoroViewController lineColor].CGColor);
        CGContextSetLineWidth(context, [TotoroViewController lineSize]);
        CGContextStrokePath(context);
        self.paintLineImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    }else if (self.currentMode == TotoroPaintRectangle) {
        CGRect newFrame = CGRectMake(self.beginPoint.x, self.beginPoint.y, (location.x - self.beginPoint.x), (location.y - self.beginPoint.y));
        
        self.drawRectangleTempView.frame = newFrame;
    }else if (self.currentMode == TotoroWords) {
        CGRect newFrame = CGRectMake(self.beginPoint.x, self.beginPoint.y, (location.x - self.beginPoint.x), (location.y - self.beginPoint.y));
        self.wordsTextViewTemp.frame = newFrame;
    }

    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    switch (self.currentMode) {
        case TotoroPaintLine:
            UIGraphicsEndImageContext();
            break;
        case TotoroPaintRectangle:
            [self.drawRectangleViewArray addObject:self.drawRectangleTempView];
            break;
        case TotoroWords:
            [self.wordsTextViewArray addObject:self.wordsTextViewTemp];
            break;
        default:
            break;
    }
}



//判断是否该接受touch响应
- (BOOL)shouldReceiveTouchAtWindowPoint:(CGPoint)pointInWindowCoordinates
{
    BOOL shouldReceiveTouch = NO;
    
    CGPoint pointInLocalCoordinates = [self.view convertPoint:pointInWindowCoordinates fromView:nil];
    // Always if it's on the toolbar
    //    点击点是否在toolbar的frame范围内
    if (CGRectContainsPoint(self.explorerToolbar.frame, pointInLocalCoordinates)) {
        shouldReceiveTouch = YES;
    }
//    如果是在画图模式下，消息不透穿
    if (self.currentMode == TotoroPaintLine || self.currentMode == TotoroPaintRectangle || self.currentMode == TotoroWords) {
        shouldReceiveTouch = YES;
    }
    
    return shouldReceiveTouch;
}

//toolbar事件响应
- (void)setupToolbarActions
{
//    处理截屏响应
    [self.explorerToolbar.screenShotToolBarItem addTarget:self action:@selector(screenShotButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    处理画图响应
    [self.explorerToolbar.paintToolBarItem addTarget:self action:@selector(paintLine:) forControlEvents:UIControlEventTouchUpInside];
//    画矩形框
    [self.explorerToolbar.rectangleToolBarItem addTarget:self action:@selector(paintRectangle:) forControlEvents:UIControlEventTouchUpInside];
//    标注文字
    [self.explorerToolbar.wordsToolBarItem addTarget:self action:@selector(LabelWords:) forControlEvents:UIControlEventTouchUpInside];
}




//画图键确认状态下才能画图
-(void)paintLine:(TotoroToolBarItem *)sender{
    if (self.currentMode != TotoroPaintLine) {
        self.currentMode = TotoroPaintLine;
        self.paintLineImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        [self.paintLineImageView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.paintLineImageView ];
    }else{
        self.currentMode = TotoroDefault;
        [self clearPaint];
    }
}

-(void) LabelWords:(TotoroToolBarItem *)sender{
    if (self.currentMode != TotoroWords) {
        self.currentMode = TotoroWords;
        self.wordsTextViewTemp = [UITextView new];
        [self.wordsTextViewTemp setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.wordsTextViewTemp];
    }else{
        self.currentMode = TotoroDefault;
        [self clearPaint];
    }
}

-(void)paintRectangle:(TotoroToolBarItem*)sender{
    if (self.currentMode != TotoroPaintRectangle) {
        self.currentMode = TotoroPaintRectangle;
        self.drawRectangleTempView = [UIView new];
        [self.drawRectangleTempView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.drawRectangleTempView ];
    }else{
        self.currentMode = TotoroDefault;
        [self clearPaint];
        
    }
}



#pragma mark screen shot and save
- (void)screenShotButtonTapped:(TotoroToolBarItem *)sender
{
    //设置当前功能状态
    self.currentMode = TotoroScreenShow;
    UIImage *screenShotImage = [self screenShot];
    UIImageWriteToSavedPhotosAlbum(screenShotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self clearPaint];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

//截屏
-(UIImage *)screenShot{
//    获取屏幕大小
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
//    开发context上下文
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
//    获得一个绘图上下文，即当前到图像上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
//    获取app的所有window
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
//            将上下文状态压入栈顶
            CGContextSaveGState(context);
            
            // Render the layer hierarchy to the current context
//            将当前window的layer存储到上下文
            [[window layer] renderInContext:context];
            
            // Restore the context
//            将上下文状态出栈
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image，获取上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    关闭context上下文
    UIGraphicsEndImageContext();
    return image;

}




#pragma mark Gestures set
- (void)setupToolbarGestures
{
    // Pan gesture for dragging.
    //    添加toolbar对拖动手势的识别
    //给explorerToolbar的dragHandle添加panGR手势识别，对应的响应函数为handleToolbarPanGesture
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleToolbarPanGesture:)];
    [self.explorerToolbar.moveToolBarItem addGestureRecognizer:panGR];
}



#pragma mark app  Gesture
//拖动手势响应函数，功能重会toolbar，传参数UIPanGestureRecognizer，会分别记录开始，过程中，结束几个时间点
//在开始，结束点调用updateToolbarPostionWithDragGesture函数，重绘toolbar位置
- (void)handleToolbarPanGesture:(UIPanGestureRecognizer *)panGR
{
    switch (panGR.state) {
        case UIGestureRecognizerStateBegan:
            //            拖动操作前，记录toolbar原始的位置信息frame
            self.toolbarFrameBeforeDragging = self.explorerToolbar.frame;
            [self updateToolbarPostionWithDragGesture:panGR];
            break;
            
        case UIGestureRecognizerStateChanged:
            self.currentMode = TotoroMove;
            [self updateButtonStates];
        case UIGestureRecognizerStateEnded:
            //            拖动后，更新toolbar的位置，即重绘，panGR为拖动后的位置
            [self updateToolbarPostionWithDragGesture:panGR];
            break;
            
        default:
            break;
    }
}




//重绘toolbar，
- (void)updateToolbarPostionWithDragGesture:(UIPanGestureRecognizer *)panGR
{
    //UIPanGestureRecognizer存储了移动前后的变量差，将变量差转换到当前的view坐标系
    CGPoint translation = [panGR translationInView:self.view];
    //计算更新toolbar的frame
    CGRect newToolbarFrame = self.toolbarFrameBeforeDragging;
    //    更新纵坐标
    newToolbarFrame.origin.x += translation.x;
    newToolbarFrame.origin.y += translation.y;
    //    保证移动后toolbar的横纵坐标不溢出
    CGFloat maxX = CGRectGetMaxX(self.view.bounds) - newToolbarFrame.size.width;
    CGFloat maxY = CGRectGetMaxY(self.view.bounds) - newToolbarFrame.size.height;
    
    
    if (newToolbarFrame.origin.y < 0.0) {
        newToolbarFrame.origin.y = 0.0;
    } else if (newToolbarFrame.origin.y > maxY) {
        newToolbarFrame.origin.y = maxY;
    }
    
    if (newToolbarFrame.origin.x < 0.0) {
        newToolbarFrame.origin.x = 0.0;
    } else if (newToolbarFrame.origin.x > maxX){
        newToolbarFrame.origin.x = maxX;
    }
    //    返回新的toolbar的frame
    self.explorerToolbar.frame = newToolbarFrame;
}



#pragma mark - Totoro View get

-(NSArray *)allWindows{
    
    //    可以用这个函数替换下面掉代码获取app的所有window,后面关注下是否可以获取每个window的可以状态
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    
//    
//    BOOL includeInternalWindows = YES;
//    BOOL onlyVisbleWindows = NO;
//    NSArray *allWindowsComponents = @[@"al", @"lWindo", @"wsIncl", @"udingInt", @"ernalWin", @"dows:o", @"nlyVisi", @"bleWin", @"dows:"];
//    SEL allWindowsSelector = NSSelectorFromString([allWindowsComponents componentsJoinedByString:@""]);
//    NSMethodSignature *methodSignature = [[UIWindow class] methodSignatureForSelector:allWindowsSelector];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
//    
//    invocation.target = [UIWindow class];
//    invocation.selector = allWindowsSelector;
//    [invocation setArgument:&includeInternalWindows atIndex:2];
//    [invocation setArgument:&onlyVisbleWindows atIndex:3];
//    [invocation invoke];
//    __unsafe_unretained NSArray *windows = nil;
//    [invocation getReturnValue:&windows];
    
    return windows;
}


//查询所有的view，
- (NSArray *)allViewsInHierarchy
{
    NSMutableArray *allViews = [NSMutableArray array];
    NSArray *windows = [self allWindows];
    //    先查找所有window，然后查收window对应的subview
    for (UIWindow *window in windows) {
        if (window != self.view.window) {
            [allViews addObject:window];
            [allViews addObjectsFromArray:[self allRecursiveSubviewsInView:window]];
        }
    }
    return allViews;
}

//查找view类下的subview
- (NSArray *)allRecursiveSubviewsInView:(UIView *)view
{
    
    NSMutableArray *subviews = [NSMutableArray array];
    for (UIView *subview in view.subviews) {
        [subviews addObject:subview];
        [subviews addObjectsFromArray:[self allRecursiveSubviewsInView:subview]];
    }
    return subviews;
}


@end
