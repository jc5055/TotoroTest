//
//  ViewC.m
//  TotoroTest
//
//  Created by jc on 15/11/4.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "ViewC.h"

@implementation ViewC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL flag = [super pointInside:point withEvent:event];
    NSLog(@"ViewC is inside:%@",  [NSString stringWithFormat:@"%d", flag]);
    return flag;
}
@end
