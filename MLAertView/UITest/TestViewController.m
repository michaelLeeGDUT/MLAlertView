//
//  TestViewController.m
//  UITest
//
//  Created by 黎嘉鸿 on 16/7/13.
//  Copyright © 2016年 黎嘉鸿. All rights reserved.
//

#import "TestViewController.h"
#import "MLAlertView.h"

@interface TestViewController ()

@end


@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClick:(UIButton *)sender {
    
    MLAlertView* alertView=[[MLAlertView alloc] initWithButtonAndMessage:@"Hhsjdhu jsdhsjik Hisdsd" withTitle:@"Unpair Devices" isCanclable:YES];
    alertView.delegate=self;
    [alertView show];
    
    
    
    
}

- (IBAction)showAlwerView2:(UIButton *)sender {
    
    MLAlertView* alertView2=[[MLAlertView alloc] initWithImage:[UIImage imageNamed:@"loading"] andMessage:@"Please enter PIN code usingkeypad on safe" withTitle:@"Paring" isCanclable:YES];
    [alertView2 show];
}

- (IBAction)showAlertView3:(UIButton *)sender {
    
    MLAlertView* alertView3=[[MLAlertView alloc] initWithTextFieldAndButtonwithTitle:@"Paring" isCanclable:YES];
    alertView3.delegate=self;
    [alertView3 show];
}

-(void)didClickOkButton{
    NSLog(@"okButton was clicked!!!!!!!!!!!");
}

-(void)didClickOkButtonWithPassword:(NSString *)password{
    NSLog(@"psd: %@",password);
}
@end
