//
//  BWResearchVC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/11/17.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWResearchVC.h"

#define NumbersWithDot     @"0123456789.\n"
#define NumbersWithoutDot  @"0123456789\n"

@interface BWResearchVC () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *tfFirst;
@property (nonatomic, strong) UITextField *tfRegEx;

@end

@implementation BWResearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 50)];
    self.tfFirst = textField;
//    textField.delegate = self;
    textField.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textField];
    
    UITextField *tfRegEx = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 200, 50)];
    self.tfRegEx = tfRegEx;
    tfRegEx.placeholder = @"Regular Expression";
    tfRegEx.backgroundColor = [UIColor greenColor];
    [self.view addSubview:tfRegEx];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(buttonAct:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)buttonAct:(UIButton *)sender
{
    NSString *text = _tfFirst.text;
//    NSString *textRegEx = _tfRegEx.text;
//    NSLog(@"double value is %f", text.doubleValue);
    
    BOOL isValid = [[self class] bm_checkIsNumberAndOneDotOnlyInString:text];
    if (isValid) {
        NSLog(@"valid");
    } else {
        NSLog(@"invalid");
    }
}

+ (BOOL)bm_checkIsNumberAndOneDotOnlyInString:(NSString *)string {
    NSString *regex =[NSString stringWithFormat:@"^[0-9.]+$"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [predicate evaluateWithObject:string];
    if (!isMatch) {
        return NO;
    }
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array && array.count > 2) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL hasDot = YES;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        hasDot = NO;
    }
    if ([string length] > 0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.')//数据格式正确
        {
            if([textField.text length] == 0){
                if(single == '.'){
                    // 第一个数字不能为小数点
                    return NO;
                }
            }
            if (single == '.')
            {
                if(!hasDot)  //text中还没有小数点
                {
                    hasDot=YES;
                    return YES;
                }
                else
                {
                    // 已经输入过小数点
                    return NO;
                }
            }
            else
            {
                if (hasDot)  //存在小数点
                {
                    // 判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    NSInteger tt = range.location - ran.location;
                    if (tt <= 2){
                        return YES;
                    } else {
                        // 最多输入两位小数
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        } else {
            // 输入的数据格式不正确
            return NO;
        }
    }

    return YES;
}

@end
