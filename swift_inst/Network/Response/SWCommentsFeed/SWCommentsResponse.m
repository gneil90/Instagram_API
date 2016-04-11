//
//  SWCommentsResponse.m
//  swift_inst
//
//  Created by Galiaskarov Neil on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWCommentsResponse.h"
#import "SWCommentResponse.h"

@implementation SWCommentsResponse

- (void)setData:(NSArray<Optional> *)data {
	if ([data isEqual:_data]) {
		return;
	}
	
	NSMutableArray * comments = [NSMutableArray array];
	for (NSDictionary * userInfo in data) {
		SWCommentResponse * media = [[SWCommentResponse alloc] initWithDictionary:userInfo error:nil];

		if (media) {
			[comments addObject:media];
		}
	}
	
	_data = comments;
}

@end
