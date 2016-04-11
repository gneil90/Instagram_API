//
//  SWUserFeed.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWUserFeedResponse.h"

@implementation SWUserFeedResponse


- (void)setData:(NSArray<Optional> *)data {
	if ([data isEqual:_data]) {
		return;
	}
	
	NSMutableArray * images = [NSMutableArray array];
	
	for (NSDictionary * userInfo in data) {
		SWMediaResponse * media = [[SWMediaResponse alloc] initWithDictionary:userInfo error:nil];
		if (media) {
			[images addObject:media];
		}
	}
	
	_data = images;
}


@end
