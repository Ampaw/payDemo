//
//  ANBResourceUtils.h
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/24.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANBResourceUtils : NSObject

+ (ANBResourceUtils *)manager;

/*
 *  从Bundle中获取指定名称的png图片
 */
- (UIImage *)image:(NSString *)name;

/*
 *  从Bundle中获取指定名称和类型的图片
 */
- (UIImage *)image:(NSString *)name type:(NSString *)type;

@end
