//
//  UPPayApiManager.h
//  payDemo
//
//  Created by Ampaw on 2016/11/26.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UPPayApiManager : NSObject

+ (UPPayApiManager *)sharedManager;

/**
 *  APP是否已安装检测接口，通过该接口得知用户是否安装银联支付的APP。
 *
 *  @return 返回是否已经安装了银联支付APP
 */
- (BOOL)isPaymentAppInstalled;

/**
 *  支付接口
 *
 *  @param tn             订单信息
 *  @param schemeStr      调用支付的app注册在info.plist中的scheme
 *  @param mode           支付环境【"00"为正式环境  "01"为测试环境】
 *  @param viewController 启动支付控件的viewController
 */
- (void)startPay:(NSString*)tn
      fromScheme:(NSString *)schemeStr
            mode:(NSString*)mode
  viewController:(UIViewController*)viewController;

/*
 *  处理钱包或者独立快捷app支付跳回商户app携带的支付结果Url
 *
 *  @param url            支付结果url，传入后由SDK解析
 */
- (void)handleOpenURL:(NSURL *)url;

@end
