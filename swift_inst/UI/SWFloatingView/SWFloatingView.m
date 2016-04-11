//
//  SWFloatingView.m
//  swift_inst
//
//  Created by Neil Galiaskarov on 6/20/15.
//  Copyright (c) 2015 nt. All rights reserved.
//

#import "SWFloatingView.h"
#import "UIImageView+FadeIn.h"

@implementation UIView (anchorPoint)

- (void)setNewUserAnchorPoint:(CGPoint)anchorPoint{
    CGPoint newPoint = CGPointMake(self.bounds.size.width * anchorPoint.x, self.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint position = self.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    self.layer.position = position;
    self.layer.anchorPoint = anchorPoint;
}

@end

@interface SWFloatingView ()

@property (assign, nonatomic) BOOL isFloating;

@end


@implementation SWFloatingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self awakeFromNib];
	}
	return self;
}

- (void)awakeFromNib {
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
	
	if (!self.isFloating) {
		[self runFloatAnimation];
		[self runScaleAnimation];
		self.isFloating = YES;
	}
}

#pragma mark- Custom setters/Accessors

- (void)setUrl:(NSString *)url {
	if ([url isEqual:_url]) {
		return;
	}
	
	NSURL * image_url = [NSURL URLWithString:url];
	[self setAndFadeInInstagramImageWithURL:image_url];
}

#pragma mark- Animations

- (void)runFloatAnimation {
	__weak typeof(self) weakSelf = self;
	
	self.backgroundColor = [UIColor clearColor];
	float random_value_duration = random_val(3.0, 6.0);

	[UIView animateWithDuration:random_value_duration animations:^{
		float random_value_x = random_val(-15, 15);
		float random_value_y = random_val(-15, 15);
		self.frame = ({
			CGRect frame = self.frame;
			frame.origin.x = MIN(MAX(frame.origin.x + random_value_x, 0), CGRectGetWidth(self.superview.bounds) - CGRectGetWidth(frame)); ;
			frame.origin.y = MIN(MAX(frame.origin.y + random_value_y, 0), CGRectGetHeight(self.superview.bounds) - CGRectGetHeight(self.frame));

			frame;
		});
		
	} completion:^(BOOL finished) {
		if (weakSelf) {
			[weakSelf runFloatAnimation];
		}
	}];
}

- (void)runScaleAnimation {
	float random_value_duration_scaleX = random_val(0.8, 1.5);

	CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
	//set the duration
	scaleX.duration = random_value_duration_scaleX;
	//it starts from scale factor 1, scales to 1.05 and back to 1
	scaleX.values = @[@1.0, @1.05, @1.0];
	//time percentage when the values above will be reached.
	//i.e. 1.05 will be reached just as half the duration has passed.
	scaleX.keyTimes = @[@0.0, @0.5, @1.0];
	//keep repeating
	scaleX.repeatCount = INFINITY;
	//play animation backwards on repeat (not really needed since it scales back to 1)
	scaleX.autoreverses = YES;
	//ease in/out animation for more natural look
	scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	//add the animation to the view's layer
	[self.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
	
	//create the height-scale animation just like the width one above
	//but slightly increased duration so they will not animate synchronously
	
	float random_value_duration_scaleY = random_val(1.2, 2.0);

	CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
	scaleY.duration = random_value_duration_scaleY;
	scaleY.values = @[@1.0, @1.05, @1.0];
	scaleY.keyTimes = @[@0.0, @0.5, @1.0];
	scaleY.repeatCount = INFINITY;
	scaleY.autoreverses = YES;
	scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[self.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
}

@end
