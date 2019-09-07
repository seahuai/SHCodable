//
//  SHPropertyInfo.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SHEncodingType.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPropertyInfo : NSObject

@property (nonatomic, readonly) objc_property_t property;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) NSString *ivarName;

@property (nonatomic, readonly) NSString *typeEncoding;

@property (nonatomic, readonly) SHEncodingType type;

@property (nonatomic, readonly) SEL setter;

@property (nonatomic, readonly) SEL getter;

@property (nonatomic, nullable, readonly) Class cls;

@property (nonatomic, nullable, readonly) NSArray<NSString *> *protocols;

- (instancetype)initWithProperty:(objc_property_t)property;

@end

NS_ASSUME_NONNULL_END
