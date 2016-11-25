//
//  ANBPayTitleView.m
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/22.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "ANBPayTitleView.h"
#import "ZXPAutoLayout.h"
#import "ANBResourceUtils.h"

@interface ANBPayTitleView ()

@end

@implementation ANBPayTitleView

- (instancetype)initWithDelegate:(id<ANBPayTitleViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    // titleLabel
    UILabel *title = [UILabel new];
    title.text = @"请选择支付方式";
    [title sizeToFit];
    [self addSubview:title];
    [title zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.centerByView(weakSelf,0);
    }];
    
    // closeBtn
    UIButton *close = [UIButton new];
    [close setBackgroundColor:[UIColor clearColor]];
    [close setBackgroundImage:[[ANBResourceUtils manager] image:@"close"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [close sizeToFit];
    [self addSubview:close];
    [close zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.rightSpaceEqualTo(weakSelf,10);
        layout.yCenterByView(weakSelf,0);
    }];
    
    // bottomLine
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(0).rightSpace(0).bottomSpace(0);
        layout.heightValue(1);
    }];
}
- (void)close:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(close)]) {
        [self.delegate close];
    }
}

@end
