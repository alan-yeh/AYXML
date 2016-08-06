# AYXML

[![CI Status](http://img.shields.io/travis/alan-yeh/AYXML.svg?style=flat)](https://travis-ci.org/alan-yeh/AYXML)
[![Version](https://img.shields.io/cocoapods/v/AYXML.svg?style=flat)](http://cocoapods.org/pods/AYXML)
[![License](https://img.shields.io/cocoapods/l/AYXML.svg?style=flat)](http://cocoapods.org/pods/AYXML)
[![Platform](https://img.shields.io/cocoapods/p/AYXML.svg?style=flat)](http://cocoapods.org/pods/AYXML)

## 引用
　　使用[CocoaPods](http://cocoapods.org)可以很方便地引入AYXML。Podfile添加AYXML的依赖。

```ruby
pod "AYXML"
```

## 简介
　　AYXML可以很方便地解析、生成XML。配合[AYQuery](https://github.com/alan-yeh/AYQuery)的话，开发效率翻倍。

## 用例

**test.xml**

```xml
   <response type="addrlistservice_sync_get">
      <resultcode>0</resultcode>
      <resultdesc>成功</resultdesc>
      <usernumber>8615820761101</usernumber>
      <infos>
         <info>
            <f k="name">周星星</f>
            <f k="cid">7530110355</f>
            <is t="email">
               <i t="1" id="00258107836">13600000000</i>
               <i t="2" id="00258107836">13700000000</i>
               <i t="3" id="00258107837">13800000000</i>
               <i t="4" id="00258107838">13900000000</i>
            </is>
            <is t="tel">
               <i t="1" id="00258107833"> 13600000000@126.com</i>
               <i t="2" id="00258107834"> 13700000000@126.com</i>
            </is>
            <is t="birth">
               <i t="1" id="06917">1980-01-01</i>
               <i t="2" id="06918">1990-01-01</i>
            </is>
         </info>
      </infos>
      <groupinfos>
         <groupinfo id="7530110354" cntnum="1" type="1">御用分组</groupinfo>
      </groupinfos>
      <groupcontactinfos>
         <grouplistinfo id="7530110354">7530110355,7530110356</grouplistinfo>
      </groupcontactinfos>
   </response>
```

### 解析XML
```objective-c
    NSString *text = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    AYXMLDocument *dom = [AYXMLDocument documentWithText: text];
    NSLog(@"%@", dom);
```

### 获取某个节点的值
```objective-c
    //返回符合路径的第一个元素
    AYXMLElement *element = [dom.rootElement elementAtPath:@"infos.info.f"];
    
    XCTAssert([element.name isEqualToString:@"f"]);
    XCTAssert(element.attributes.count == 1);
    XCTAssert([element.content isEqualToString:@"周星星"]);
```

### 构建XML
```objective-c
    AYXMLElement *request = [AYXMLElement elementWithName:@"request"];
    [request.elements addObject:[AYXMLElement elementWithName:@"request_metnod" andContent:@"addrlistservice_sync_delcontact"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"timestamp" andContent:@"2016-01-12 10:10:53"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"app_key" andContent:@"siguser"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"rmkey" andContent:@"2741281452561299"]];
    
    NSLog(@"%@", request);
```

### 配合AYQuery快速构建
```objective-c
    NSDictionary *dic = @{
                          @"request_method": @"addrlistservice_sync_delcontact",
                          @"timestamp": @"2016-01-12 10:10:53",
                          @"app_key": @"siguser",
                          @"rmkey": @"2741281452561299"
                          };
    AYXMLElement *request = [AYXMLElement elementWithName:@"request"];
    request.addElements(dic.query.select(^(id entry){
        return [AYXMLElement elementWithName:entry[@"Key"] andContent:entry[@"Value"]];
    }));
```

### 配合AYQuery快速筛选
```objective-c
    //筛选根节点下的所有f节点
    dom.rootElement.elements.query.where(^BOOL(AYXMLElement *element){
        return [element.name isEqualToString:@"f"];
    });
```
## License

AYXML is available under the MIT license. See the LICENSE file for more info.
