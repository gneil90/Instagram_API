//
//  SWSearchResponse.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"

@interface SWSearchResponse : SWResponseObject

@property (strong, nonatomic, setter=setData:) NSArray <Optional> * data;

@end
