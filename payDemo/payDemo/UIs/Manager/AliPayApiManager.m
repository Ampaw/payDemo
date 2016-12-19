//
//  AliPayApiManager.m
//  payDemo
//
//  Created by Ampaw on 2016/12/19.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "AliPayApiManager.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AliPayApiManager

+ (instancetype)shareManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)anb_alipayWithUrl:(NSURL *)url
{
    NSAssert(url, @"url地址不能为空！");
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if ([AliPayApiManager shareManager].anb_callback) {
            [AliPayApiManager shareManager].anb_callback(resultDic);
        }
    }];
    
    // 授权跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        // 解析 auth code
        NSString *result = resultDic[@"result"];
        NSString *authCode = nil;
        if (result.length>0) {
            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
            for (NSString *subResult in resultArr) {
                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                    authCode = [subResult substringFromIndex:10];
                    break;
                }
            }
        }
        NSLog(@"授权结果 authCode = %@", authCode?:@"");
    }];
}
- (void)anb_alipayWithOrderStr:(NSString *)orderStr appScheme:(NSString *)appScheme
{
    NSAssert(orderStr, @"订单信息不能为空！");
    NSAssert(appScheme, @"scheme 不能为空并且要和info配置中一样！");
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic){
        if ([AliPayApiManager shareManager].anb_callback) {
            [AliPayApiManager shareManager].anb_callback(resultDic);
        }
    }];
}

- (void)anb_alipayWithOrderStr:(NSString *)orderStr appScheme:(NSString *)appScheme callBack:(ANBAlipayCallback)callBack
{
    self.anb_callback = callBack;
    [self anb_alipayWithOrderStr:orderStr appScheme:appScheme];
}

@end
