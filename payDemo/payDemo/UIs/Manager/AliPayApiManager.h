//
//  AliPayApiManager.h
//  payDemo
//
//  Created by Ampaw on 2016/12/19.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ANBAlipayCallback)(NSDictionary *resultDic);
@interface AliPayApiManager : NSObject

/**
 *  @author 安波
 *
 *  统一支付宝的回调，支付后可以实现回调
 */
@property (nonatomic,copy)ANBAlipayCallback anb_callback;

+ (instancetype)shareManager;
/*
 * @author 安波
 *
 * 支付宝授权支付-AppDelegate中实现
 */
- (void)anb_alipayWithUrl:(NSURL *)url;
/*
 * @author 安波
 *
 * 发起支付，任意地方
 */
- (void)anb_alipayWithOrderStr:(NSString *)orderStr appScheme:(NSString *)appScheme;
/*
 * @author 安波
 *
 * 发起支付，带支付后回调
 */
- (void)anb_alipayWithOrderStr:(NSString *)orderStr appScheme:(NSString *)appScheme callBack:(ANBAlipayCallback)callBack;


@end
