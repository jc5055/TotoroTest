//
//  TotoroItem.m
//  TotoroTest
//
//  Created by jc on 15/11/4.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "TotoroToolBarItem.h"


@interface TotoroToolBarItem()
@property (nonatomic, copy) NSAttributedString *attributedTitle;//管理string属性的类
@property (nonatomic, strong) UIImage *image;
@end

@implementation TotoroToolBarItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+(instancetype)toolbarItemWithTitle:(NSString *)title image:(UIImage *)image{
    TotoroToolBarItem *toolbarItem = [self buttonWithType:UIButtonTypeCustom];
    NSAttributedString *attribuedTitle = [[NSAttributedString alloc] initWithString:title attributes:[self titleAttributes]];
    toolbarItem.attributedTitle = attribuedTitle;
    toolbarItem.image = image;
    [toolbarItem setBackgroundColor:[self defaultBackgroundColor]];
    [toolbarItem setAttributedTitle:attribuedTitle forState:UIControlStateNormal];
    [toolbarItem setImage:image forState:UIControlStateNormal];
    return toolbarItem;
}

+ (UIColor *)defaultTitleColor
{
    //    默认字体颜色，黑色
    return [UIColor blackColor];
}

+ (UIColor *)disabledTitleColor
{
    //    返回按钮不可点击状态下的字体颜色
    return [UIColor colorWithWhite:121.0/255.0 alpha:1.0];
}


+ (NSDictionary *)titleAttributes
{
    //    默认的字体大小
    return @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:12]};
}

+ (UIColor *)highlightedBackgroundColor
{
    //    button点击下的背景色
    return [UIColor colorWithWhite:0.9 alpha:1.0];
}

+ (UIColor *)selectedBackgroundColor
{
    return [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+ (UIColor *)defaultBackgroundColor
{
    return [UIColor colorWithWhite:1.0 alpha:0.95];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateBackgroundColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateBackgroundColor];
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[self class] defaultBackgroundColor];//类静态方法，返回背景颜色
        //类静态方法，设定按钮正常状态下的颜色
        [self setTitleColor:[[self class] defaultTitleColor] forState:UIControlStateNormal];
        //        类静态方法，设定按钮不可点击下的字体颜色
        [self setTitleColor:[[self class] disabledTitleColor] forState:UIControlStateDisabled];
    }
    return self;
}


- (void)updateBackgroundColor
{
    if (self.highlighted) {
        self.backgroundColor = [[self class] highlightedBackgroundColor];
    } else if (self.selected) {
        self.backgroundColor = [[self class] selectedBackgroundColor];
    } else {
        self.backgroundColor = [[self class] defaultBackgroundColor];
    }
}




- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    // Bottom aligned and centered.
    //    CGRectZero like CGRectMake(0, 0, 0, 0)
    CGRect titleRect = CGRectZero;
    //  string属性的方法用来返回一个边界矩阵来绘制string cgsize，即根据设定的string属性类，返回对应string属性设定值的真实显示大小，即cgsize
    //    You can use this method to compute the space required to draw the string
    CGSize titleSize = [self.attributedTitle boundingRectWithSize:contentRect.size options:0 context:nil].size;
    //    ceil返回大于或者等于指定表达式的最小整数
    titleSize = CGSizeMake(ceil(titleSize.width), ceil(titleSize.height));
    titleRect.size = titleSize;
    //    效果就字体向下偏移
    titleRect.origin.y = contentRect.origin.y + CGRectGetMaxY(contentRect) - titleSize.height;
    //    效果就是居中了
    titleRect.origin.x = contentRect.origin.x + ((contentRect.size.width - titleSize.width) / 2.0);
    return titleRect;
}



-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGSize imageSize = self.image.size;
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    //    活动图片实际能显示的高度，button高度－title高度－上边缘，
    CGFloat availableHeight = contentRect.size.height - titleRect.size.height - [[self class] topMargin];
    //    图片能上下，左右居中
    CGFloat originY = [[self class] topMargin] + ((availableHeight - imageSize.height) / 2.0);
    CGFloat originX = ((contentRect.size.width - imageSize.width) / 2.0);
    CGRect imageRect = CGRectMake(originX, originY, imageSize.width, imageSize.height);
    return imageRect;

}

+ (CGFloat)topMargin
{
    //    顶边大小
    return 2.0;
}


@end
