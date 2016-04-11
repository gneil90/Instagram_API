//
//  SWResponseObject.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"

@implementation SWMetaResponse


@end

@implementation SWResponseObject

- (BOOL)isSuccessful {
	return [self.meta.code intValue] >= 200 && [self.meta.code intValue] < 300;
}

@end
