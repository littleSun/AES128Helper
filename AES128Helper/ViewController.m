//
//  ViewController.m
//  AES128Helper
//
//  Created by zengchao on 16/4/20.
//  Copyright © 2016年 zengchao. All rights reserved.
//

#import "ViewController.h"
#import "AES128Helper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *key = @"e10adc3949ba59abbe56e057f20f883e";
    NSString *originalText = @"AES";
    
    NSString *encryptText = [AES128Helper AES128EncryptText:originalText key:key];
    
    NSString *plainText = [AES128Helper AES128DecryptText:encryptText key:key];
    
    NSLog(@"\noriginal:\t%@\nencrypt:\t%@\ndecrypt:\t%@\n",originalText,encryptText,plainText);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
