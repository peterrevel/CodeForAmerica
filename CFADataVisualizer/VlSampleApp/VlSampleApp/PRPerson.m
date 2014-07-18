//
//  PRPerson.m
//  VlSampleApp
//
//  Created by Peter Reveles on 7/14/14.
//  Copyright (c) 2014 Peter Reveles. All rights reserved.
//

#import "PRPerson.h"

@implementation PRPerson

- (instancetype)initWithName:(NSString *)name title:(NSString *)title andPhoto:(UIImage *)photo{
    self = [super init];
    if (self) {
        // setup
        _name = name;
        _title = title;
        //_photo = photo;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@: %@", self.name, self.title];
}

@end
