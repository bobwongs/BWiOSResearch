//
//  UIViewController+BMExtension.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/22.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BMExtension)

- (void)bmB2B_setNavigationLeftItemWithTitle:(NSString *)title action:(SEL)action;


- (void)bmB2B_setNavigationRightItemWithIcon:(UIImage *)iconImage action:(SEL)action;
- (void)bmB2B_setNavigationRightItemWithIconArray:(NSArray<UIImage *> *)iconArray actionArray:(NSArray<NSString *> *)actionStringArray;

- (void)bmB2B_setNavigationRightItemWithTitle:(NSString *)title action:(SEL)action;


+ (NSArray<UIBarButtonItem *> *)bm_arrayAddedFixedSpaceItemWithItemArray:(NSArray<UIBarButtonItem *> *)itemArray;

@end
