//
//  SWImageResponse.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"

@interface SWImageResolution : SWResponseObject

@property (strong, nonatomic) NSString <Optional> * url;
@property (strong, nonatomic) NSNumber <Optional> * width;
@property (strong, nonatomic) NSNumber <Optional> * height;

@end

@interface SWImageResponse : SWResponseObject

@property (strong, nonatomic) SWImageResolution <Optional> * low_resolution;
@property (strong, nonatomic) SWImageResolution <Optional> * thumbnail;
@property (strong, nonatomic) SWImageResolution <Optional> * standard_resolution;

@end
