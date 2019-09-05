//
//  SHClassInfo.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHClassInfo.h"

@interface SHClassInfo ()
@property (nonatomic, assign) Class class;
@property (nonatomic, nullable, assign) Class superClass;
@property (nonatomic, nullable, assign) Class metaClass;
@property (nonatomic, assign) BOOL isMeta;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, nullable, strong) SHClassInfo *superClassInfo;
@property (nonatomic, copy) NSDictionary<NSString *, SHMethodInfo *> *methodsInfo;
@property (nonatomic, copy) NSDictionary<NSString *, SHIvarInfo *> *ivarInfos;
@property (nonatomic, copy) NSDictionary<NSString *, SHPropertyInfo *> *propertyInfos;
@end

@implementation SHClassInfo

- (instancetype)initWithClass:(Class)class {
    if (!class) { return nil; }
    if (self = [super init])
    {
        [self initializeClassInfo:class];
    }
    return self;
}

+ (instancetype)classInfoWithClass:(Class)class {
    return [[self alloc] initWithClass:class];
}

+ (instancetype)classInfoWithClassName:(NSString *)className {
    Class cls = NSClassFromString(className ?: @"");
    return [self classInfoWithClass:cls];
}

// MARK: - Method
- (void)initializeClassInfo:(Class)class {
    _class = class;
    _name = NSStringFromClass(class);
    
    _superClass = class_getSuperclass(class);
    _superClassInfo = [SHClassInfo classInfoWithClass:_superClass];
    
    _isMeta = class_isMetaClass(class);
    if (!_isMeta) {
        _metaClass = objc_getMetaClass(class_getName(class));
    }
    
    [self updateInfos];
}

- (void)updateInfos {
    [self updateMethodInfos];
    [self updateIvarInfos];
    [self updatePropertyInfos];
}

- (void)updateMethodInfos {
    NSMutableDictionary <NSString *, SHMethodInfo *> *methodInfos = [NSMutableDictionary dictionary];
    
    Class class = self.class;
    
    unsigned int methodsCount = 0;
    Method *methods = class_copyMethodList(class, &methodsCount);
    for (int i = 0; i < methodsCount; ++i) {
        Method method = methods[i];
        SHMethodInfo *methodInfo = [[SHMethodInfo alloc] initWithMethod:method];
        methodInfos[methodInfo.name] = methodInfo;
    }
    
    _methodsInfo = methodInfos.copy;
}

- (void)updateIvarInfos {
    
}

- (void)updatePropertyInfos {
    
}

@end
