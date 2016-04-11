//
//  SWSearchResponse.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWSearchResponse.h"
#import "SWUserResponse.h"

@implementation SWSearchResponse

- (void)setData:(NSArray<Optional> *)data {
	if ([data isEqual:_data]) {
		return;
	}
	
	NSMutableArray * users = [NSMutableArray array];
	
	for (NSDictionary * userInfo in data) {
		SWUserResponse * user = [[SWUserResponse alloc] initWithDictionary:userInfo error:nil];
		if (user) {
			[users addObject:user];
		}
	}
	
	_data = users;
}

@end
