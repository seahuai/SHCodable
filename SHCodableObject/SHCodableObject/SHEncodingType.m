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

