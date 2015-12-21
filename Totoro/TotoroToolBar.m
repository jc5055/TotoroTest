//
//  TototoToolBar.m
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "TotoroToolBar.h"
#import "TotoroToolBarItem.h"
#import "TotoroResource.h"


@interface TotoroToolBar ()
@property (nonatomic,strong) TotoroToolBarItem *toolBar;
//变量dragHandle，在totoroViewController会设置该UIView手势响应事件（拖动)，当手势落在该视图上，会响应拖动处理，即重绘toolbar
@property (nonatomic, strong) TotoroToolBarItem *moveToolBarItem;
@property (nonatomic, strong, readwrite) TotoroToolBarItem *screenShotToolBarItem;
@property (nonatomic, strong, readwrite) TotoroToolBarItem *paintToolBarItem;
@property (nonatomic, strong, readwrite) TotoroToolBarItem *rectangleToolBarItem;
@property (nonatomic, strong, readwrite) TotoroToolBarItem *settingToolBarItem;
@property (nonatomic, strong, readwrite) TotoroToolBarItem *wordsToolBarItem;
@property (nonatomic, strong) NSArray *toolbarItems;
@end

@implementation TotoroToolBar

+(float) toolBarHight{
    return 50;
}

+(float) toolBarWidth{
    return 50;
}

+(float) toolBarItemIconWidth{
    return 35;
}

+(float) toolBarItemIconHight{
    return 35;
}




-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         NSMutableArray *toolbarItems = [NSMutableArray array];

        UIImage *moveIcon = [self CompressedImage:[TotoroResource moveIcon]];
        self.moveToolBarItem = [TotoroToolBarItem toolbarItemWithTitle:@"移动" image:moveIcon];
//        只将dragHandl添加到view，但没有具体绘制，具体绘制在layoutSubviews中
        [self addSubview:self.moveToolBarItem];
        [toolbarItems addObject:self.moveToolBarItem];

        
        UIImage *screenshotIcon = [self CompressedImage:[TotoroResource screenIcon]];
        self.screenShotToolBarItem = [TotoroToolBarItem toolbarItemWithTitle:@"截屏" image:screenshotIcon];
        [self addSubview:self.screenShotToolBarItem];
        [toolbarItems addObject:self.screenShotToolBarItem];

        
//        UIImage * paintIcon = [self cutImage:[TotoroResource paintIcon]];
        UIImage * paintIcon = [self CompressedImage:[TotoroResource paintIcon]];
        self.paintToolBarItem = [TotoroToolBarItem toolbarItemWithTitle:@"画笔" image:paintIcon];
        [self addSubview:self.paintToolBarItem];
        [toolbarItems addObject:self.paintToolBarItem];
        
        UIImage *paintRectangleIcon = [self CompressedImage:[TotoroResource rectangleIcon]];
        self.rectangleToolBarItem = [TotoroToolBarItem toolbarItemWithTitle:@"矩形" image:paintRectangleIcon];
        [self addSubview:self.rectangleToolBarItem];
        [toolbarItems addObject:self.rectangleToolBarItem];
        

        UIImage *wordsIcon = [self CompressedImage:[TotoroResource wordsIcon]];
        self.wordsToolBarItem = [TotoroToolBarItem toolbarItemWithTitle:@"文字" image:wordsIcon];
        [self addSubview:self.wordsToolBarItem];
        [toolbarItems addObject:self.wordsToolBarItem];
        
        UIImage *settingIcon = [self CompressedImage:[TotoroResource settingIcon]];
        self.settingToolBarItem = [TotoroToolBarItem toolbarItemWithTitle:@"设置" image:settingIcon];
        [self addSubview:self.settingToolBarItem];
        [toolbarItems addObject:self.settingToolBarItem];
        
        
        self.toolbarItems = toolbarItems;
    }
    return  self;
}

-(long)getToolbarItemsNum{
    return  self.toolbarItems.count;
}

//布局subview，，该函数的调用主要会在addSubview后，且uiview的frame！＝｛0，0，0，0｝
-(void)layoutSubviews{
    [super layoutSubviews];

    CGFloat originX = self.bounds.origin.x;
    CGFloat originY = self.bounds.origin.y;
    
    float width = [TotoroToolBar toolBarWidth];
    float height = [TotoroToolBar toolBarHight];
    for (UIView *toolBarItem in self.toolbarItems) {
        toolBarItem.frame = CGRectMake(originX, originY, width, height);
        originX = CGRectGetMaxX(toolBarItem.frame);
    }
}


//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < ([TotoroToolBar toolBarWidth] / [TotoroToolBar toolBarHight])) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * [TotoroToolBar toolBarHight] / [TotoroToolBar toolBarWidth];
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * [TotoroToolBar toolBarWidth] / [TotoroToolBar toolBarHight];
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

//压缩图片
- (UIImage *)CompressedImage:(UIImage*)image
{
    // Create a graphics image context
    CGSize newSize = CGSizeMake([TotoroToolBar toolBarItemIconWidth] , [TotoroToolBar toolBarItemIconHight]);
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}


@end
