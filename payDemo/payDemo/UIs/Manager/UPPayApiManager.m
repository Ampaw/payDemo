//
//  UPPayApiManager.m
//  payDemo
//
//  Created by Ampaw on 2016/11/26.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "UPPayApiManager.h"
#import "UPPaymentControl.h"

@implementation UPPayApiManager

+ (UPPayApiManager *)sharedManager
{
    static id intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[UPPayApiManager alloc] init];
    });
    return intance;
}

- (BOOL)isPaymentAppInstalled
{
    return [[UPPaymentControl defaultControl] isPaymentAppInstalled];
}

- (void)startPay:(NSString *)tn fromScheme:(NSString *)appScheme mode:(NSString *)mode viewController:(UIViewController *)viewController
{
    // tn 由服务器返回
    if (tn != nil && tn.length > 0) {
        // 发送订单，只需要两个参数“tn”和“mode”，其中：tn 由公司服务器返回；mode 有两种方式：“00”是正式环境，“01”是测试环境
        [[UPPaymentControl defaultControl] startPay:tn
                                         fromScheme:appScheme
                                               mode:mode
                                     viewController:viewController];
    }
    else {
        NSLog(@"网络连接失败！");
    }
}
- (void)handleOpenURL:(NSURL *)url
{
    [[UPPaymentControl defaultControl] handlePaymentResult:url
                                             completeBlock:^(NSString *code, NSDictionary *data) {
        if ([code isEqualToString:@"success"]) {
            NSLog(@"支付成功");
        }
        else if ([code isEqualToString:@"fail"]){
            NSLog(@"支付失败");
        }
        else if ([code isEqualToString:@"cancel"]) {
            NSLog(@"支付取消");
        }
    }];
}

@end
