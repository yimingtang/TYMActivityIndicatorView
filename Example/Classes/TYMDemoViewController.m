//
//  TYMDemoViewController.m
//  Example
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
        _systemActivityIndicatorView.hidesWhenStopped = NO;
    }
    return _systemActivityIndicatorView;
}


- (TYMActivityIndicatorView *)smallActivityIndicatorView {
    if (!_smallActivityIndicatorView) {
        _smallActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleSmall];
    }
    return _smallActivityIndicatorView;
}


- (TYMActivityIndicatorView *)normalActivityIndicatorView {
    if (!_normalActivityIndicatorView) {
        _normalActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleNormal];
    }
    return _normalActivityIndicatorView;
}


- (TYMActivityIndicatorView *)largeActivityIndicatorView {
    if (!_largeActivityIndicatorView) {
        _largeActivityIndicatorView = [[TYMActivityIndicatorView alloc] initWithActivityIndicatorStyle:TYMActivityIndicatorViewStyleLarge];
    }
    return _largeActivityIndicatorView;
}


- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"Animate" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


- (UISwitch *)directionSwitch {
    if (!_directionSwitch) {
        _directionSwitch = [[UISwitch alloc] init];
        [_directionSwitch addTarget:self action:@selector(directionChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _directionSwitch;
}


- (UISlider *)progressSlider {
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressSlider;
}


- (UISlider *)durationSlider {
    if (!_durationSlider) {
        _durationSlider = [[UISlider alloc] init];
        _durationSlider.minimumValue = 0.5f;
        _durationSlider.maximumValue = 5.0;
        [_durationSlider addTarget:self action:@selector(durationChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _durationSlider;
}


- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont systemFontOfSize:12.0];
        _progressLabel.text = @"Progress: 0.00";
    }
    return _progressLabel;
}


- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = [UIFont systemFontOfSize:12.0];
        _durationLabel.text = @"Duration: 1.00";
    }
    return _durationLabel;
}


- (UILabel *)directionLabel {
    if (!_directionLabel) {
        _directionLabel = [[UILabel alloc] init];
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
    
    
    CGSize size = self.view.bounds.size;
    self.systemActivityIndicatorView.frame = CGRectMake(40.0, 40.0, 20.0, 20.0);
    self.smallActivityIndicatorView.frame = CGRectMake(120.0, 40.0, 36.0, 36.0);
    self.normalActivityIndicatorView.frame = CGRectMake(size.width - 40.0 - 80.0, 40.0, 80.0, 80.0);
    self.largeActivityIndicatorView.frame = CGRectMake(roundf((size.width - 150.0) / 2), 160.0, 150.0, 150.0);
    self.durationLabel.frame = CGRectMake(20.0, 330.0, 100.0, 20.0);
    self.durationSlider.frame = CGRectMake(120.0, 330.0, size.width - 100.0 - 20.0 * 3, 20.0);
    self.progressLabel.frame = CGRectMake(20.0, 370.0, 100.0, 20.0);
    self.progressSlider.frame = CGRectMake(120.0, 370.0, size.width - 100.0 - 20.0 * 3, 20.0);
    self.directionLabel.frame = CGRectMake(20.0, 410.0, 100.0, 30.0);
    self.directionSwitch.frame = CGRectMake(120.0, 410.0, 100.0, 30.0);
    self.button.frame = CGRectMake(200.0, 410.0, 100.0, 30.0);
    
    self.directionSwitch.on = YES;
    self.durationSlider.value = 1.0;
}


#pragma mark - Private Methods

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
