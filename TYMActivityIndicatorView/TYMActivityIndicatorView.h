//
//  TYMActivityIndicatorView.h
//  Example
//
//  Created by Yiming Tang on 14-2-9.
//  Copyright (c) 2014 Yiming Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TYMActivityIndicatorViewStyle) {
    TYMActivityIndicatorViewStyleLarge,
    TYMActivityIndicatorViewStyleNormal,
};

@interface TYMActivityIndicatorView : UIView

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *indicatorImage;
@property (nonatomic, assign) BOOL hidesWhenStopped;
@property (nonatomic, assign) CFTimeInterval fullRotationDuration;
@property (nonatomic, assign) CGFloat progress;

- (id)initWithActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style;
- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
