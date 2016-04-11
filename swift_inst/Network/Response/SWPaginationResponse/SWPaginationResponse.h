//
//  SWPaginationResponse.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"

@interface SWPaginationResponse : SWResponseObject

@property (strong, nonatomic) NSString * next_url;
@property (strong, nonatomic) NSString * next_max_id;

- (BOOL)isEqual:(id)object;

@end
