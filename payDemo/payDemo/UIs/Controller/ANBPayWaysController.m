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

#pragma mark - Action
- (void)sure:(UIButton *)sender
{
    for (ANBPaysModel *model in self.cellContents) {
        if (model.isSelected) {
            switch (model.payWays) {
                case PayWays_ALIPAY:
                {
                    NSLog(@"支付宝");
                    
                }
                    break;
                    
                case PayWays_UNION:
                {
                    NSLog(@"银联");
                }
                    break;
                    
                case PayWays_WECHAT:
                {
                    NSLog(@"微信");
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
