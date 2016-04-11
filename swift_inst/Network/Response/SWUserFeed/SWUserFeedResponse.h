//
//  SWUserFeed.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"
#import "SWMediaResponse.h"

@interface SWUserFeedResponse : SWResponseObject

@property (strong, nonatomic, setter=setData:) NSMutableArray <Optional> * data;


@end
