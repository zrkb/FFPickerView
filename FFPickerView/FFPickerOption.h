//
//  FFPickerOption.h
//  FFPickerView
//
//  Created by Felix Ayala on 6/19/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFPickerOption : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, strong) NSString *displayText;

+ (instancetype)optionWithTitle:(NSString *)displayText value:(id)value;
- (instancetype)initWithOption:(NSString *)displayText value:(id)value;

@end