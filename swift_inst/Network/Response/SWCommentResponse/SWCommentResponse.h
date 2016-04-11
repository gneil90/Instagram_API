//
//  SWCommentResponse.h
//  swift_inst
//
//  Created by Galiaskarov Neil on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWDataRequest.h"
@class SWUserResponse;

@interface SWCommentResponse : SWResponseObject

@property (strong, nonatomic) NSString <Optional> * text;
@property (strong, nonatomic) SWUserResponse <Optional> * from;

@end
