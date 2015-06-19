//
//  FFPickerOption.m
//  FFPickerView
//
//  Created by Felix Ayala on 6/19/15.
//  Copyright (c) 2015 Pandorga. All rights reserved.
//

#import "FFPickerOption.h"

@implementation FFPickerOption

+ (instancetype)optionWithTitle:(NSString *)displayText value:(id)value {
	return [[self alloc] initWithOption:displayText value:value];
}

- (instancetype)initWithOption:(NSString *)displayText value:(id)value {
	
	self = [super init];
	if (self) {
		self.displayText = displayText;
		self.value = value;
	}
	return self;
}

@end
