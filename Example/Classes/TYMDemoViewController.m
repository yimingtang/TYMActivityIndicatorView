//
//  TYMDemoViewController.m
//  TYMActivityIndicatorView
//
//  Created by Yiming Tang on 2/9/14.
//  Copyright (c) 2014 - 2015 Yiming Tang. All rights reserved.
//

#import "TYMDemoViewController.h"
#import <TYMActivityIndicatorView/TYMActivityIndicatorView.h>

@interface TYMDemoViewController ()

@property (nonatomic) UIActivityIndicatorView *systemActivityIndicatorView;
@property (nonatomic) TYMActivityIndicatorView *smallActivityIndicatorView;
@property (nonatomic) TYMActivityIndicatorView *normalActivityIndicatorView;
@property (nonatomic) TYMActivityIndicatorView *largeActivityIndicatorView;
@property (nonatomic) UISwitch *directionSwitch;
@property (nonatomic) UISlider *progressSlider;
@property (nonatomic) UISlider *durationSlider;
@property (nonatomic) UIButton *button;
@property (nonatomic) UILabel *progressLabel;
@property (nonatomic) UILabel *durationLabel;
@property (nonatomic) UILabel *directionLabel;

@end

@implementation TYMDemoViewController

#pragma mark - Accessors

@synthesize systemActivityIndicatorView = _systemActivityIndicatorView;
@synthesize smallActivityIndicatorView = _smallActivityIndicatorView;
@synthesize normalActivityIndicatorView = _normalActivityIndicatorView;
@synthesize largeActivityIndicatorView = _largeActivityIndicatorView;
@synthesize directionSwitch = _directionSwitch;
@synthesize progressSlider = _progressSlider;
@synthesize durationSlider = _durationSlider;
@synthesize button = _button;
@synthesize progressLabel = _progressLabel;
@synthesize durationLabel = _durationLabel;
@synthesize directionLabel = _directionLabel;

- (UIActivityIndicatorView *)systemActivityIndicatorView {
    if (!_systemActivityIndicatorView) {
        _systemActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_systemActivityIndicatorView stopAnimating];
        _systemActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _systemActivityIndicatorView.hidesWhenStopped = NO;
    }
    return _systemActivityIndicatorView;
}


- (TYMActivityIndicatorView *)smallActivityIndicatorView {
    if (!_smallActivityIndicatorView) {
        _smallActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleSmall];
        _smallActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _smallActivityIndicatorView;
}


- (TYMActivityIndicatorView *)normalActivityIndicatorView {
    if (!_normalActivityIndicatorView) {
        _normalActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
        _normalActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _normalActivityIndicatorView;
}


- (TYMActivityIndicatorView *)largeActivityIndicatorView {
    if (!_largeActivityIndicatorView) {
        _largeActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleLarge];
        _largeActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _largeActivityIndicatorView;
}


- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        [_button setTitle:@"Animate" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


- (UISwitch *)directionSwitch {
    if (!_directionSwitch) {
        _directionSwitch = [[UISwitch alloc] init];
        _directionSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        [_directionSwitch addTarget:self action:@selector(directionChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _directionSwitch;
}


- (UISlider *)progressSlider {
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        _progressSlider.translatesAutoresizingMaskIntoConstraints = NO;
        [_progressSlider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressSlider;
}


- (UISlider *)durationSlider {
    if (!_durationSlider) {
        _durationSlider = [[UISlider alloc] init];
        _durationSlider.minimumValue = 0.5f;
        _durationSlider.maximumValue = 5.0;
        _durationSlider.translatesAutoresizingMaskIntoConstraints = NO;
        [_durationSlider addTarget:self action:@selector(durationChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _durationSlider;
}


- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _progressLabel.font = [UIFont systemFontOfSize:12.0];
        _progressLabel.text = @"Progress: 0.00";
    }
    return _progressLabel;
}


- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _durationLabel.font = [UIFont systemFontOfSize:12.0];
        _durationLabel.text = @"Duration: 1.00";
    }
    return _durationLabel;
}


- (UILabel *)directionLabel {
    if (!_directionLabel) {
        _directionLabel = [[UILabel alloc] init];
        _directionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _directionLabel.font = [UIFont systemFontOfSize:12.0];
        _directionLabel.text = @"Clockwise";
    }
    return _directionLabel;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.systemActivityIndicatorView];
    [self.view addSubview:self.smallActivityIndicatorView];\
    [self.view addSubview:self.normalActivityIndicatorView];
    [self.view addSubview:self.largeActivityIndicatorView];
    [self.view addSubview:self.durationLabel];
    [self.view addSubview:self.durationSlider];
    [self.view addSubview:self.progressLabel];
    [self.view addSubview:self.progressSlider];
    [self.view addSubview:self.directionLabel];
    [self.view addSubview:self.directionSwitch];
    [self.view addSubview:self.button];
    
    [self setupViewConstraints];
    
    self.directionSwitch.on = YES;
    self.durationSlider.value = 1.0;
}


#pragma mark - Private Methods

- (void)setupViewConstraints {
    NSDictionary *views = @{@"systemActivityIndicatorView": self.systemActivityIndicatorView,
                            @"smallActivityIndicatorView": self.smallActivityIndicatorView,
                            @"normalActivityIndicatorView": self.normalActivityIndicatorView,
                            @"largeActivityIndicatorView": self.largeActivityIndicatorView,
                            @"durationLabel": self.durationLabel,
                            @"durationSlider": self.durationSlider,
                            @"progressLabel": self.progressLabel,
                            @"progressSlider": self.progressSlider,
                            @"directionLabel": self.directionLabel,
                            @"directionSwitch": self.directionSwitch,
                            @"button": self.button
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[systemActivityIndicatorView]-(>=0)-[smallActivityIndicatorView]-(>=0)-[normalActivityIndicatorView]-20-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[normalActivityIndicatorView]-20-[largeActivityIndicatorView]-20-[durationSlider]-20-[progressSlider]-20-[directionSwitch]-30-[button]" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smallActivityIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.largeActivityIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[durationLabel]-[durationSlider]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[progressLabel]-[progressSlider]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[directionLabel]-[directionSwitch]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.directionSwitch attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.progressSlider attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
}


- (void)customAppearance {
    TYMActivityIndicatorView *appearance = [TYMActivityIndicatorView appearance];
    [appearance setClockwise:YES];
    [appearance setHidesWhenStopped:NO];
    [appearance setFullRotationDuration:1.0];
    [appearance setMinProgressUnit:0.01f];
}


#pragma mark - Actions

- (void)progressChanged:(UISlider *)slider {
    self.smallActivityIndicatorView.progress = slider.value;
    self.normalActivityIndicatorView.progress = slider.value;
    self.largeActivityIndicatorView.progress = slider.value;
    self.progressLabel.text = [NSString stringWithFormat:@"Progress: %.2f", slider.value];
}


- (void)durationChanged:(UISlider *)slider {
    self.smallActivityIndicatorView.fullRotationDuration = slider.value;
    self.normalActivityIndicatorView.fullRotationDuration = slider.value;
    self.largeActivityIndicatorView.fullRotationDuration = slider.value;
    self.durationLabel.text = [NSString stringWithFormat:@"Duration: %.2f", slider.value];
}


- (void)directionChanged:(UISwitch *)directionSwitch {
    self.smallActivityIndicatorView.clockwise = directionSwitch.on;
    self.normalActivityIndicatorView.clockwise = directionSwitch.on;
    self.largeActivityIndicatorView.clockwise = directionSwitch.on;
}


- (void)buttonClicked:(UIButton *)button {
    if (self.systemActivityIndicatorView.isAnimating) {
        [self.systemActivityIndicatorView stopAnimating];
        [self.smallActivityIndicatorView stopAnimating];
        [self.normalActivityIndicatorView stopAnimating];
        [self.largeActivityIndicatorView stopAnimating];
        [self.button setTitle:@"Animate!" forState:UIControlStateNormal];
        self.progressSlider.enabled = YES;
        self.durationSlider.enabled = YES;
        self.directionSwitch.enabled = YES;
    } else {
        [self.systemActivityIndicatorView startAnimating];
        [self.smallActivityIndicatorView startAnimating];
        [self.normalActivityIndicatorView startAnimating];
        [self.largeActivityIndicatorView startAnimating];
        [self.button setTitle:@"Stop!" forState:UIControlStateNormal];
        self.progressSlider.enabled = NO;
        self.durationSlider.enabled = NO;
        self.directionSwitch.enabled = NO;
    }
    
    self.progressSlider.value = 0.0f;
}

@end
