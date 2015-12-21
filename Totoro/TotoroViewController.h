//
//  TotoroViewController.h
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface TotoroViewController : UIViewController
- (NSArray *)allWindows;
- (NSArray *)allViewsInHierarchy;
- (NSArray *)allRecursiveSubviewsInView:(UIView *)view;
- (BOOL)shouldReceiveTouchAtWindowPoint:(CGPoint)pointInWindowCoordinates;

@property (nonatomic,strong,readwrite)UIImageView *screenShotImageView;
@property (nonatomic,strong)UIView *screenShotView;
@end



