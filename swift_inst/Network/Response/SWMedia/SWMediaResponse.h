//
//  SWMedia.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"
#import "SWImageResponse.h"

@interface SWMediaResponse : SWResponseObject

@property (strong, nonatomic) NSString <Optional> * type;
@property (strong, nonatomic) SWImageResponse <Optional> * images;
@property (strong, nonatomic) NSString <Optional> * id;

- (BOOL)isEqual:(id)object;

@end
