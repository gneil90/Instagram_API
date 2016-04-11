//
//  SWPaginationResponse.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWPaginationResponse.h"

@implementation SWPaginationResponse

- (BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[SWPaginationResponse class]]) {
		return NO;
	}
	
	SWPaginationResponse * pagination = (SWPaginationResponse *)object;
	return [pagination.next_url isEqual:self.next_url];
}


@end
