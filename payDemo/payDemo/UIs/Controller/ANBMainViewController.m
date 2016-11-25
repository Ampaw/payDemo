//
//  ViewController.m
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/16.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "ANBMainViewController.h"
#import "ZXPAutoLayout.h"
#import "ANBPayWaysController.h"

@interface ANBMainViewController ()
@property (nonatomic, strong) UIButton *payBtn;

@end

@implementation ANBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.payBtn];
    [self.payBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpace(100);
        layout.leftSpace(100);
        layout.rightSpace(100);
        layout.heightValue(40);
    }];
    
}

#pragma mark - Action
- (void)startPay:(UIButton *)btn
{
    [[ANBPayWaysController alloc] showPayWaysView:self];
}

#pragma mark - Lazy
- (UIButton *)payBtn
{
    if (!_payBtn) {
        _payBtn = [UIButton new];
        [_payBtn setBackgroundColor:[UIColor blueColor]];
        [_payBtn setTitle:@"支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_payBtn addTarget:self action:@selector(startPay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}


@end
