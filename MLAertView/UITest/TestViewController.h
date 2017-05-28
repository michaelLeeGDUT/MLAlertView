//
//  TestViewController.h
//  UITest
//
//  Created by 黎嘉鸿 on 16/7/13.
//  Copyright © 2016年 黎嘉鸿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLAlertView.h"

@interface TestViewController : UIViewController <MLAlertViewDelegate>
- (IBAction)onClick:(UIButton *)sender;
- (IBAction)showAlwerView2:(UIButton *)sender;
- (IBAction)showAlertView3:(UIButton *)sender;

@end
