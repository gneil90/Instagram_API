//
//  SWMedia.m
//  swift_inst
//
//  Created by Galiaskarov Neil on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWMediaResponse.h"

@implementation SWMediaResponse

- (BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[SWMediaResponse class]]) {
		return NO;
	}
	
	SWMediaResponse * media = (SWMediaResponse *)object;
	return [media.id isEqual:self.id];
}

@end
