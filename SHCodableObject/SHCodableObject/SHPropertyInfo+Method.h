//
//  SHPropertyInfo+Method.h
//  SHCodableObject
//
//  Created by 张思槐 on 2019/9/11.
//  Copyright © 2019 张思槐. All rights reserved.
//

#import "SHPropertyInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHPropertyInfo (Method)

- (BOOL)isCNumber;

- (BOOL)isArchivedStruct;

- (SHEncodingNSType)nsEncodingType;

@end

NS_ASSUME_NONNULL_END
