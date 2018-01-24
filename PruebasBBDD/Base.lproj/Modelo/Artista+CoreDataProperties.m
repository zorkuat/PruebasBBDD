//
//  Artista+CoreDataProperties.m
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Artista+CoreDataProperties.h"

@implementation Artista (CoreDataProperties)

+ (NSFetchRequest<Artista *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Artista"];
}

@dynamic nombre;
@dynamic fechaNacimiento;
@dynamic nacionalidad;
@dynamic publicaciones;

@end
