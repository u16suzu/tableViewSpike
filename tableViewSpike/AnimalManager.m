//
//  Animal.m
//  tableViewSpike
//
//  Created by u16suzu on 2013/09/16.
//  Copyright (c) 2013年 u16suzu. All rights reserved.
//

#import "AnimalManager.h"

@implementation AnimalManager

+ (AnimalManager *)sharedManager{
    static AnimalManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = AnimalManager.new;
    });
    return sharedManager;
}

@end
