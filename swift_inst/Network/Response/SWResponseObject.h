//
//  SWResponseObject.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "JSONModel.h"
@class SWPaginationResponse;

@interface SWMetaResponse : JSONModel

@property (strong, nonatomic) NSNumber * code;

@end

@interface SWResponseObject : JSONModel

@property (strong, nonatomic) SWMetaResponse <Optional> * meta;
@property (strong, nonatomic) SWPaginationResponse <Optional> * pagination;

- (BOOL)isSuccessful;

@end
