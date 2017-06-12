//
//  ANBResourceUtils.m
//  ThirdPayDemo
//
//  Created by Ampaw on 2016/11/24.
//  Copyright © 2016年 Ampaw. All rights reserved.
//

#import "Anb_ResourceUtils.h"

@interface Anb_ResourceUtils ()
{
    NSBundle *_bundle;
}

@end

@implementation Anb_ResourceUtils

+ (Anb_ResourceUtils *)manager
{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Anb_ResourceUtils alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ThirdPay" ofType:@"bundle"];
        _bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return self;
}

- (UIImage *)image:(NSString *)name
{
    return [self image:name type:@"png"];
}

- (UIImage *)image:(NSString *)name type:(NSString *)type
{
    UIImage *img = [UIImage imageWithContentsOfFile:[_bundle pathForResource:[NSString stringWithFormat:@"%@@2x",name] ofType:type]];
    if (!img) {
        img = [UIImage imageWithContentsOfFile:[_bundle pathForResource:[NSString stringWithFormat:@"%@@3x",name] ofType:type]];
    }
    return img;
}

@end
