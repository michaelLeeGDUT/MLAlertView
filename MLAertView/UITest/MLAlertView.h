//
//  MLAlertView.h
//  UITest
//
//  Created by 黎嘉鸿 on 16/7/13.
//  Copyright © 2016年 黎嘉鸿. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MLAlertViewDelegate<NSObject>
@optional
-(void) didClickOkButton;    //在带有文本和按钮的弹窗中，确定按钮的回调方法
-(void) didClickOkButtonWithPassword: (NSString*) password;  //点击输入框和提示文本的弹窗中，确定按钮的回调方法
@end

@interface MLAlertView : UIView <UITextFieldDelegate>
@property (weak,nonatomic)  id <MLAlertViewDelegate> delegate;
-(void) show;
-(instancetype) initWithImage: (UIImage*) image andMessage: (NSString*) message withTitle: (NSString*) title isCanclable: (BOOL) isCanclable;
-(instancetype) initWithTextFieldAndButtonwithTitle: (NSString*) title isCanclable: (BOOL) isCanclable;
-(instancetype) initWithButtonAndMessage: (NSString*) message withTitle: (NSString*) title isCanclable: (BOOL) isCanclable;


@end
