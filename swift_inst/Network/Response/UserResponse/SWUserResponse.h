//
//  UserResponse.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWResponseObject.h"

@interface SWUserResponse : SWResponseObject

@property (strong, nonatomic) NSString <Optional> * username;
@property (strong, nonatomic) NSString <Optional> * profile_picture;
@property (strong, nonatomic) NSString <Optional> * id;

@end
