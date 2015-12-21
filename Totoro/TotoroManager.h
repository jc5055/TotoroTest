//
//  TotoroManager.h
//  Totoro
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TotoroManager : NSObject
+ (instancetype)sharedManager;
- (void)showExplorer;
@end
