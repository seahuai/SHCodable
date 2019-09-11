//
//  SHPropertyInfo+Method.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/11.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHPropertyInfo+Method.h"

@implementation SHPropertyInfo (Method)

- (BOOL)isCNumber {
    switch (self.type & SHEncodingTypeMask) {
        case SHEncodingTypeBool:
        case SHEncodingTypeInt8:
        case SHEncodingTypeUInt8:
        case SHEncodingTypeInt16:
        case SHEncodingTypeUInt16:
        case SHEncodingTypeInt32:
        case SHEncodingTypeUInt32:
        case SHEncodingTypeInt64:
        case SHEncodingTypeUInt64:
        case SHEncodingTypeFloat:
        case SHEncodingTypeDouble:
        case SHEncodingTypeLongDouble:
            return YES;
        default:
            return NO;
    }
}

- (BOOL)isArchivedStruct {
    // CG
    if ((self.type & SHEncodingTypeMask) != SHEncodingTypeStruct) {
        return false;
    }
    
    static NSSet *structTypes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableSet *set = [NSMutableSet set];
        // 32 bit
        [set addObject:@"{CGSize=ff}"];
        [set addObject:@"{CGPoint=ff}"];
        [set addObject:@"{CGRect={CGPoint=ff}{CGSize=ff}}"];
        [set addObject:@"{CGAffineTransform=ffffff}"];
        [set addObject:@"{UIEdgeInsets=ffff}"];
        [set addObject:@"{UIOffset=ff}"];
        // 64 bit
        [set addObject:@"{CGSize=dd}"];
        [set addObject:@"{CGPoint=dd}"];
        [set addObject:@"{CGRect={CGPoint=dd}{CGSize=dd}}"];
        [set addObject:@"{CGAffineTransform=dddddd}"];
        [set addObject:@"{UIEdgeInsets=dddd}"];
        [set addObject:@"{UIOffset=dd}"];
        structTypes = set.copy;
    });
    
    if ([structTypes containsObject:self.typeEncoding]) {
        return true;
    }
    return false;
}

- (SHEncodingNSType)nsEncodingType {
    if ((self.type & SHEncodingTypeMask) != SHEncodingTypeObject) {
        return SHEncodingTypeNSUnknown;
    }
    return SHEncodingGetNSType(self.class);
}

@end
