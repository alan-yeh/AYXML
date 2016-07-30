//
//  AYXMLElement.h
//  AYXML
//
//  Created by Alan Yeh on 16/3/2.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AYXML/AYXMLDefines.h>

@class AYXMLAttribute;

NS_ASSUME_NONNULL_BEGIN
@interface AYXMLElement : NSObject
- (instancetype)init AYXML_API_UNAVAILABLE("");
+ (instancetype)new AYXML_API_UNAVAILABLE("");

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)elementWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name andContent:(NSString *)content;
+ (instancetype)elementWithName:(NSString *)name andContent:(NSString *)content;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) AYXMLElement *parent;

@property (nonatomic, strong) NSMutableArray<AYXMLElement *> *elements;
- (instancetype)addElement:(AYXMLElement *)element;

@property (nonatomic, strong) NSMutableArray<AYXMLAttribute *> *attributes;
- (instancetype)addAttribute:(AYXMLAttribute *)attribute;

@property (nonatomic, strong) NSMutableString *content;

- (nullable AYXMLElement *)elementWithName:(NSString *)name;
- (NSArray<AYXMLElement *> *)elementsWithName:(NSString *)name;

- (nullable AYXMLElement *)elementAtPath:(NSString *)keyPath;
- (NSArray<AYXMLElement *> *)elementsAtPath:(NSString *)keyPath;

- (nullable NSString *)attributeValue:(NSString *)attributeName;

- (void)fixContent;
@end

AYXML_EXTERN AYXMLElement *AYXMLElementWithName(NSString *name);
@interface AYXMLElement (Chain)
- (AYXMLElement *)and;
- (AYXMLElement *(^)(NSString *))addContent;
- (AYXMLElement *(^)(NSString *, NSString *))addAttr;
- (AYXMLElement *(^)(AYXMLElement *))addElement;
- (AYXMLElement *(^)(NSArray<AYXMLElement *> *))addElements;
@end
NS_ASSUME_NONNULL_END
