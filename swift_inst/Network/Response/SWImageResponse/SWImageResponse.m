//
//  SWImageResponse.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWImageResponse.h"
#import "ImageURL.h"

@implementation SWImageResolution


- (id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
	self = [super initWithDictionary:dict error:err];
	if (self) {
		[ImageURL saveImageURL:self.url];
	}
	
	return self;
}

@end

@implementation SWImageResponse

@end
