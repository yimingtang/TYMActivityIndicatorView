//
//  TYMActivityIndicatorView.m
//  Example
//
//  Created by Yiming Tang on 14-2-9.
//  Copyright (c) 2014 Yiming Tang. All rights reserved.
//

#import "TYMActivityIndicatorView.h"

@interface TYMActivityIndicatorView ()

@property (nonatomic, assign) BOOL animating;
@property (nonatomic, strong) UIImageView *indicatorImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation TYMActivityIndicatorView

#pragma mark - Accessors

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _backgroundImageView;
}


- (UIImageView *)indicatorImageView
{
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _indicatorImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _indicatorImageView;
}


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    self.backgroundImageView.image = _backgroundImage;
}


- (void)setIndicatorImage:(UIImage *)indicatorImage
{
    _indicatorImage = indicatorImage;
    self.indicatorImageView.image = _indicatorImage;
}


- (BOOL)isAnimating
{
    return self.animating;
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style
{
    CGRect rect;
    NSString *backgroundImageName;
    NSString *indicatorImageName;
    
    switch (style) {
        case TYMActivityIndicatorViewStyleNormal:
            rect = CGRectMake(0.0f, 0.0f, 37.0f, 37.0f);
            backgroundImageName = @"TYMActivityIndicatorView.bundle/background";
            indicatorImageName = @"TYMActivityIndicatorView.bundle/spinner";
            break;
        case TYMActivityIndicatorViewStyleLarge:
            rect = CGRectMake(0.0f, 0.0f, 157.0f, 157.0f);
            backgroundImageName = @"TYMActivityIndicatorView.bundle/background-large";
            indicatorImageName = @"TYMActivityIndicatorView.bundle/spinner-large";
            break;
        default:
            rect = CGRectMake(0.0f, 0.0f, 37.0f, 37.0f);
            backgroundImageName = @"TYMActivityIndicatorView.bundle/background";
            indicatorImageName = @"TYMActivityIndicatorView.bundle/spinner";
            break;
    }
    
    if ((self = [self initWithFrame:rect])) {
        self.backgroundImage = [UIImage imageNamed:backgroundImageName];
        self.indicatorImage = [UIImage imageNamed:indicatorImageName];
    }
    
    return self;
}


#pragma mark - Public

- (void)startAnimating
{
    if (self.animating) return;
    
    self.animating = YES;
    self.hidden = NO;
    [self _rotateImageViewFrom:0.0f to:M_PI*2 duration:self.fullRotationDuration repeatCount:HUGE_VALF];
}


- (void)stopAnimating
{
    if (!self.animating) return;
    
    self.animating = NO;
    [self.indicatorImageView.layer removeAllAnimations];
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
}


- (void)setProgress:(CGFloat)progress
{
    if (progress < 0.0f || progress > 1.0f) return;
    
    CGFloat fromValue = M_PI * 2 * _progress;
    CGFloat toValue = M_PI * 2 * progress;
    [self _rotateImageViewFrom:fromValue to:toValue duration:0.15f repeatCount:0];
    
    _progress = progress;
}


#pragma mark - Private

- (void)_initialize
{
    self.userInteractionEnabled = NO;
    
    self.animating = NO;
    self.hidesWhenStopped = YES;
    self.fullRotationDuration = 1.0;
    _progress = 0.0f;
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.indicatorImageView];
}


- (void)_rotateImageViewFrom:(CGFloat)fromValue to:(CGFloat)toValue duration:(CFTimeInterval)duration repeatCount:(CGFloat)repeatCount
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    rotationAnimation.toValue = [NSNumber numberWithFloat:toValue];
    rotationAnimation.duration = duration;
    rotationAnimation.RepeatCount = repeatCount;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.indicatorImageView.layer addAnimation:rotationAnimation forKey:@"rotation"];
}

@end
