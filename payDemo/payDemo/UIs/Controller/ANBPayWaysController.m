//
//  ANBPayWaysViewController.m
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/16.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "ANBPayWaysController.h"
#import "ZXPAutoLayout.h"
#import "ANBPayTitleView.h"
#import "ANBPaysModel.h"
#import "ANBPayWaysCell.h"
#import "WXPayApiManager.h"
#import "UPPayApiManager.h"
#import "AliPayApiManager.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ANBPayWaysController ()<ANBPayTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) ANBPayTitleView   *titleView;     // 头部View
@property (nonatomic, strong) UITableView       *tableView;     // 支付方式
@property (nonatomic, strong) UIButton          *sureBtn;       // 确定按钮

@property (nonatomic, copy) NSMutableArray      *cellContents;  // Cell数据数组

@end

@implementation ANBPayWaysController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellContents = [self setUpCellContents];
    
    [self addSubviewAndConstraints];
}

#pragma mark - cellDate
- (NSMutableArray *)setUpCellContents
{
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    
    // 支付宝
    ANBPaysModel *aliPayModel = [[ANBPaysModel alloc] init];
    aliPayModel.payWays = PayWays_ALIPAY;
    aliPayModel.isSelected = YES;
    [contents addObject:aliPayModel];
    
    // 银联
    ANBPaysModel *unionModel = [[ANBPaysModel alloc] init];
    unionModel.payWays = PayWays_UNION;
    unionModel.isSelected = NO;
    [contents addObject:unionModel];
    
    // 微信
    ANBPaysModel *weChatModel = [[ANBPaysModel alloc] init];
    weChatModel.payWays = PayWays_WECHAT;
    weChatModel.isSelected = NO;
    [contents addObject:weChatModel];
    return contents;
}

#pragma mark - perpareUI
- (void)addSubviewAndConstraints{
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.sureBtn];
    
    __weak typeof(self) weakSelf = self;
    [self.contentView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            layout.widthValue(SCREEN_HEIGHT * 0.8);
            layout.heightValue(SCREEN_HEIGHT * 0.7);
        }
        else {
            layout.widthValue(SCREEN_WIDTH * 0.8);
            layout.heightValue(SCREEN_WIDTH * 0.7);
        }
        layout.centerByView(weakSelf.view,0);
    }];
    [self.titleView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceEqualTo(weakSelf.contentView,0);
        layout.leftSpaceEqualTo(weakSelf.contentView,0);
        layout.widthEqualTo(weakSelf.contentView,0);
        layout.heightValue(44);
    }];
    [self.tableView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(weakSelf.titleView,0);
        layout.leftSpaceEqualTo(weakSelf.contentView,0).rightSpaceEqualTo(weakSelf.contentView,0);
        layout.bottomSpaceByView(weakSelf.sureBtn,8);
    }];
    [self.sureBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.bottomSpace(8);
        layout.xCenterByView(weakSelf.contentView,0);
        layout.heightValue(44);
        layout.widthValue(80);
    }];

}
/*
 * 支付点单信息【微信支付信息：调试代码】
 */
- (NSDictionary *)payInfo
{
    /*
     appid=wxb4ba3c02aa476ea1
     partid=1305176001
     prepayid=wx20161126150510dfb58f523a0807372053
     noncestr=51e6135c5706494a71c1aedf7ac3292e
     timestamp=1480143910
     package=Sign=WXPay
     sign=A864BA3A41F8207FDD90E33971027948
     */
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"wxb4ba3c02aa476ea1" forKey:@"appid"];
    [dict setValue:@"51e6135c5706494a71c1aedf7ac3292e" forKey:@"noncestr"];
    [dict setValue:@"Sign=WXPay" forKey:@"package"];
    [dict setValue:@"1305176001" forKey:@"partnerid"];
    [dict setValue:@"wx20161126150510dfb58f523a0807372053" forKey:@"prepayid"];
    [dict setValue:@"A864BA3A41F8207FDD90E33971027948" forKey:@"sign"];
    [dict setValue:@"1480143910" forKey:@"timestamp"];
    return dict;
}

#pragma mark - Action
- (void)sure:(UIButton *)sender
{
    for (ANBPaysModel *model in self.cellContents) {
        if (model.isSelected) {
            switch (model.payWays) {
                case PayWays_ALIPAY:
                {
                    NSLog(@"支付宝");
                    // 来自支付宝文档数据
                    NSString *orderString = @"app_id=2015052600090779&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22seller_id%22%3A%22%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%220.02%22%2C%22subject%22%3A%221%22%2C%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22314VYGIAGG7ZOYY%22%7D&charset=utf-8&method=alipay.trade.app.pay&sign_type=RSA&timestamp=2016-08-15%2012%3A12%3A15&version=1.0&sign=MsbylYkCzlfYLy9PeRwUUIg9nZPeN9SfXPNavUCroGKR5Kqvx0nEnd3eRmKxJuthNUx4ERCXe552EV9PfwexqW%2B1wbKOdYtDIb4%2B7PL3Pc94RZL0zKaWcaY3tSL89%2FuAVUsQuFqEJdhIukuKygrXucvejOUgTCfoUdwTi7z%2BZzQ%3D";
                    NSString *appScheme = @"scheme";
                    /**
                     *  发起支付
                     */
                    [[AliPayApiManager shareManager] anb_alipayWithOrderStr:orderString appScheme:appScheme];
                    
                    /**
                     *  支付回调
                     */
                    [AliPayApiManager shareManager].anb_callback = ^(NSDictionary *result){
                        if ([result[@"resultStatus"] isEqualToString:@"9000"]){
                            NSLog(@"支付成功");
                        }
                        else{
                            NSLog(@"支付失败");
                        }
                    };
                    
                }
                    break;
                    
                case PayWays_UNION:
                {
                    NSLog(@"银联");
                    if (![[UPPayApiManager sharedManager] isPaymentAppInstalled]) {
                        NSLog(@"提示安装银联‘安全支付助手’支付");
                        return;
                    }
                    else {
                        [[UPPayApiManager sharedManager] startPay:@"wx20161126150510dfb58f523a0807372053"
                                                       fromScheme:@"scheme"
                                                             mode:@"01"
                                                   viewController:self];
                    }
                }
                    break;
                    
                case PayWays_WECHAT:
                {
                    NSLog(@"微信");
                    if (![[WXPayApiManager sharedManager] isWXAppSupportApi]) {
                        NSLog(@"提示安装‘微信客户端’支付");
                        return;
                    }
                    else {
                        [[WXPayApiManager sharedManager] openWXPayWithPayInfo:[self payInfo]];
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    [self dismiss];
}
- (void)showPayWaysView:(UIViewController *)controller
{
    if (controller) {
        [controller addChildViewController:self];
        [controller.view addSubview:self.view];
        
        [self.view zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.edgeInsets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}
- (void)show
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.alpha = 1;
    } completion:nil];
    [self addKeyAnimation];
}
- (void)dismiss
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

/*
 * 添加动画
 */
- (void)addKeyAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.calculationMode = kCAAnimationCubic;
    animation.values = @[@1.07, @1.06, @1.05, @1.04, @1.03, @1.02, @1.01, @1.0];
    animation.duration = 0.4;
    [self.contentView.layer addAnimation:animation forKey:@"transform.scale"];
}
#pragma mark - ANBPayTitleViewDelegate
- (void)close
{
    [self dismiss];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    ANBPayWaysCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ANBPayWaysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  // 去除cell点击效果
    
    ANBPaysModel *cellModel = self.cellContents[indexPath.row];
    [cell cellReloadDate:cellModel.payWays isSelected:cellModel.isSelected];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (ANBPaysModel *model in self.cellContents) {
        model.isSelected = NO;
    }
    
    ANBPaysModel *model = self.cellContents[indexPath.row];
    model.isSelected = YES;
    [self.tableView reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Lazy
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 20;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (ANBPayTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[ANBPayTitleView alloc] initWithDelegate:self];
    }
    return _titleView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  // 去除分隔线
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // 隐藏空的Cell
        _tableView.scrollEnabled = NO;  // 禁止滚动
    }
    return _tableView;
}
- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.backgroundColor = [UIColor blueColor];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [_sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
