//
//  TYMActivityIndicatorView.h
//  TYMActivityIndicatorView
//
//  Created by Yiming Tang on 2/9/14.
//  Copyright (c) 2014 - 2015 Yiming Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TYMActivityIndicatorViewStyle) {
    TYMActivityIndicatorViewStyleSmall,
    TYMActivityIndicatorViewStyleNormal,
    TYMActivityIndicatorViewStyleLarge,
};


/**
 TYMActivityIndicatorView is a simple activity indicator view that you can customize it's appearance with images.
 */
@interface TYMActivityIndicatorView : UIView

///-----------------
/// @name Properties
///-----------------

/**
 The activity indicator view style. Default is `TYMActivityIndicatorViewStyleNormal`.
*/
@property (nonatomic) TYMActivityIndicatorViewStyle activityIndicatorViewStyle;

/**
 It determines whether the receiver will be hidden when the animation was stopped.
 Default is `NO`. It calls `-setHidden` when animating gets set to NO.
 */
@property (nonatomic) NSInteger hidesWhenStopped UI_APPEARANCE_SELECTOR;

/**
 Default value is `YES`.
 */
@property (nonatomic) NSInteger clockwise UI_APPEARANCE_SELECTOR;

/**
 The duration time it takes the indicator to finish a 360-degree rotation.
 */
@property (nonatomic) CGFloat fullRotationDuration UI_APPEARANCE_SELECTOR;

/**
 The minimum progress unit.
 
 The indicator will only be rotated when the delta value of the progress is larger than the unit value. The default value is `0.01f`.
 */
@property (nonatomic) CGFloat minProgressUnit UI_APPEARANCE_SELECTOR;

/**
 The overall progress of the indicator. The acceptable value is `0.0f` to `1.0f`. The default value is 0.
 
 @warning For performance issue, you'd better control your invoking frequency during a period of time.
 */
@property (nonatomic) CGFloat progress;

/**
 Set background images for different styles.
 
 @param backgroundImage The background image.
 @param style An indicator style.
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage forActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style UI_APPEARANCE_SELECTOR;

/**
 Get the background image object for specific style.
 
 @param style The indicator style.
 
 @return The background image for the style.
 */
- (UIImage *)backgroundImageForActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style UI_APPEARANCE_SELECTOR;

/**
 Set spinner images for different styles.
 
 @param spinnerImage The spinner image.
 @param style An indicator style.
 */
- (void)setSpinnerImage:(UIImage *)spinnerImage forActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style UI_APPEARANCE_SELECTOR;

/**
 Get the spinner image for a specific style.
 
 @param style The indicator style.
 
 @return The spinner image for the style.
 */
- (UIImage *)spinnerImageForActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style UI_APPEARANCE_SELECTOR;


///-------------------
/// @name Initializing
///-------------------

/**
 Initialize a indicator view with built-in sizes and resources according to the specific style.
 
 @param style The initial activity indicator style.
 */
- (instancetype)initWithActivityIndicatorStyle:(TYMActivityIndicatorViewStyle)style;


///-----------------------------
/// @name Controlling Animations
///-----------------------------

/**
 Start animating. 360-degree rotation. Repeated forever.
 */
- (void)startAnimating;

/**
 Stop animating.
 */
- (void)stopAnimating;

/**
 Whether the indicator is animating.
 */
- (BOOL)isAnimating;

@end
