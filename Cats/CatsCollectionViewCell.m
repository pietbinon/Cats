//
//  CatsCollectionViewCell.m
//  Cats
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "CatsCollectionViewCell.h"

@implementation CatsCollectionViewCell

- (void)setPhoto:(Photo *)photo {
    _photo = photo;
    
   [self downloadPhotos];
}

- (void)downloadPhotos {
    
    
    NSURL *url = self.photo.photoURL;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        UIImage *imageToBeDisplayed = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.catImageView.image = imageToBeDisplayed;
        }];
        
    }];
    
    [dataTask resume];
    
    
    self.photoLabel.text = self.photo.photoTitle;
}
@end
