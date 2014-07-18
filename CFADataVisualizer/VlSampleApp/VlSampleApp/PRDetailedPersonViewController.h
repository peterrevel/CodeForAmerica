//
//  PRDetailedPersonViewController.h
//  VlSampleApp
//
//  Created by Peter Reveles on 7/14/14.
//  Copyright (c) 2014 Peter Reveles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRPerson;

@interface PRDetailedPersonViewController : UIViewController
@property (nonatomic, strong) PRPerson *person;
@property (nonatomic, strong) NSURL *personsPhotoUrl;
@end
