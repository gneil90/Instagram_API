//
//  ImageURL.h
//  
//
//  Created by Yan Saraev on 6/20/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageURL : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * id;

/*!
 *@abstract Saving fetched from Instagram user image URLs
 *@param url image url
 */
+ (void)saveImageURL:(NSString *)url;

/*!
 *@abstract Returns randomly picked N image urls, which were previously searched by user.
 *@param count number of images will be randomly picked
 */
+ (NSArray *)pickURLs;

@end
