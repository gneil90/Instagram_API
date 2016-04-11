//
//  SWDataRequest.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWDataRequest.h"
@import UIKit;

#define API_URL @"api.instagram.com"
#define API_PREFIX  @"v1"
#define API_SCHEMA  @"https"

#define BASE_API_URL ([NSString stringWithFormat:@"%@://%@/%@/",API_SCHEMA,API_URL,API_PREFIX])

#define INST_CLIENT_ID @"c31e109acc8c46bc8b50c16cdd97694b"

#define USER_SEARCH_URL @"users/search?q=%@&client_id=%@"
#define USER_FEED_URL @"users/%@/media/recent/?client_id=%@"
#define PHOTO_COMMENTS_URL @"media/%@/comments?client_id=%@"

@implementation SWDataRequest


+ (void)searchUsername:(NSString *)username
							 success:(void (^)(id responseObject))success
							 failure:(void (^)(NSError* error))failure
{
	NSString * urlFormat = [NSString stringWithFormat:@"%@%@", BASE_API_URL, USER_SEARCH_URL];
	NSString * url = [NSString stringWithFormat:urlFormat, username, INST_CLIENT_ID];
	[[UNIRest get:^(UNISimpleRequest * request) {
		[request setUrl:url];
	}] asJsonAsync:^(UNIHTTPJsonResponse * response, NSError * error) {
		if (error) {
			failure(error);
			return;
		}
		
		NSDictionary * info = [NSJSONSerialization JSONObjectWithData:response.rawBody
																													options:kNilOptions
																														error:nil];
		
		SWSearchResponse * searchResponse = [[SWSearchResponse alloc] initWithDictionary:info
																																							 error:nil];
		if ([searchResponse isSuccessful]) {
			success([searchResponse.data firstObject]);
		} else {
			NSError * error = [NSError errorWithDomain:@""
																						code:[searchResponse.meta.code integerValue]
																				userInfo:@{}];
			failure(error);
		}
	}];
}

+ (void)feedForUserId:(NSString *)user_id
							success:(void (^)(id responseObject))success
							failure:(void (^)(NSError* error))failure
{
	NSString * urlFormat = [NSString stringWithFormat:@"%@%@", BASE_API_URL, USER_FEED_URL];
	NSString * url = [NSString stringWithFormat:urlFormat, user_id, INST_CLIENT_ID];

	[[UNIRest get:^(UNISimpleRequest * request) {
		[request setUrl:url];
	}] asJsonAsync:^(UNIHTTPJsonResponse * response, NSError * error) {
		if (error) {
			failure(error);
			return;
		}

		NSDictionary * info = [NSJSONSerialization JSONObjectWithData:response.rawBody
																													options:kNilOptions
																														error:nil];
		
		SWUserFeedResponse * feed = [[SWUserFeedResponse alloc] initWithDictionary:info
																																				 error:nil];
		if ([feed isSuccessful]) {
			success(feed);
		} else {
			NSError * error = [NSError errorWithDomain:@""
																						code:[feed.meta.code integerValue]
																				userInfo:@{}];
			failure(error);
		}
	}];
}

+ (void)feedCommentsForMediaID:(NSString *)mediaID
											 success:(void (^)(id responseObject))success
											 failure:(void (^)(NSError* error))failure
{
	NSString * urlFormat = [NSString stringWithFormat:@"%@%@", BASE_API_URL, PHOTO_COMMENTS_URL];
	NSString * url = [NSString stringWithFormat:urlFormat, mediaID, INST_CLIENT_ID];
	[[UNIRest get:^(UNISimpleRequest * request) {
		[request setUrl:url];
	}] asJsonAsync:^(UNIHTTPJsonResponse * response, NSError * error) {
		if (error) {
			failure(error);
			return;
		}
		
		NSDictionary * info = [NSJSONSerialization JSONObjectWithData:response.rawBody
																													options:kNilOptions
																														error:nil];
		
		SWCommentsResponse * comments = [[SWCommentsResponse alloc] initWithDictionary:info
																																						 error:nil];
		if ([comments isSuccessful]) {
			success(comments);
		} else {
			NSError * error = [NSError errorWithDomain:@""
																						code:[comments.meta.code integerValue]
																				userInfo:@{}];
			failure(error);
		}
	}];
}

+ (void)loadFeedNextPage:(NSString *)next_url
								 success:(void (^)(id responseObject))success
								 failure:(void (^)(NSError* error))failure
{
	[[UNIRest get:^(UNISimpleRequest * request) {
		[request setUrl:next_url];
	}] asJsonAsync:^(UNIHTTPJsonResponse * response, NSError * error) {
		if (error) {
			failure(error);
			return;
		}
		
		NSDictionary * info = [NSJSONSerialization JSONObjectWithData:response.rawBody
																													options:kNilOptions
																														error:nil];
		
		SWUserFeedResponse * feed = [[SWUserFeedResponse alloc] initWithDictionary:info
																																						 error:nil];
		if ([feed isSuccessful]) {
			success(feed);
		} else {
			NSError * error = [NSError errorWithDomain:@""
																						code:[feed.meta.code integerValue]
																				userInfo:@{}];
			failure(error);
		}
	}];
}

@end
