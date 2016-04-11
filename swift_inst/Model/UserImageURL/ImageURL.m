//
//  ImageURL.m
//  
//
//  Created by Yan Saraev on 6/20/15.
//
//

#import "ImageURL.h"
#import "AppDelegate.h"

@implementation ImageURL

@dynamic url;
@dynamic id;

+ (void)saveImageURL:(NSString *)url
{
	dispatch_async(dispatch_get_main_queue(), ^{
		AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
		NSManagedObjectContext * ctx = appDelegate.managedObjectContext;
		
		// Specify criteria for filtering which objects to fetch
		
		NSArray * fetchedObjects = [ImageURL fetchImageURL:url context:ctx];
		if (fetchedObjects.count == 0) {
			ImageURL * new_url = [NSEntityDescription insertNewObjectForEntityForName:@"ImageURL" inManagedObjectContext:appDelegate.managedObjectContext];
			new_url.url = url;
			new_url.id = [@([[NSDate date] timeIntervalSince1970]) stringValue];
		}
	});
}

+ (NSArray *)fetchImageURL:(NSString *)url context:(NSManagedObjectContext *)ctx
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ImageURL"
																						inManagedObjectContext:ctx];
	[fetchRequest setEntity:entity];
	
	if (url) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", url];
		[fetchRequest setPredicate:predicate];
	}
	// Specify how the fetched objects should be sorted
	
	NSError *error = nil;
	return [ctx executeFetchRequest:fetchRequest error:&error];
}

+ (NSArray *)pickURLs {
	AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	NSManagedObjectContext * ctx = appDelegate.managedObjectContext;

	NSMutableArray * objects = [[ImageURL fetchImageURL:nil context:ctx] mutableCopy];
	
	return objects == nil ? [NSMutableArray array] : objects;
}

@end
