//
//  SHMethodInfo.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHMethodInfo.h"

@interface SHMethodInfo ()
@property (nonatomic, assign) Method method;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SEL sel;
@property (nonatomic, assign) IMP imp;
@property (nonatomic, copy) NSString *typeEncoding;
@property (nonatomic, copy) NSString *returnTypeEncoding;
@property (nonatomic, copy) NSArray<NSString *> *argumentsTypeEncoding;
@end

@implementation SHMethodInfo

- (instancetype)initWithMethod:(Method)method {
    if (!method) { return nil; }
    if (self = [super init])
    {
        [self initializeInfoWithMethod:method];
    }
    return self;
}

// MARK: - Method
- (void)initializeInfoWithMethod:(Method)method {
    _method = method;
    
    _sel = method_getName(method);
    _imp = method_getImplementation(method);
    
    const char *name = sel_getName(_sel);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    
    const char *typeEncoding = method_getTypeEncoding(method);
    if (typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    
    const char *returnTypeEncoding = method_copyReturnType(method);
    if (returnTypeEncoding) {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnTypeEncoding];
    }
    
    _argumentsTypeEncoding = @[];
    unsigned int argumentsCount = method_getNumberOfArguments(method);
    if (argumentsCount > 0) {
        NSMutableArray <NSString *> *argumentsTypeEncoding = [NSMutableArray arrayWithCapacity:argumentsCount];
        for (int i = 0; i < argumentsCount; ++i) {
            char *argumentType = method_copyArgumentType(method, i);
            NSString *type = nil;
            if (argumentType) {
                type = [NSString stringWithUTF8String:argumentType];
            }
            [argumentsTypeEncoding addObject:type ?: @""];
        }
        _argumentsTypeEncoding = argumentsTypeEncoding.copy;
    }
}

@end
