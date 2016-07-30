//
//  AYXMLAttribute.m
//  AYXML
//
//  Created by Alan Yeh on 16/3/2.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#import "AYXMLAttribute.h"

@implementation AYXMLAttribute
+ (instancetype)attributeWithName:(NSString *)name andValue:(NSString *)value{
    NSParameterAssert(name.length > 0);
    AYXMLAttribute *newInstance = [AYXMLAttribute new];
    newInstance.name = name;
    newInstance.value = value ?: @"";
    return newInstance;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@=\"%@\"", self.name, self.value];
}
@end
