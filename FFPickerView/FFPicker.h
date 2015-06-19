//
//  FFPicker.h
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFPickerViewController.h"
#import "FFPickerOption.h"

@class FFPicker;

@protocol FFPickerDelegate <NSObject>

@required
- (void)didSelectOption:(id)option;

@optional

@end

@interface FFPicker : NSObject

@property (nonatomic, assign) id <FFPickerDelegate> delegate;
@property (nonatomic, strong) NSArray *options;

- (instancetype)initWithOptions:(NSArray *)options;
- (void)show;

@end
