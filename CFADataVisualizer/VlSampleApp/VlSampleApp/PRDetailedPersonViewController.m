//
//  PRDetailedPersonViewController.m
//  VlSampleApp
//
//  Created by Peter Reveles on 7/14/14.
//  Copyright (c) 2014 Peter Reveles. All rights reserved.
//

#import "PRDetailedPersonViewController.h"

@interface PRDetailedPersonViewController ()
@property (nonatomic, strong) UIImage *personsPhoto;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation PRDetailedPersonViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)setupViews{
#warning TODO(Peter) Setup Views
    
    // setup views
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0f, 75.0f)];
    photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    photoImageView.clipsToBounds = YES;
    [self.view addSubview:photoImageView];
    _photoImageView = photoImageView;
    
    [self.view addConstraint:
     [NSLayoutConstraint
      constraintWithItem:photoImageView attribute:NSLayoutAttributeCenterX
      relatedBy:NSLayoutRelationEqual
      toItem:self.view attribute:NSLayoutAttributeCenterX
      multiplier:1.0f constant:0.0f]];
    
    [self.view addConstraint:
     [NSLayoutConstraint
      constraintWithItem:photoImageView attribute:NSLayoutAttributeCenterY
      relatedBy:NSLayoutRelationEqual
      toItem:self.view attribute:NSLayoutAttributeCenterY
      multiplier:1.0f constant:0.0f]];
    
    // add person title and name
}

#pragma mark - Accessor Methods

- (void)setPersonsPhoto:(UIImage *)personsPhoto{
    _personsPhoto = personsPhoto;
    // display it onto screen
    self.photoImageView.image = _personsPhoto;
}

#pragma mark - Photo Handler

- (void)downloadPhoto{
    self.personsPhoto = nil;
    if (self.personsPhotoUrl) {
        [self.activityIndicator startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.personsPhotoUrl];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.personsPhotoUrl]) {
                                                                    //UIImage *photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        //self.personsPhoto = photo;
                                                                        //[self.activityIndicator stopAnimating];
                                                                        NSLog(@"%@", [NSData dataWithContentsOfURL:localFile]);
                                                                    });
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}

- (void)setPersonsPhotoUrl:(NSURL *)personsPhotoUrl{
    _personsPhotoUrl = personsPhotoUrl;
    [self downloadPhoto];
}

@end
