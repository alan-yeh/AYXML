//
//  AYXMLElement.m
//  AYXML
//
//  Created by Alan Yeh on 16/3/2.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#import "AYXMLElement.h"
#import "AYXMLAttribute.h"

@implementation AYXMLElement

- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

+ (instancetype)elementWithName:(NSString *)name{
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name andContent:(NSString *)content{
    if (self = [super init]) {
        self.name = name;
        self.content = content.mutableCopy;
    }
    return self;
}

+ (instancetype)elementWithName:(NSString *)name andContent:(NSString *)content{
    return [[self alloc] initWithName:name andContent:content];
}

- (void)setName:(NSString *)name{
    NSParameterAssert(name.length > 0);
    _name = [name copy];
}

- (NSMutableArray<AYXMLElement *> *)elements{
    return _elements ?: (_elements = [NSMutableArray new]);
}

- (NSMutableArray<AYXMLAttribute *> *)attributes{
    return _attributes ?: (_attributes = [NSMutableArray new]);
}

- (NSCharacterSet *)charset{
    static NSMutableCharacterSet *charset = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        charset = [NSMutableCharacterSet whitespaceCharacterSet];
        [charset addCharactersInString:@"\n"];
        [charset addCharactersInString:@"\r"];
        [charset addCharactersInString:@"\t"];
    });
    return charset;
}

- (instancetype)addElement:(AYXMLElement *)element{
    [self.elements addObject:element];
    return self;
}

- (instancetype)addAttribute:(AYXMLAttribute *)attribute{
    [self.attributes addObject:attribute];
    return self;
}

- (NSMutableString *)content{
    return _content ?: (_content = [NSMutableString new]);
}

- (void)fixContent{
    NSString *content = [self.content stringByTrimmingCharactersInSet:self.charset];
    self.content = [[NSMutableString alloc] initWithString:content];
    [self.elements makeObjectsPerformSelector:@selector(fixContent)];
}

- (NSArray<AYXMLElement *> *)elementsWithName:(NSString *)name{
    NSMutableArray<AYXMLElement *> *elements = [NSMutableArray new];
    for (AYXMLElement *node in self.elements) {
        if ([node.name isEqualToString:name]) {
            [elements addObject:node];
        }
    }
    return elements;
}

- (AYXMLElement *)elementWithName:(NSString *)name{
    for (AYXMLElement *node in self.elements) {
        if ([node.name isEqualToString:name]) {
            return node;
        }
    }
    return nil;
}

- (AYXMLElement *)elementAtPath:(NSString *)keyPath{
    NSArray *result = [self elementsAtPath:keyPath];
    return result.count ? result[0] : nil;
}

- (NSArray<AYXMLElement *> *)elementsAtPath:(NSString *)keyPath{
    NSParameterAssert([keyPath isKindOfClass:[NSString class]]);
    NSParameterAssert(keyPath.length > 0);
    NSArray<NSString *> *paths = [keyPath componentsSeparatedByString:@"."];
    return [self _findElementsIn:self withPath:paths.mutableCopy];
}

- (NSArray<AYXMLElement *> *)_findElementsIn:(AYXMLElement *)parent withPath:(NSMutableArray<NSString *> *)paths{
    NSParameterAssert(paths.count > 0);
    NSString *path = paths[0];
    [paths removeObjectAtIndex:0];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (AYXMLElement *node in parent.elements) {
        if ([node.name isEqualToString:path]) {
            if (paths.count > 0) {
                return [self _findElementsIn:node withPath:paths];
            }else{
                [result addObject:node];
            }
        }
    }
    return result;
}

- (NSString *)attributeValue:(NSString *)attributeName{
    for (AYXMLAttribute *attr in self.attributes) {
        if ([attr.name isEqualToString:attributeName]) {
            return attr.value;
        }
    }
    return nil;
}

- (NSString *)description{
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendString:@"<"];
    [desc appendString:self.name];
    for (AYXMLAttribute *attribute in self.attributes) {
        [desc appendFormat:@" %@=\"%@\"", attribute.name, attribute.value];
    }
    [desc appendString:@">"];
    
    if (self.elements.count){
        for (AYXMLElement *element in self.elements) {
            [desc appendString:element.description];
        }
    }else if (self.content.length) {
        [desc appendString:self.content];
    }
    [desc appendFormat:@"</%@>", self.name];
    return desc;
}

- (NSString *)debugDescription{
    NSString *space = [self _debug_space];
    
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendString:space];
    [desc appendString:@"<"];
    [desc appendString:self.name];
    for (AYXMLAttribute *attribute in self.attributes) {
        [desc appendFormat:@" %@=\"%@\"", attribute.name, attribute.value];
    }
    [desc appendString:@">"];
    
    if (self.elements.count){
        [desc appendString:@"\n"];
        for (AYXMLElement *element in self.elements) {
            [desc appendString:element.debugDescription];
        }
        [desc appendString:space];
    }else if (self.content.length) {
        [desc appendString:self.content];
    }
    [desc appendFormat:@"</%@>\n", self.name];
    return desc;
}

- (NSString *)_debug_space{
    NSArray *callSymbols = [NSThread callStackSymbols];
    NSInteger layer = -1;
    for (NSString *symbol in callSymbols) {
        if ([symbol containsString:@"debugDescription"]) {
            layer ++;
        }
    }
    
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:layer * 3];
    for (NSUInteger i = 0; i < layer * 3; i ++) {
        [str appendString:@" "];
    }
    return str;
}

@end

AYXMLElement *AYXMLElementWithName(NSString *name){
    return [[AYXMLElement alloc] initWithName:name];
}

@implementation AYXMLElement (Chain)
- (AYXMLElement *)and{
    return self;
}

- (AYXMLElement * (^)(NSString *))addContent{
    return ^(NSString *content){
        [self.content appendString:content];
        return self;
    };
}

- (AYXMLElement *(^)(NSString *, NSString *))addAttr{
    return ^(NSString *attrName, NSString *attrValue){
        [self.attributes addObject:[AYXMLAttribute attributeWithName:attrName andValue:attrValue]];
        return self;
    };
}

- (AYXMLElement *(^)(AYXMLElement *))addElement{
    return ^(AYXMLElement *element){
        [self.elements addObject:element];
        return self;
    };
}

- (AYXMLElement *(^)(NSArray<AYXMLElement *> *))addElements{
    return ^(NSArray<AYXMLElement *> *elements){
        [self.elements addObjectsFromArray:elements];
        return self;
    };
}
@end
