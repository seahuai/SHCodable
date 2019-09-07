//
//  SHIvarInfo.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHIvarInfo.h"

@implementation SHIvarInfo

- (instancetype)initWithIvar:(Ivar)ivar {
    if (!ivar) { return nil; }
    if (self = [super init])
    {
        _ivar = ivar;
        
        const char *ivarName = ivar_getName(ivar);
        if (ivarName) {
            _name = [NSString stringWithUTF8String:ivarName];
        }
        
        _offset = ivar_getOffset(ivar);
        
        const char *typeEncoding = ivar_getTypeEncoding(ivar);
        if (typeEncoding) {
            _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
            _type = SHEncodingGetType(typeEncoding);
        }
    }
    return self;
}

@end
