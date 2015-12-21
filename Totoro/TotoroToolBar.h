//
//  TototoToolBar.h
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TotoroToolBarItem.h"

@interface TotoroToolBar : UIView
@property (nonatomic, strong, readonly) TotoroToolBarItem *moveToolBarItem;
@property (nonatomic, strong, readonly) TotoroToolBarItem *screenShotToolBarItem;
@property (nonatomic, strong, readonly) TotoroToolBarItem *paintToolBarItem;
@property (nonatomic, strong, readonly) TotoroToolBarItem *rectangleToolBarItem;
@property (nonatomic, strong, readonly) TotoroToolBarItem *settingToolBarItem;
@property (nonatomic, strong, readonly) TotoroToolBarItem *wordsToolBarItem;

-(long)getToolbarItemsNum;
+(float)toolBarItemIconWidth;
+(float)toolBarItemIconHight;
+(float)toolBarWidth;
+(float)toolBarHight;
@end
