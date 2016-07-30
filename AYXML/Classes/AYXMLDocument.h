//
//  AYXMLDocument.h
//  AYXML
//
//  Created by Alan Yeh on 16/3/2.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AYXMLElement;

NS_ASSUME_NONNULL_BEGIN
@interface AYXMLDocument : NSObject
@property (nonatomic, nullable, strong) NSString *xmlEncoding;
@property (nonatomic, nullable, strong) AYXMLElement *rootElement;

+ (AYXMLDocument *)documentWithText:(NSString *)text;
+ (AYXMLDocument *)documentWithText:(NSString *)text error:(NSError **)error;

+ (AYXMLDocument *)documentWithData:(NSData *)data;
+ (AYXMLDocument *)documentWithData:(NSData *)data error:(NSError **)error;
@end
NS_ASSUME_NONNULL_END