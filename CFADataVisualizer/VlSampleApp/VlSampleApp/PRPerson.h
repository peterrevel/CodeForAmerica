//
//  PRPerson.h
//  VlSampleApp
//
//  Created by Peter Reveles on 7/14/14.
//  Copyright (c) 2014 Peter Reveles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRPerson : NSObject

- (instancetype)initWithName:(NSString *)name title:(NSString *)title andPhoto:(UIImage *)photo;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) UIImage *photo;
@end
