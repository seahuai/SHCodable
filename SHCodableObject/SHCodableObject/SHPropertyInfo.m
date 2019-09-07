//
//  SHPropertyInfo.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHPropertyInfo.h"

@implementation SHPropertyInfo

- (instancetype)initWithProperty:(objc_property_t)property {
    if (!property) { return nil; }
    if (self = [super init]) {
        
        [self initializeInfoWithProperty:property];
        
    }
    return self;
}

- (void)initializeInfoWithProperty:(objc_property_t)property {
    
    _property = property;
    
    const char *name = property_getName(property);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
        // default Getter & Setter
        _getter = NSSelectorFromString(_name);
        
        NSString *setterName = [_name stringByReplacingOccurrencesOfString:[_name substringToIndex:1] withString:[_name substringToIndex:1].uppercaseString];
        _setter = NSSelectorFromString(setterName);
    }
    
    SHEncodingType encodingType = 0;
    unsigned int propertyAttributesCount = 0;
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &propertyAttributesCount);
    for (int i = 0; i < propertyAttributesCount; ++i) {
        objc_property_attribute_t attribute = attributes[i];
        switch (attribute.name[0]) {
            case 'T':
                // Type Encoding
                [self parseTypeEncoding:attribute.value];
                break;
            case 'V':
                // Ivar
                _ivarName = attribute.value ? [NSString stringWithUTF8String:attribute.value] : nil;
                break;
            case 'G':
                // Getter
                encodingType |= SHEncodingTypePropertyCustomGetter;
                if (attribute.value) {
                    NSString *aSelectorName = [NSString stringWithUTF8String:attribute.value];
                    _getter = NSSelectorFromString(aSelectorName);
                }
                break;
            case 'S':
                // Setter
                encodingType |= SHEncodingTypePropertyCustomSetter;
                if (attribute.value) {
                    NSString *aSelectorName = [NSString stringWithUTF8String:attribute.value];
                    _setter = NSSelectorFromString(aSelectorName);
                }
                break;
            case 'R':
                encodingType |= SHEncodingTypePropertyReadonly;
                break;
            case 'C':
                encodingType |= SHEncodingTypePropertyCopy;
                break;
            case '&':
                encodingType |= SHEncodingTypePropertyRetain;
                break;
            case 'N':
                encodingType |= SHEncodingTypePropertyNonatomic;
                break;
            case 'D':
                encodingType |= SHEncodingTypePropertyDynamic;
                break;
            case 'W':
                encodingType |= SHEncodingTypePropertyWeak;
                break;
            default:
                break;
        }
    }
    
    _type = encodingType;
    
    if (attributes) {
        free(attributes);
    }
}

- (void)parseTypeEncoding:(const char *)typeEncoding {
    if (!typeEncoding) { return; }
    
    _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    
    _type = SHEncodingGetType(typeEncoding);
    
    // 如果是对象，处理类名和协议
    if ((_type & SHEncodingTypeMask) == SHEncodingTypeObject && _typeEncoding.length > 0)
    {
        NSRange atRange = [_typeEncoding rangeOfString:@"@"];
        NSRange bracketRange = [_typeEncoding rangeOfString:@"<"];
        if (atRange.location != NSNotFound)
        {
            NSString *remainString = [_typeEncoding stringByReplacingOccurrencesOfString:@"@" withString:@""];
            remainString = [remainString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            if (remainString.length > 0) {
                if (bracketRange.location == NSNotFound)
                {
                    // get class, like @"NSString"
                    _cls = NSClassFromString(remainString);
                }
                else
                {
                    // get protocols, like @"<UITableViewDelegate><UITableViewDataSource>"
                    NSMutableArray *protocols = [NSMutableArray array];
                    NSScanner *scanner = [NSScanner scannerWithString:remainString];
                    while ([scanner scanString:@"<" intoString:NULL]) {
                        NSString *protocol = nil;
                        BOOL success = [scanner scanUpToString:@">" intoString:&protocol];
                        if (success && protocol.length > 0)
                        {
                            [protocols addObject:protocol];
                        }
                        [scanner scanString:@">" intoString:NULL];
                    }
                    _protocols = protocols.copy;
                }
            }
        }
    }
}



@end
