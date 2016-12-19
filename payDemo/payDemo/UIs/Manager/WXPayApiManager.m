//
//  WXPayApiManager.m
//  payDemo
//
//  Created by Ampaw on 2016/11/25.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "WXPayApiManager.h"

@implementation WXPayApiManager

+ (WXPayApiManager *)sharedManager
{
    static id intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[[self class] alloc] init];
    });
    return intance;
}

- (BOOL)isWXAppSupportApi
{
    return [WXApi isWXAppSupportApi];
}
/*
 * 注册微信支付
 */
- (void)registerWXPay:(NSString *)appId
{
    [WXApi registerApp:appId withDescription:@"PywDemo"];
}
/*
 * 调用微信支付
 */
- (NSString *)openWXPayWithPayInfo:(NSDictionary *)payInfo
{
    if(payInfo != nil){
        NSMutableString *retcode = [payInfo objectForKey:@"retcode"];
        if (retcode.intValue == 0){
            NSMutableString *stamp  = [payInfo objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [payInfo objectForKey:@"partnerid"];
            req.prepayId            = [payInfo objectForKey:@"prepayid"];
            req.nonceStr            = [payInfo objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [payInfo objectForKey:@"package"];
            req.sign                = [payInfo objectForKey:@"sign"];
            [WXApi sendReq:req]; // 发送请求到微信，等待微信返回onResp
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[payInfo objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            return @"";
        }else{
            return [payInfo objectForKey:@"retmsg"];
        }
    }
    return @"";
}
/*
 * 支付完成跳转回来App  url 微信启动第三方应用时传递过来的 URL
 */
- (void)handleOpenURL:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:[WXPayApiManager sharedManager]];
}
#pragma mark - WXApiDelegate
/*
 * 支付完成回调
 */
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                NSLog(@"支付成功");
                break;
            case WXErrCodeCommon:
                NSLog(@"支付失败");
                break;
            case WXErrCodeUserCancel:
                NSLog(@"支付取消");
                break;
            default:
                NSLog(@"支付失败");
                break;
        }
    }
}

@end
