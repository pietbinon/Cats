//
//  CatsCollectionViewCell.m
//  Cats
//
//  Created by Pierre Binon on 2017-01-25.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import "CatsCollectionViewCell.h"



@interface CatsCollectionViewCell() {

}

@property (nonatomic, strong) NetworkManager *networkManager;

@end




@implementation CatsCollectionViewCell

- (void) setPhoto: (Photo *)photo {
    
    _photo = photo;
    self.photoLabel.text = self.photo.photoTitle;

    self.networkManager = [[NetworkManager alloc] init];
    
    [self.networkManager downloadImagesFromURL: self.photo.photoURL completion: ^(UIImage *image) {
        self.catImageView.image = image;
    }];
}

@end
