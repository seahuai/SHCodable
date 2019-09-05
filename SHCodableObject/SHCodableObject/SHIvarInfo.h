//
//  SHIvarInfo.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SHEncodingType.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHIvarInfo : NSObject

@property (nonatomic, readonly) Ivar ivar;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) ptrdiff_t offset;

@property (nonatomic, readonly) NSString *typeEncoding;

@property (nonatomic, readonly) SHEncodingType type;

@end

NS_ASSUME_NONNULL_END
