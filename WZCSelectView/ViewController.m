//
//  ViewController.m
//  WZCSelectView
//
//  Created by 邬志成 on 2016/12/7.
//  Copyright © 2016年 邬志成. All rights reserved.
//

#import "ViewController.h"
#import "WZCSelectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}


- (IBAction)topAction:(id)sender {
    UIImage *image = [UIImage imageNamed:@"bgimg.jpg"];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.9, self.view.frame.size.width*0.7)];
    imgV.image = image;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.layer.masksToBounds = YES;
    //一句话调用，简单实用
    [WZCSelectView showView:imgV position:WZCSelectViewShowPositionStyleTop];
    
}
- (IBAction)centerAction:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"bgimg.jpg"];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.9, self.view.frame.size.width*0.7)];
    imgV.image = image;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.layer.masksToBounds = YES;
    //一句话调用，简单实用
    [WZCSelectView showView:imgV position:WZCSelectViewShowPositionStyleCenter];
}
- (IBAction)bottomAction:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"bgimg.jpg"];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.9, self.view.frame.size.width*0.7)];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.image = image;
    imgV.layer.masksToBounds = YES;
    //一句话调用，简单实用
    [WZCSelectView showView:imgV position:WZCSelectViewShowPositionStyleBottom];
}

@end
