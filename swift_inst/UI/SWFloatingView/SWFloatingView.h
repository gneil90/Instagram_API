//
//  SWFloatingView.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline float random_val(float min, float max) {
	float low_bound = min;
	float high_bound = max;
	return (((float)arc4random()/0x100000000)*(high_bound - low_bound) + low_bound);
}

@interface UIView (anchorPoint)
- (void)setNewUserAnchorPoint:(CGPoint)anchorPoint;

@end

@interface SWFloatingView : UIImageView

@property (strong, nonatomic, setter = setUrl:) NSString * url;

@end
