//
//  ViewController.m
//  TotoroTest
//
//  Created by jc on 15/11/3.
//  Copyright (c) 2015年 jc. All rights reserved.
//

#import "ViewController.h"
#import "TotoroManager.h"
#import "TotoroViewController.h"

#import "ButtonA.h"
#import "ViewA.h"
#import "ViewB.h"
#import "ViewC.h"


//@property(nonatomic, strong) ViewA* viewA;
@interface ViewController ()
@property(nonatomic,strong)ButtonA *btnA;
@property(nonatomic,strong)ViewA *viewA;
@property(nonatomic,strong)ViewB *viewB;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)ViewC *viewC;
@end


@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view, typically from a nib.
//    _viewA = [[ViewA alloc] initWithFrame:CGRectMake(200, 500, 150, 150)];
//    [_viewA setBackgroundColor:[UIColor grayColor]];
//    [self.view addSubview:_viewA];
//    
////     (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
//    CGPoint point = [self.view convertPoint:CGPointMake(200, 500) toView:_viewA];
//    
//    _btnA = [[ButtonA alloc] initWithFrame:CGRectMake(point.x, point.y, 50, 50)];
//    [_btnA setBackgroundColor:[UIColor yellowColor]];
//    [_btnA setTitle:@"title" forState:UIControlStateNormal];
//    [_btnA setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
//    [_btnA setTitle:@"11111" forState:UIControlStateHighlighted];
//    [_btnA setTitleColor:[UIColor blueColor]forState:UIControlStateHighlighted];
//    [ _viewA addSubview:_btnA];
//    
//
//    
//    _viewB = [[ViewB alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
//    [_viewB setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:_viewB];
//
//    
//    _viewC = [[ViewC alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [_viewC setBackgroundColor:[UIColor brownColor]];
//    [_viewB addSubview:_viewC];

}


-(UIImage *)screenShot:(UIView *) view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
