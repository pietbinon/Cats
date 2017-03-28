//
//  Photo.m
//  Cats
//
//  Created by Pierre Binon on 2017-01-25.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import "Photo.h"



@implementation Photo

- (instancetype)initWithServer :(NSString *)server initWithFarm:(NSString *)farm initWithID:(NSString *)pID initWithSecret:(NSString *)secret initWithTitle:(NSString *)title initWithURL:(NSURL *)pURL {
    
    if (self = [super init]) {
        
        self.photoServer = server;
        self.photoFarm = farm;
        self.photoID = pID;
        self.photoSecret = secret;
        self.photoTitle = title;
        self.photoURL = pURL;
        
        NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", self.photoFarm, self.photoServer, self.photoID, self.photoSecret];
        
        self.photoURL = [NSURL URLWithString: photoURLString];
    }
    
    return self;
}

@end
