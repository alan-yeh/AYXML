//
//  AYXMLTests.m
//  AYXMLTests
//
//  Created by Alan Yeh on 07/30/2016.
//  Copyright (c) 2016 Alan Yeh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AYXML/AYXML.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    AYXMLDocument *dom = [AYXMLDocument documentWithText:@"<response type=\'addrlistservice_sync_get\'>\n\t<resultcode>0</resultcode>\n\t<resultdesc>成功</resultdesc>\n\t<usernumber>8615820761101</usernumber>\n\t<infos> \n\t\t<info>\n\t\t\t<!--  f:field为字段的 ,k: key为属性名称-->\n\t\t\t<f k=\"name\">周星星</f> \n\t\t\t<f k=\"cid\">7530110355</f>\n\t\t\t<!--t表示邮箱类型,以下的is 的长称是items 都是用于放集合的，如果其他字段需要用is短称的话，都不允许-->\n\t\t\t<is t=\"email\">\n\t\t\t\t<i t=\"1\" id=\"00258107836\">13807636612</i>\n\t\t\t\t<i t=\"2\" id=\"00258107836\">13807636612</i>\n\t\t\t\t<i t=\"3\" id=\"00258107837\">13807636632</i>\n\t\t\t\t<i t=\"4\" id=\"00258107838\">13807636642</i>\n\t\t\t\t<i t=\"5\" id=\"00258107839\">13807636652</i>\n\t\t\t</is>\n\t\t\t<!--t表示电话类型-->\n\t\t\t<is t=\"tel\">\n\t\t\t\t<i t=\"1\" id=\"00258107833\">email2@139.com</i>\n\t\t\t\t<i t=\"2\" id=\"00258107834\">family2@139.com</i>\n\t\t\t</is>\n\t\t\t<is t=\"birth\">\n\t\t\t  <i t=\"1\" id=\"06917\">1980-01-01</i>\n\t\t\t  <i t=\"2\" id=\"06918\">1990-01-01</i>\n\t\t\t</is>\n\t\t</info>\t\n\t</infos> \n\t\n\t<!--分组信息详细-->\n\t<groupinfos> \n\t\t<groupinfo id=\"7530110354\" cntnum=\"1\" type=\"1\">御用分组</groupinfo> \n\t</groupinfos>\n\t<!--分组内的联系人ID信息详细-->\n\t<groupcontactinfos> \n\t\t<grouplistinfo id=\"7530110354\">7530110355,7530110356</grouplistinfo> \n\t</groupcontactinfos>\n</response>\n"];
    
    
    NSLog(@"%@", dom);
}

- (void)testKeyPath{
    AYXMLDocument *dom = [AYXMLDocument documentWithText:@"<response type=\'addrlistservice_sync_get\'>\n\t<resultcode>0</resultcode>\n\t<resultdesc>成功</resultdesc>\n\t<usernumber>8615820761101</usernumber>\n\t<infos> \n\t\t<info>\n\t\t\t<!--  f:field为字段的 ,k: key为属性名称-->\n\t\t\t<f k=\"name\">周星星</f> \n\t\t\t<f k=\"cid\">7530110355</f>\n\t\t\t<!--t表示邮箱类型,以下的is 的长称是items 都是用于放集合的，如果其他字段需要用is短称的话，都不允许-->\n\t\t\t<is t=\"email\">\n\t\t\t\t<i t=\"1\" id=\"00258107836\">13807636612</i>\n\t\t\t\t<i t=\"2\" id=\"00258107836\">13807636612</i>\n\t\t\t\t<i t=\"3\" id=\"00258107837\">13807636632</i>\n\t\t\t\t<i t=\"4\" id=\"00258107838\">13807636642</i>\n\t\t\t\t<i t=\"5\" id=\"00258107839\">13807636652</i>\n\t\t\t</is>\n\t\t\t<!--t表示电话类型-->\n\t\t\t<is t=\"tel\">\n\t\t\t\t<i t=\"1\" id=\"00258107833\">email2@139.com</i>\n\t\t\t\t<i t=\"2\" id=\"00258107834\">family2@139.com</i>\n\t\t\t</is>\n\t\t\t<is t=\"birth\">\n\t\t\t  <i t=\"1\" id=\"06917\">1980-01-01</i>\n\t\t\t  <i t=\"2\" id=\"06918\">1990-01-01</i>\n\t\t\t</is>\n\t\t</info>\t\n\t</infos> \n\t\n\t<!--分组信息详细-->\n\t<groupinfos> \n\t\t<groupinfo id=\"7530110354\" cntnum=\"1\" type=\"1\">御用分组</groupinfo> \n\t</groupinfos>\n\t<!--分组内的联系人ID信息详细-->\n\t<groupcontactinfos> \n\t\t<grouplistinfo id=\"7530110354\">7530110355,7530110356</grouplistinfo> \n\t</groupcontactinfos>\n</response>\n"];
    
    AYXMLElement *element = [dom.rootElement elementAtPath:@"infos.info.f"];
    
    XCTAssert([element.name isEqualToString:@"f"]);
    XCTAssert(element.attributes.count == 1);
    XCTAssert([element.content isEqualToString:@"周星星"]);
}

- (void)testBuildXML{
    
    AYXMLElement *request = [AYXMLElement elementWithName:@"request"];
    
    [request.elements addObject:[AYXMLElement elementWithName:@"request_metnod" andContent:@"addrlistservice_sync_delcontact"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"timestamp" andContent:@"2016-01-12 10:10:53"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"app_key" andContent:@"siguser"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"sid" andContent:@"MTQ1MjU2MTI5OTAwMDAxNzEw004137CC000001"]];
    [request.elements addObject:[AYXMLElement elementWithName:@"rmkey" andContent:@"2741281452561299"]];
    
    NSLog(@"%@", request);
}
@end

