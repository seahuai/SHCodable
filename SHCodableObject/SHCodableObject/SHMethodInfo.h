//
//  SHMethodInfo.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHMethodInfo : NSObject

@property (nonatomic, readonly) Method method;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) SEL sel;

@property (nonatomic, readonly) IMP imp;

@property (nonatomic, readonly) NSString *typeEncoding;

@property (nonatomic, readonly) NSString *returnTypeEncoding;

@property (nonatomic, readonly) NSArray<NSString *> *argumentsTypeEncoding;

@end

NS_ASSUME_NONNULL_END
