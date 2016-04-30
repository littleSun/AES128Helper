//
//  AES128Util.m
//  ASE128Demo
//
//  Created by zengchao on 16/04/20.
//  Copyright (c) 2016 Xweisoft inc. All rights reserved.
//

#import "AES128Helper.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation AES128Helper

+(NSString *)AES128EncryptText:(NSString *)plainText key:(NSString *)key
{
    NSMutableData *keyData = [NSMutableData dataWithLength:kCCKeySizeAES128];
    [keyData setData:[self convertHexStrToData:key]];
    [keyData setLength:kCCKeySizeAES128];
    
    const char *keyPtr = keyData.bytes;
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = (dataLength + kCCBlockSizeAES128) &~(kCCBlockSizeAES128 - 1);
    void *buffer = malloc(bufferSize* sizeof(char));
  
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [GTMBase64 stringByEncodingData:resultData];

    }
    free(buffer);
    return nil;
}


+(NSString *)AES128DecryptText:(NSString *)encryptText key:(NSString *)key
{
    NSMutableData *keyData = [NSMutableData dataWithLength:kCCKeySizeAES128];
    [keyData setData:[self convertHexStrToData:key]];
    [keyData setLength:kCCKeySizeAES128];
    
    const char *keyPtr = keyData.bytes;
    
    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];

    size_t bufferSize = (dataLength + kCCBlockSizeAES128) &~(kCCBlockSizeAES128 - 1);
    void *buffer = malloc(bufferSize* sizeof(char));
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}


+(NSData *)AES128Encrypt:(NSData *)plainData key:(NSString *)key
{
    NSMutableData *keyData = [NSMutableData dataWithLength:kCCKeySizeAES128];
    [keyData setData:[self convertHexStrToData:key]];
    [keyData setLength:kCCKeySizeAES128];
    
    const char *keyPtr = keyData.bytes;
    
    NSData* data = plainData;
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = (dataLength + kCCBlockSizeAES128) &~(kCCBlockSizeAES128 - 1);
    void *buffer = malloc(bufferSize* sizeof(char));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return resultData;
    }
    free(buffer);
    return nil;
}

+(NSData *)AES128Decrypt:(NSData *)encryptData key:(NSString *)key
{
    NSMutableData *keyData = [NSMutableData dataWithLength:kCCKeySizeAES128];
    [keyData setData:[self convertHexStrToData:key]];
    [keyData setLength:kCCKeySizeAES128];
    
    const char *keyPtr = keyData.bytes;
    
    NSData *data = encryptData;
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = (dataLength + kCCBlockSizeAES128) &~(kCCBlockSizeAES128 - 1);
    void *buffer = malloc(bufferSize* sizeof(char));
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);
    return nil;
}


+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

@end
