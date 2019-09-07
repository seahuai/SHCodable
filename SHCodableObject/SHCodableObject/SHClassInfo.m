//
//  SHClassInfo.m
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHClassInfo.h"

@interface SHClassInfo ()
@property (nonatomic, assign) Class cls;
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
    _cls = class;
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
    
    unsigned int methodsCount = 0;
    Method *methods = class_copyMethodList(self.cls, &methodsCount);
    for (int i = 0; i < methodsCount; ++i) {
        Method method = methods[i];
        SHMethodInfo *methodInfo = [[SHMethodInfo alloc] initWithMethod:method];
        methodInfos[methodInfo.name] = methodInfo;
    }
    
    _methodsInfo = methodInfos.copy;
}

- (void)updateIvarInfos {
    NSMutableDictionary <NSString *, SHIvarInfo *> *ivarInfos = [NSMutableDictionary dictionary];
    
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(self.cls, &ivarsCount);
    for (int i = 0; i < ivarsCount; ++i) {
        Ivar ivar = ivars[i];
        SHIvarInfo *ivarInfo = [[SHIvarInfo alloc] initWithIvar:ivar];
        ivarInfos[ivarInfo.name] = ivarInfo;
    }
    
    _ivarInfos = ivarInfos.copy;
}

- (void)updatePropertyInfos {
    NSMutableDictionary <NSString *, SHPropertyInfo *> *propertyInfos = [NSMutableDictionary dictionary];
    
    unsigned int propertysCount = 0;
    objc_property_t *propertys = class_copyPropertyList(self.cls, &propertysCount);
    for (int i = 0 ; i < propertysCount; ++i) {
        objc_property_t property = propertys[i];
        SHPropertyInfo *propertyInfo = [[SHPropertyInfo alloc] initWithProperty:property];
        propertyInfos[propertyInfo.name] = propertyInfo;
    }
    
    _propertyInfos = propertyInfos.copy;
}

@end
