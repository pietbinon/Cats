//
//  CatsCollectionViewCell.m
//  Cats
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "CatsCollectionViewCell.h"

@interface CatsCollectionViewCell() {

}

@property (nonatomic, strong) NetworkManager *networkManager;

@end

@implementation CatsCollectionViewCell

- (void)setPhoto:(Photo *)photo {
    _photo = photo;
    self.photoLabel.text = self.photo.photoTitle;

    self.networkManager = [[NetworkManager alloc]init];
    
   //[self downloadPhotos];
    
    [self.networkManager downloadImagesFromURL:self.photo.photoURL completion:^(UIImage *image) {
        self.catImageView.image = image;
        
        
    }];

}

@end
