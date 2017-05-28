//
//  MLAlertView.m
//  UITest
//
//  Created by 黎嘉鸿 on 16/7/13.
//  Copyright © 2016年 黎嘉鸿. All rights reserved.
//

#import "MLAlertView.h"

#define kAlertViewWidth 300
#define kAlertViewHeight 250
#define kAlertViewImageWidth 90
#define kAlertViewImageHeight 90
#define kAlertViewButtonWidth 150
#define kAlertViewButtonHeight 40
#define kAlertViewTextFieldHeight 40
#define kAlertViewTextFieldWidth 200
#define kAlertViewCancleButtonWidth 20
#define kAlertViewCancleButtonHeight 20
#define kAlertViewTitleHeight 50
#define kAlertViewTitleWidth 160
#define kAlertViewMessageWidth 180
#define kAlertViewMessageHeight 70

@interface MLAlertView()
@property(strong,nonatomic) UIView* alertView; //最底层的一个view
@property(strong,nonatomic) UIView* backgroundView;  //蒙版view
@property(strong,nonatomic) UIImageView* backgroundImageView;  //与alertView大小一样的背景图
@property(strong,nonatomic) UIButton* okButton;  //确定按钮
@property(strong,nonatomic) UIButton* cancleButton;  //右上角的取消按钮
@property(strong,nonatomic) UIImageView* alertImageView;  //在alertView中显示的图片
@property(strong,nonatomic) UILabel* messageLable;  //在alertView中显示信息的lable
@property(strong,nonatomic) UILabel* titleLable;  //alertVeiw的标题
@property(strong,nonatomic) UITextField* textField;  //alertView里面的输入框
@end


@implementation MLAlertView


/**
 *  创建最底层的一个view，蒙版view以及与alertView大小一样的背景图
 */
-(void) setUpGeneralViews{
    self.backgroundView = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.5;
    [self addSubview:self.backgroundView];
    
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint centerPoint=CGPointMake(CGRectGetMidX(keywindow.frame), CGRectGetMidY(keywindow.frame));
    self.backgroundImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertViewImage"]];
    self.backgroundImageView.frame=CGRectMake(0, 0, kAlertViewWidth, kAlertViewHeight);
    self.backgroundImageView.contentMode=UIViewContentModeScaleToFill;
    
    self.alertView=[[UIView alloc] initWithFrame:CGRectMake(centerPoint.x-(kAlertViewWidth/2), centerPoint.y-(kAlertViewHeight/2), kAlertViewWidth, kAlertViewHeight)];
    [self addSubview: self.alertView];
    [self.alertView addSubview: self.backgroundImageView];
    
}


/**
 *  调用此方法将整个的自定义控件展示出来
 */
-(void)show{
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    [self.textField becomeFirstResponder];
}


/**
 *  创建带有文本和按钮的弹窗
 *
 *  @param message     提示文本
 *  @param title       弹窗标题
 *  @param isCanclable 是否有关闭按钮
 *
 *  @return 弹窗实例
 */
-(instancetype)initWithButtonAndMessage:(NSString *)message withTitle:(NSString *)title isCanclable:(BOOL)isCanclable{

    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame]) {
        [self setUpGeneralViews];
        
        [self setUpTitle:title];
        
        if (isCanclable) {
            [self setUpCancleButton];
        }
        
        self.messageLable=[[UILabel alloc] initWithFrame:CGRectMake((kAlertViewWidth-kAlertViewMessageWidth)/2, 100, kAlertViewMessageWidth, kAlertViewMessageHeight)];
        self.messageLable.textColor=[UIColor lightGrayColor];
        self.messageLable.textAlignment=NSTextAlignmentCenter;
        self.messageLable.numberOfLines=3;
        self.messageLable.text=message;
        self.messageLable.font=[UIFont systemFontOfSize:18];
        [self.alertView addSubview:self.messageLable];
        
        [self setUpOkButton];
        [self.okButton addTarget:self action:@selector(onClickOkButton) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return  self;
}


/**
 *  创建带有提示文本和提示图像的弹窗
 *
 *  @param image       提示图像
 *  @param message     提示文本
 *  @param title       弹窗标题
 *  @param isCanclable 是否带有关闭按钮
 *
 *  @return 弹窗实例
 */
-(instancetype)initWithImage:(UIImage *)image andMessage:(NSString *)message withTitle:(NSString *)title isCanclable:(BOOL)isCanclable{
    
    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame]) {
        [self setUpGeneralViews];
        [self setUpTitle:title];
        if (isCanclable) {
            [self setUpCancleButton];
        }
        
        self.alertImageView=[[UIImageView alloc] initWithFrame:CGRectMake((kAlertViewWidth-kAlertViewImageWidth)/2, 70, kAlertViewImageWidth, kAlertViewImageHeight)];
        [self.alertImageView setImage:image];
        [self.alertView addSubview:self.alertImageView];
        
        self.messageLable=[[UILabel alloc] initWithFrame:CGRectMake((kAlertViewWidth-kAlertViewMessageWidth)/2, 165, kAlertViewMessageWidth, kAlertViewMessageHeight)];
        self.messageLable.textColor=[UIColor lightGrayColor];
        self.messageLable.textAlignment=NSTextAlignmentCenter;
        self.messageLable.numberOfLines=3;
        self.messageLable.text=message;
        self.messageLable.font=[UIFont systemFontOfSize:18];
        [self.alertView addSubview:self.messageLable];

    }
    return  self;
}


/**
 *  创建带有输入框和提示文本的弹窗
 *
 *  @param title       弹窗标题
 *  @param isCanclable 是否带有关闭按钮
 *
 *  @return 弹窗实例
 */
-(instancetype)initWithTextFieldAndButtonwithTitle:(NSString *)title isCanclable:(BOOL)isCanclable{
    
    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame]) {
        [self setUpGeneralViews];
        [self setUpTitle:title];
        if (isCanclable) {
            [self setUpCancleButton];
        }
        
        self.textField=[[UITextField alloc] initWithFrame:CGRectMake((kAlertViewWidth-kAlertViewTextFieldWidth)/2, 110, kAlertViewTextFieldWidth, kAlertViewTextFieldHeight)];
        UIImageView* leftView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pass_icon"]];
        self.textField.background=[UIImage imageNamed:@"input"];
        leftView.frame=CGRectMake(0, 0, 12, 18);
        self.textField.leftView=leftView;
        self.textField.leftViewMode=UITextFieldViewModeAlways;
        self.textField.textColor=[UIColor lightGrayColor];
        self.textField.font=[UIFont systemFontOfSize:17];
        self.textField.textAlignment=NSTextAlignmentLeft;
        self.textField.placeholder=@"Enter password";
        self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.textField.keyboardType=UIKeyboardTypeDefault;
        self.textField.delegate=self;
        [self.alertView addSubview:self.textField];
        
        [self setUpOkButton];
        [self.okButton addTarget:self action:@selector(onClickOkButtonWithTextField) forControlEvents:UIControlEventTouchUpInside];
        
      }
    return  self;
}

-(void) onClickOkButtonWithTextField{
    
    if ([self.delegate respondsToSelector:@selector(didClickOkButtonWithPassword:)]) {
        if (self.textField.text!=nil) {
            NSString* password=self.textField.text;
            [self.delegate didClickOkButtonWithPassword:password];
        }else{
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
           }
        
    }else{
        NSLog(@"error!!!");
    }
    
    [self removeFromSuperview];
    self.alertView=nil;
}

-(void) onClickOkButton{
    
    if ([self.delegate respondsToSelector:@selector(didClickOkButton)]) {
        [self.delegate didClickOkButton];
    }else{
        NSLog(@"error!!!");
 
    }
    [self removeFromSuperview];
    self.alertView=nil;

}

-(void) didClickCancleButton{
    [self removeFromSuperview];
    self.alertView=nil;
}


/**
 *  创建弹窗标题
 *
 *  @param title 弹窗标题
 */
-(void) setUpTitle: (NSString*) title{
    
    self.titleLable=[[UILabel alloc] initWithFrame:CGRectMake((kAlertViewWidth-kAlertViewTitleWidth)/2, 5, kAlertViewTitleWidth, kAlertViewTitleHeight)];
    self.titleLable.textColor=[UIColor whiteColor];
    self.titleLable.textAlignment=NSTextAlignmentCenter;
    self.titleLable.text=title;
    self.titleLable.font=[UIFont systemFontOfSize:20];
    [self.alertView addSubview:self.titleLable];

}

/**
 *  创建关闭按钮
 */
-(void) setUpCancleButton{
    
    self.cancleButton=[[UIButton alloc] initWithFrame:CGRectMake(kAlertViewWidth-kAlertViewCancleButtonWidth-15, 15, kAlertViewCancleButtonWidth, kAlertViewCancleButtonHeight)];
    [self.cancleButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(didClickCancleButton) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:self.cancleButton];

}

/**
 *  创建确定按钮
 */
-(void) setUpOkButton{
    
    self.okButton=[[UIButton alloc] initWithFrame:CGRectMake((kAlertViewWidth-kAlertViewButtonWidth)/2, 180, kAlertViewButtonWidth, kAlertViewButtonHeight)];
    [self.okButton setImage:[UIImage imageNamed:@"okbtn"] forState:UIControlStateNormal];
    [self.okButton setImage:[UIImage imageNamed:@"canclebtn"] forState:UIControlStateHighlighted];
    [self.alertView addSubview:self.okButton];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"Return is clicked!");
    [textField resignFirstResponder];
    return YES;
}

@end
