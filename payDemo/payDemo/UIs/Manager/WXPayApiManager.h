//
//  WXPayApiManager.h
//  payDemo
//
//  Created by Ampaw on 2016/11/25.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXPayApiManager : NSObject<WXApiDelegate>

+ (WXPayApiManager *)sharedManager;

/*
 * 注册微信支付
 */
- (void)registerWXPay:(NSString *)appId;
/**
 *  是否支付微信支付
 */
- (BOOL)isWXAppSupportApi;
/*
 * 调用微信支付
 */
- (NSString *)openWXPayWithPayInfo:(NSDictionary *)payInfo;
/*
 * 支付完成跳转回来App
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@end
