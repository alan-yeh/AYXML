//
//  AYXMLDocument.m
//  AYXML
//
//  Created by Alan Yeh on 16/3/2.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#import "AYXMLDocument.h"
#import "AYXMLElement.h"
#import "AYXMLAttribute.h"

@interface _AYXMLDelegate : NSObject<NSXMLParserDelegate>
@property (nonatomic, strong) AYXMLDocument *result;
@property (nonatomic, strong) NSError *error;
@end

@implementation AYXMLDocument
+ (AYXMLDocument *)documentWithText:(NSString *)text{
    return [self documentWithData:[text dataUsingEncoding:NSUTF8StringEncoding] error:nil];
}

+ (AYXMLDocument *)documentWithText:(NSString *)text error:(NSError *__autoreleasing *)error{
    return [self documentWithData:[text dataUsingEncoding:NSUTF8StringEncoding] error:error];
}

+ (AYXMLDocument *)documentWithData:(NSData *)data{
    NSError *error;
    AYXMLDocument *doc = [self documentWithData:data error:&error];
    if (error != nil) {
        @throw error;
    }
    return doc;
}

+ (AYXMLDocument *)documentWithData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error{
    NSParameterAssert(data.length > 0);
    _AYXMLDelegate *delegate = [_AYXMLDelegate new];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = delegate;
    //    parser.shouldProcessNamespaces = YES;
    //    parser.shouldReportNamespacePrefixes = YES;
    if ([parser parse]) {
        return [delegate result];
    }else{
        if (error != NULL) {
            *error = delegate.error;
        }
        return nil;
    }
}

- (NSString *)description{
    return [self.rootElement description];
}

- (NSString *)debugDescription{
    return [self.rootElement debugDescription];
}
@end

@implementation _AYXMLDelegate{
    AYXMLElement *_currentElement;
}
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    _result = [[AYXMLDocument alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [_currentElement fixContent];
    _result.rootElement = _currentElement;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    AYXMLElement *element = [[AYXMLElement alloc] initWithName:elementName];
    
    element.parent = _currentElement;
    [_currentElement.elements addObject:element];
    _currentElement = element;
    
    for (NSString *key in attributeDict) {
        [element.attributes addObject:[AYXMLAttribute attributeWithName:key andValue:attributeDict[key]]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    [_currentElement.content appendString:[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding]];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [_currentElement.content appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (_currentElement.parent != nil) {
        _currentElement = _currentElement.parent;
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    self.result = nil;
    self.error = parseError;
}


@end