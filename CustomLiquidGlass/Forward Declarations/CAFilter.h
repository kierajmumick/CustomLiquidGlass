// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

#ifndef CAFilter_h
#define CAFilter_h

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAFilter: NSObject
+(instancetype)filterWithType:(NSString *)arg0;
-(NSString *)name;
-(void)setName:(NSString *) name;
@end

extern NSString * const kCAFilterDisplacementMap;
extern NSString * const kCAFilterGlassBackground;

#endif /* CAFilter_h */
