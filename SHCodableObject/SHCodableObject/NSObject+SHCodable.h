//
//  NSObject+SHCodable.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/5.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SHCodable)

- (void)modelEncodeWithCoder:(NSCoder *)aCoder;

- (id)modelDecodeWithCoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
