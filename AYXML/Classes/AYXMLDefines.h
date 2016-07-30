//
//  AYXMLDefines.h
//  AYXML
//
//  Created by Alan Yeh on 16/3/3.
//  Copyright © 2016年 Alan Yeh. All rights reserved.
//

#ifndef AYXMLDefines_h
#define AYXMLDefines_h

#if defined(__cplusplus)
#define AYXML_EXTERN extern "C"
#else
#define AYXML_EXTERN extern
#endif

#define AYXML_EXTERN_STRING(KEY, COMMENT) AYXML_EXTERN NSString * const _Nonnull KEY;
#define AYXML_EXTERN_STRING_IMP(KEY) NSString * const KEY = @#KEY;
#define AYXML_EXTERN_STRING_IMP2(KEY, VAL) NSString * const KEY = VAL;

#define AYXML_ENUM_OPTION(ENUM, VAL, COMMENT) ENUM = VAL

#define AYXML_API_UNAVAILABLE(INFO) __attribute__((unavailable(INFO)))

#endif /* AYXMLDefines_h */
