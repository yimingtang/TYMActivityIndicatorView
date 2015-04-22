//
//  TYMActivityIndicatorView.m
//  TYMActivityIndicatorView
//
//  Created by Yiming Tang on 2/9/14.
//  Copyright (c) 2014 - 2015 Yiming Tang. All rights reserved.
//

#import "TYMActivityIndicatorView.h"

@interface TYMActivityIndicatorView ()

@property (nonatomic) BOOL animating;
@property (nonatomic) UIImageView *spinnerImageView;
@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) NSMutableDictionary *backgroundImageStorage;
@property (nonatomic) NSMutableDictionary *spinnerImageStorage;

@end

@implementation TYMActivityIndicatorView

#pragma mark - Accessors

@synthesize activityIndicatorViewStyle = _activityIndicatorViewStyle;
@synthesize animating = _animating;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize backgroundImageStorage = _backgroundImageStorage;
@synthesize spinnerImageView = _spinnerImageView;
@synthesize spinnerImageStorage = _spinnerImageStorage;
@synthesize clockwise = _clockwise;
@synthesize hidesWhenStopped = _hidesWhenStopped;
@synthesize fullRotationDuration = _fullRotationDuration;
@synthesize minProgressUnit = _minProgressUnit;
@synthesize progress = _progress;

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backgroundImageView;
}


- (UIImageView *)spinnerImageView {
    if (!_spinnerImageView) {
        _spinnerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _spinnerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _spinnerImageView;
}


- (NSMutableDictionary *)backgroundImageStorage {
    if (!_backgroundImageStorage) {
        _backgroundImageStorage = [NSMutableDictionary dictionary];
    }
    return _backgroundImageStorage;
}


- (NSMutableDictionary *)spinnerImageStorage {
    if (!_spinnerImageStorage) {
        _spinnerImageStorage = [NSMutableDictionary dictionary];
    }
    return _spinnerImageStorage;
}


- (void)setBackgroundImage:(UIImage *)backgroundImage forActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style {
    [self.backgroundImageStorage setObject:backgroundImage forKey:@(style)];
}


- (UIImage *)backgroundImageForActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style {
    UIImage *backgroundImage = [self.backgroundImageStorage objectForKey:@(style)];
    if (!backgroundImage) {
        backgroundImage = [[[self class] appearance] backgroundImageForActivityIndicatorStyle:style];
    }
    return backgroundImage;
}


- (void)setSpinnerImage:(UIImage *)spinnerImage forActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style {
    [self.spinnerImageStorage setObject:spinnerImage forKey:@(style)];
}


- (UIImage *)spinnerImageForActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style {
    UIImage *spinnerImage =  [self.spinnerImageStorage objectForKey:@(style)];
    if (!spinnerImage) {
        spinnerImage = [[[self class] appearance] spinnerImageForActivityIndicatorStyle:style];
    }
    return spinnerImage;
}


- (void)setActivityIndicatorViewStyle:(TYMActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    self.backgroundImageView.image = [self backgroundImageForActivityIndicatorStyle:activityIndicatorViewStyle];
    self.spinnerImageView.image = [self spinnerImageForActivityIndicatorStyle:activityIndicatorViewStyle];
}


- (BOOL)isAnimating {
    return self.animating;
}


#pragma mark - Class Methods

+ (void)initialize {
    if (self == [TYMActivityIndicatorView class]) {
        TYMActivityIndicatorView *appearance = [TYMActivityIndicatorView appearance];
        [appearance setClockwise:YES];
        [appearance setHidesWhenStopped:NO];
        [appearance setFullRotationDuration:1.0];
        [appearance setMinProgressUnit:0.01f];
        [appearance setBackgroundImage:[UIImage imageNamed:@"TYMActivityIndicatorView.bundle/background-normal"] forActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
        [appearance setSpinnerImage:[UIImage imageNamed:@"TYMActivityIndicatorView.bundle/spinner-normal"] forActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
        [appearance setBackgroundImage:[UIImage imageNamed:@"TYMActivityIndicatorView.bundle/background-small"] forActivityIndicatorStyle:TYMActivityIndicatorViewStyleSmall];
        [appearance setSpinnerImage:[UIImage imageNamed:@"TYMActivityIndicatorView.bundle/spinner-small"] forActivityIndicatorStyle:TYMActivityIndicatorViewStyleSmall];
        [appearance setBackgroundImage:[UIImage imageNamed:@"TYMActivityIndicatorView.bundle/background-large"] forActivityIndicatorStyle:TYMActivityIndicatorViewStyleLarge];
        [appearance setSpinnerImage:[UIImage imageNamed:@"TYMActivityIndicatorView.bundle/spinner-large"] forActivityIndicatorStyle:TYMActivityIndicatorViewStyleLarge];
    }
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self initialize];
    }
    return self;
}


- (id)initWithActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style {
    if ((self = [self initWithFrame:CGRectZero])) {
        self.activityIndicatorViewStyle = style;
    }
    return self;
}


- (CGSize)intrinsicContentSize {
    return [self sizeThatFits:CGSizeZero];
}


- (CGSize)sizeThatFits:(CGSize)size {
    CGSize backgroundImageSize = self.backgroundImageView.image.size;
    CGSize indicatorImageSize = self.spinnerImageView.image.size;
    
    return CGSizeMake(fmaxf(backgroundImageSize.width, indicatorImageSize.width), fmaxf(backgroundImageSize.height, indicatorImageSize.height));
}


#pragma mark - Public

- (void)startAnimating {
    if (self.animating) return;
    
    self.animating = YES;
    self.hidden = NO;
    CGFloat toValue = self.clockwise ? M_PI * 2 : -M_PI * 2;
    
    [self rotateView:self.spinnerImageView from:0.0 to:toValue duration:self.fullRotationDuration repeatCount:HUGE_VALF forKey:@"rotation" removeAnimationOnCompletion:NO];
}


- (void)stopAnimating {
    if (!self.animating) return;
    
    self.animating = NO;
    [self.spinnerImageView.layer removeAnimationForKey:@"rotation"];
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
}


- (void)setProgress:(CGFloat)progress {
    if (progress < 0.0 || progress > 1.0) return;
    if (fabsf(_progress - progress) < self.minProgressUnit) return;
    
    CGFloat fromValue = M_PI * 2 * _progress;
    CGFloat toValue = M_PI * 2 * progress;
    if (!self.clockwise) {
        fromValue = -fromValue;
        toValue = -toValue;
    }
    
    [self rotateView:self.spinnerImageView from:fromValue to:toValue duration:0.15f repeatCount:0 forKey:@"rotation" removeAnimationOnCompletion:NO];
    
    _progress = progress;
}


#pragma mark - Private

- (void)initialize {
    self.userInteractionEnabled = NO;
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.spinnerImageView];
    
    [self setupViewConstraints];
}


- (void)setupViewConstraints {
    NSDictionary *views = @{
        @"backgroundImageView": self.backgroundImageView,
        @"spinnerImageView": self.spinnerImageView
    };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundImageView]|" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundImageView]|" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[spinnerImageView]|" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[spinnerImageView]|" options:kNilOptions metrics:nil views:views]];
}


- (void)rotateView:(UIView *)view from:(CGFloat)fromValue to:(CGFloat)toValue duration:(CGFloat)duration repeatCount:(CGFloat)repeatCount forKey:(NSString *)key removeAnimationOnCompletion:(BOOL)removeOnCompletion {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation.z";
    rotationAnimation.fromValue = @(fromValue);
    rotationAnimation.toValue = @(toValue);
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = repeatCount;
    rotationAnimation.removedOnCompletion = removeOnCompletion;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:rotationAnimation forKey:key];
}

@end
