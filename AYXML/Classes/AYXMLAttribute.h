//
//  AYXMLAttribute.h
//  AYXML
//
//  Created by Alan Yeh on 16/3/2.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYXMLAttribute : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;

+ (instancetype)attributeWithName:(NSString *)name andValue:(NSString *)value;
@end
