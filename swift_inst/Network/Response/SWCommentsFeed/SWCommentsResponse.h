//
//  SWCommentsResponse.h
//  swift_inst
//
//  Created by Galiaskarov Neil on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWDataRequest.h"

@interface SWCommentsResponse : SWResponseObject

@property (strong, nonatomic, setter=setData:) NSArray <Optional> * data;

@end
