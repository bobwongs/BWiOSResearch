//
//  CAGradientLayer+BMExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "CAGradientLayer+BMExtension.h"
#import <UIKit/UIColor.h>

#define BMb2b_Gradient_Start_Point CGPointMake(0, 1)
#define BMb2b_Gradient_End_Point CGPointMake(1, 0)

@implementation CAGradientLayer (BMExtension)

+ (CAGradientLayer *)bm_gradientLayerWithSize:(CGSize)size
                                   colorArray:(NSArray<UIColor *> *)colorArray
                                   startPoint:(CGPoint)startPoint
                                     endPoint:(CGPoint)endPoint {
    CAGradientLayer *gLayer = [[CAGradientLayer alloc] init];
    gLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gLayer.colors = colorArray;
    gLayer.startPoint = startPoint;
    gLayer.endPoint = endPoint;
    return gLayer;
}

+ (CAGradientLayer *)bm_gradientLayerWithSize:(CGSize)size
                                   startColor:(CGColorRef)startColorRef
                                     endColor:(CGColorRef)endColorRef
                                   startPoint:(CGPoint)startPoint
                                     endPoint:(CGPoint)endPoint {
    return [self bm_gradientLayerWithSize:size colorArray:@[(__bridge id)startColorRef, (__bridge id)endColorRef] startPoint:startPoint endPoint:endPoint];
}

+ (CAGradientLayer *)bm_gradientLayerWithColorArray:(NSArray<UIColor *> *)colorArray size:(CGSize)size {
    return [self  bm_gradientLayerWithSize:size startColor:BMb2b_brand_color1_start.CGColor endColor:BMb2b_brand_color1_end.CGColor startPoint:BMb2b_Gradient_Start_Point endPoint:BMb2b_Gradient_End_Point];
}

//+ (CAGradientLayer *)bm_gradientLayerInB2BBrandColor1WithSize:(CGSize)size {
//    return [self bm_gradientLayerWithColorArray:BMb2b_brand_color1 size:size];
//}
//
//+ (CAGradientLayer *)bm_gradientLayerInB2BBrandColor2WithSize:(CGSize)size {
//    return [self bm_gradientLayerWithColorArray:BMb2b_brand_color2 size:size];
//}

@end