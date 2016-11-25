//
//  ANBPayWaysCell.h
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/24.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, PayWays){
    PayWays_ALIPAY  = 0,    // 支付宝
    PayWays_UNION   = 1,    // 银联
    PayWays_WECHAT  = 2,    // 微信
};

@interface ANBPayWaysCell : UITableViewCell

- (void)cellReloadDate:(NSInteger)payWays isSelected:(BOOL)isSelected;

@end
