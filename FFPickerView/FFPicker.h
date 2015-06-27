//
//  FFPicker.h
//  FFPickerView
//
//  Created by Felix Ayala on 6/18/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFPickerOption.h"
#import "FFPickerTableViewController.h"

@class FFPicker;

@protocol FFPickerDelegate <NSObject>

@required
- (void)pickerView:(FFPicker *)pickerView didSelectOption:(id)option;

@optional

@end

@interface FFPicker : NSObject

@property (nonatomic, assign) id <FFPickerDelegate> delegate;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) id selectedOption;

- (instancetype)initWithOptions:(NSArray *)options;
- (void)show;
- (void)showWithSegueIdentifier:(NSString *)storyboardID;

@end
