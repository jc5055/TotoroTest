//
//  TotoroWindow.h
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TotoroWindowEventDelgate;


@interface TotoroWindow : UIWindow
@property(nonatomic,assign) id<TotoroWindowEventDelgate> eventDelgate;
@property(nonatomic) BOOL isPaint;
@end

@protocol TotoroWindowEventDelgate <NSObject>

-(BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow;

@end