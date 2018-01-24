//
//  Artista+CoreDataProperties.h
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Artista+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Artista (CoreDataProperties)

+ (NSFetchRequest<Artista *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nombre;
@property (nullable, nonatomic, copy) NSDate *fechaNacimiento;
@property (nullable, nonatomic, copy) NSString *nacionalidad;
@property (nullable, nonatomic, retain) NSSet<Disco *> *publicaciones;

@end

@interface Artista (CoreDataGeneratedAccessors)

- (void)addPublicacionesObject:(Disco *)value;
- (void)removePublicacionesObject:(Disco *)value;
- (void)addPublicaciones:(NSSet<Disco *> *)values;
- (void)removePublicaciones:(NSSet<Disco *> *)values;

@end

NS_ASSUME_NONNULL_END
