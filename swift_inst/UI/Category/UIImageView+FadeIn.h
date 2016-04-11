//
//  UIImageView+FadeIn.h
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FadeIn)

- (void)setAndFadeInInstagramImageWithURL:(NSURL *)url;
- (void)setAndFadeInInstagramImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder;

@end
