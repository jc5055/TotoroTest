//
//  TotoroResource.m
//  TotoroTest
//
//  Created by jc on 15/11/16.
//  Copyright © 2015年 jc. All rights reserved.
//

#import "TotoroResource.h"

@implementation TotoroResource

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(UIImage*) paintIcon{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"toolbar_draw" ofType:@"png"];
    UIImage *paintIcon = [UIImage imageWithContentsOfFile:imagePath];
    return  paintIcon;
}

+(UIImage*) screenIcon{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"toolbar_screenshot" ofType:@"png"];
    UIImage *paintIcon = [UIImage imageWithContentsOfFile:imagePath];
    return  paintIcon;
}

+(UIImage*) moveIcon{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"toolbar_move" ofType:@"png"];
    UIImage *paintIcon = [UIImage imageWithContentsOfFile:imagePath];
    return  paintIcon;
}

+(UIImage*) settingIcon{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"toolbar_setting" ofType:@"png"];
    UIImage *paintIcon = [UIImage imageWithContentsOfFile:imagePath];
    return  paintIcon;
}

+(UIImage*) rectangleIcon{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"toolbar_rectangle" ofType:@"png"];
    UIImage *paintIcon = [UIImage imageWithContentsOfFile:imagePath];
    return  paintIcon;
}

+(UIImage*) wordsIcon{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"toolbar_word" ofType:@"png"];
    UIImage *paintIcon = [UIImage imageWithContentsOfFile:imagePath];
    return  paintIcon;
}

@end
