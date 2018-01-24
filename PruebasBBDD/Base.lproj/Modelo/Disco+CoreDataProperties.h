//
//  Disco+CoreDataProperties.h
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Disco+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Disco (CoreDataProperties)

+ (NSFetchRequest<Disco *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *titulo;
@property (nonatomic) int16_t anno;
@property (nullable, nonatomic, copy) NSString *genero;
@property (nullable, nonatomic, retain) Artista *publicadoPor;

@end

NS_ASSUME_NONNULL_END
