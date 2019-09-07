//
//  SHClassInfo.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMethodInfo.h"
#import "SHIvarInfo.h"
#import "SHPropertyInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHClassInfo : NSObject

@property (nonatomic, readonly) Class cls;

@property (nonatomic, nullable, readonly) Class superClass;

@property (nonatomic, nullable, readonly) Class metaClass;

@property (nonatomic, readonly) BOOL isMeta;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, nullable, readonly) SHClassInfo *superClassInfo;

@property (nonatomic, readonly) NSDictionary<NSString *, SHMethodInfo *> *methodsInfo;

@property (nonatomic, readonly) NSDictionary<NSString *, SHIvarInfo *> *ivarInfos;

@property (nonatomic, readonly) NSDictionary<NSString *, SHPropertyInfo *> *propertyInfos;

+ (instancetype)classInfoWithClass:(Class)class;

+ (instancetype)classInfoWithClassName:(NSString *)className;

+ (instancetype)classInfoWithClass:(Class)class needUpdate:(BOOL)needUpdate;

@end

NS_ASSUME_NONNULL_END
