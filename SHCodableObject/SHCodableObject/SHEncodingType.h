//
//  SHEncodingType.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SHEncodingType_h
#define SHEncodingType_h

/**
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html

 - SHEncodingTypeMask
 */
typedef NS_OPTIONS(NSUInteger, SHEncodingType) {
    SHEncodingTypeMask       = 0xFF, ///< mask of type value
    SHEncodingTypeUnknown    = 0, ///< unknown
    SHEncodingTypeVoid       = 1, ///< void
    SHEncodingTypeBool       = 2, ///< bool
    SHEncodingTypeInt8       = 3, ///< char / BOOL
    SHEncodingTypeUInt8      = 4, ///< unsigned char
    SHEncodingTypeInt16      = 5, ///< short
    SHEncodingTypeUInt16     = 6, ///< unsigned short
    SHEncodingTypeInt32      = 7, ///< int
    SHEncodingTypeUInt32     = 8, ///< unsigned int
    SHEncodingTypeInt64      = 9, ///< long long
    SHEncodingTypeUInt64     = 10, ///< unsigned long long
    SHEncodingTypeFloat      = 11, ///< float
    SHEncodingTypeDouble     = 12, ///< double
    SHEncodingTypeLongDouble = 13, ///< long double
    SHEncodingTypeObject     = 14, ///< id
    SHEncodingTypeClass      = 15, ///< Class
    SHEncodingTypeSEL        = 16, ///< SEL
    SHEncodingTypeBlock      = 17, ///< block
    SHEncodingTypePointer    = 18, ///< void*
    SHEncodingTypeStruct     = 19, ///< struct
    SHEncodingTypeUnion      = 20, ///< union
    SHEncodingTypeCString    = 21, ///< char*
    SHEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    SHEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    SHEncodingTypeQualifierConst  = 1 << 8,  ///< const
    SHEncodingTypeQualifierIn     = 1 << 9,  ///< in
    SHEncodingTypeQualifierInout  = 1 << 10, ///< inout
    SHEncodingTypeQualifierOut    = 1 << 11, ///< out
    SHEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    SHEncodingTypeQualifierByref  = 1 << 13, ///< byref
    SHEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    SHEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    SHEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    SHEncodingTypePropertyCopy         = 1 << 17, ///< copy
    SHEncodingTypePropertyRetain       = 1 << 18, ///< retain
    SHEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    SHEncodingTypePropertyWeak         = 1 << 20, ///< weak
    SHEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    SHEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    SHEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

// Method Define
SHEncodingType SHEncodingGetType(const char *typeEncoding);

#endif /* SHEncodingType_h */
