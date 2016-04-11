//
//  SWDataRequest.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNIRest.h"
#import "SWSearchResponse.h"
#import "SWUserResponse.h"
#import "SWUserFeedResponse.h"
#import "SWMediaResponse.h"
#import "SWCommentResponse.h"
#import "SWCommentsResponse.h"
#import "SWPaginationResponse.h"

@interface SWDataRequest : NSObject

/*!
 * @abstract Call this method to get INSTAGRAM username's user_id;
 * @param username Instagram username
 * @param success A block object to be executed when the request ends successfully. This block has SWUserResponse return value and which is the first user from search data field.
 * @param failure A block object to be executed when the request fails. This block has NSError return value.
 */

+ (void)searchUsername:(NSString *)username
							 success:(void (^)(id responseObject))success
							 failure:(void (^)(NSError* error))failure;


/*!
 * @abstract Call this method to get INSTAGRAM user_id's feed;;
 * @param user_id Instagram user id
 * @param success A block object to be executed when the request ends successfully. This block has SWUserFeedResponse return value.
 * @param failure A block object to be executed when the request fails. This block has NSError return value.
 */

+ (void)feedForUserId:(NSString *)user_id
							success:(void (^)(id responseObject))success
							failure:(void (^)(NSError* error))failure;

/*!
 * @abstract Call this method to get INSTAGRAM comments;
 * @param mediaID Instagram media item id
 * @param success A block object to be executed when the request ends successfully. This block has SWCommentsResponse return value.
 * @param failure A block object to be executed when the request fails. This block has NSError return value.
 */
+ (void)feedCommentsForMediaID:(NSString *)mediaID
											 success:(void (^)(id responseObject))success
											 failure:(void (^)(NSError* error))failure;

/*!
 * @abstract Call this method to handle INSTAGRAM pagination;
 * @param next_url Instagram next page absolute url path
 * @param success A block object to be executed when the request ends successfully. This block has SWPaginationResponse return value.
 * @param failure A block object to be executed when the request fails. This block has NSError return value.
 */
+ (void)loadFeedNextPage:(NSString *)next_url
								 success:(void (^)(id responseObject))success
								 failure:(void (^)(NSError* error))failure;

@end
