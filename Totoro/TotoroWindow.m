//
//  TotoroWindow.m
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "TotoroWindow.h"
#import "TotoroToolBar.h"

@interface TotoroWindow ()


@end

@implementation TotoroWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 100.0;
    }
    return self;
}



-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL pointInside = NO;
    
    if ([self.eventDelgate shouldHandleTouchAtPoint:point]) {
        pointInside = [super pointInside:point withEvent:event];
    }
    return pointInside;
}



-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView * a=[super hitTest:point withEvent:event];
    
    return a;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
