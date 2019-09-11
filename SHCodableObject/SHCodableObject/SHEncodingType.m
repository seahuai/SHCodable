//
//  SHEncodingType.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/7.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHEncodingType.h"

SHEncodingType SHEncodingGetType(const char *typeEncoding) {
    char *type = (char *)typeEncoding;
    if (!type) return SHEncodingTypeUnknown;
    size_t len = strlen(type);
    if (len == 0) return SHEncodingTypeUnknown;
    
    SHEncodingType qualifier = 0;
    bool prefix = true;
    while (prefix) {
        switch (*type) {
            case 'r': {
                qualifier |= SHEncodingTypeQualifierConst;
                type++;
            } break;
            case 'n': {
                qualifier |= SHEncodingTypeQualifierIn;
                type++;
            } break;
            case 'N': {
                qualifier |= SHEncodingTypeQualifierInout;
                type++;
            } break;
            case 'o': {
                qualifier |= SHEncodingTypeQualifierOut;
                type++;
            } break;
            case 'O': {
                qualifier |= SHEncodingTypeQualifierBycopy;
                type++;
            } break;
            case 'R': {
                qualifier |= SHEncodingTypeQualifierByref;
                type++;
            } break;
            case 'V': {
                qualifier |= SHEncodingTypeQualifierOneway;
                type++;
            } break;
            default: { prefix = false; } break;
        }
    }
    
    len = strlen(type);
    if (len == 0) return SHEncodingTypeUnknown | qualifier;
    
    switch (*type) {
        case 'v': return SHEncodingTypeVoid | qualifier;
        case 'B': return SHEncodingTypeBool | qualifier;
        case 'c': return SHEncodingTypeInt8 | qualifier;
        case 'C': return SHEncodingTypeUInt8 | qualifier;
        case 's': return SHEncodingTypeInt16 | qualifier;
        case 'S': return SHEncodingTypeUInt16 | qualifier;
        case 'i': return SHEncodingTypeInt32 | qualifier;
        case 'I': return SHEncodingTypeUInt32 | qualifier;
        case 'l': return SHEncodingTypeInt32 | qualifier;
        case 'L': return SHEncodingTypeUInt32 | qualifier;
        case 'q': return SHEncodingTypeInt64 | qualifier;
        case 'Q': return SHEncodingTypeUInt64 | qualifier;
        case 'f': return SHEncodingTypeFloat | qualifier;
        case 'd': return SHEncodingTypeDouble | qualifier;
        case 'D': return SHEncodingTypeLongDouble | qualifier;
        case '#': return SHEncodingTypeClass | qualifier;
        case ':': return SHEncodingTypeSEL | qualifier;
        case '*': return SHEncodingTypeCString | qualifier;
        case '^': return SHEncodingTypePointer | qualifier;
        case '[': return SHEncodingTypeCArray | qualifier;
        case '(': return SHEncodingTypeUnion | qualifier;
        case '{': return SHEncodingTypeStruct | qualifier;
        case '@': {
            if (len == 2 && *(type + 1) == '?')
                return SHEncodingTypeBlock | qualifier;
            else
                return SHEncodingTypeObject | qualifier;
        }
        default: return SHEncodingTypeUnknown | qualifier;
    }
}

SHEncodingNSType SHEncodingGetNSType(Class cls) {
    if (!cls) {
        return SHEncodingTypeNSUnknown;
    }
    
    // 存在继承关系，应优先判断子类
    if ([cls isSubclassOfClass:NSNull.class]) {
        return SHEncodingTypeNSNull;
    }
    
    if ([cls isSubclassOfClass:NSValue.class]) {
        return SHEncodingTypeNSValue;
    }
    
    if ([cls isSubclassOfClass:NSDate.class]) {
        return SHEncodingTypeNSDate;
    }
    
    if ([cls isSubclassOfClass:NSURL.class]) {
        return SHEncodingTypeNSURL;
    }
    
    if ([cls isSubclassOfClass:NSMutableString.class]) {
        return SHEncodingTypeNSMutableString;
    }
    
    if ([cls isSubclassOfClass:NSString.class]) {
        return SHEncodingTypeNSString;
    }
    
    if ([cls isSubclassOfClass:NSDecimalNumber.class]) {
        return SHEncodingTypeNSDecimalNumber;
    }
    
    if ([cls isSubclassOfClass:NSNumber.class]) {
        return SHEncodingTypeNSNumber;
    }
    
    if ([cls isSubclassOfClass:NSMutableData.class]) {
        return SHEncodingTypeNSMutableData;
    }
    
    if ([cls isSubclassOfClass:NSData.class]) {
        return SHEncodingTypeNSData;
    }

    if ([cls isSubclassOfClass:NSMutableArray.class]) {
        return SHEncodingTypeNSMutableArray;
    }
    
    if ([cls isSubclassOfClass:NSArray.class]) {
        return SHEncodingTypeNSArray;
    }
    
    if ([cls isSubclassOfClass:NSMutableDictionary.class]) {
        return SHEncodingTypeNSMutableDictionary;
    }
    
    if ([cls isSubclassOfClass:NSDictionary.class]) {
        return SHEncodingTypeNSDictionary;
    }
    
    if ([cls isSubclassOfClass:NSMutableSet.class]) {
        return SHEncodingTypeNSMutableSet;
    }
    
    if ([cls isSubclassOfClass:NSSet.class]) {
        return SHEncodingTypeNSSet;
    }
    
    return SHEncodingTypeNSUnknown;
}

