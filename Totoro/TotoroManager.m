//
//  TotoroManager.m
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "TotoroManager.h"
#import "TotoroWindow.h"
#import "TotoroViewController.h"

@interface TotoroManager () <TotoroWindowEventDelgate>
@property (strong,nonatomic) TotoroWindow * explorerWindow;
@property(strong,nonatomic) TotoroViewController *explorerViewController;

@end


@implementation TotoroManager

+ (instancetype)sharedManager
{
    static TotoroManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}


- (TotoroWindow *)explorerWindow{
    NSAssert([NSThread isMainThread], @"You must use %@ from the main thread only.", NSStringFromClass([self class]));
    if (!_explorerWindow) {
        _explorerWindow = [[TotoroWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _explorerWindow.eventDelgate = self;
        _explorerWindow.rootViewController = self.explorerViewController;
        [_explorerWindow makeKeyWindow];
    }
    return _explorerWindow;
}

- (TotoroViewController *)explorerViewController
{
    if (!_explorerViewController) {
        _explorerViewController = [[TotoroViewController alloc] init];
    }
    
    return _explorerViewController;
}


- (void)showExplorer
{
    //    显示toolbar
    self.explorerWindow.hidden = NO;

}


#pragma mark - TotoroWindowEventDelegate
-(BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow{
    return [self.explorerViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}

@end
