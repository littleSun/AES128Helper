//
//  AES128Util.h
//  ASE128Demo
//
//  Created by zengchao on 16/04/20.
//  Copyright (c) 2016 Xweisoft inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128Helper : NSObject

+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

@end
