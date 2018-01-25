//
//  ArtistasTableViewController.m
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "ArtistasTableViewController.h"
#import "Artista+CoreDataClass.h"
#import "BaseDatos.h"
#import "DiscosTableViewController.h"


@interface ArtistasTableViewController ()

@property (nonatomic) NSArray *artistas;

@end

@implementation ArtistasTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// La clase viene ya implementada con un método para recuperar una búsqueda
    NSFetchRequest *consultaArtistas = [Artista fetchRequest];
    
    /// Sort Descriptor: Array que especifica campos por los que vamos a ordenar el nombre de la consulta.
    consultaArtistas.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"nacionalidad"
                                                                       ascending:true],
                                         [NSSortDescriptor sortDescriptorWithKey:@"nombre"
                                         ascending:true]];
    /// Herramientas de paginación:
    /// Máximo de elementos que vamos a extraer
    /// consultaArtistas.fetchLimit = 10;
    /// Máximo por página
    /// consultaArtistas.fetchOffset = 10;
    
    /// HAY UN LENGUAJE ESPECÍFICO PARA LOS PREDICADOS: %K para claves. %@ para predicados
    /// UNOS CUANTOS OPERADORES DE BÚSQUEDA.
    consultaArtistas.predicate = [NSPredicate predicateWithFormat:@"nacionalidad = %@", @"Aleman"];
    
    NSManagedObjectContext *moc = [[BaseDatos instancia] moc];
    
    self.artistas = [moc executeFetchRequest:consultaArtistas error:nil];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.artistas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaArtista" forIndexPath:indexPath];
    
    /// se usa sintaxis de corchetes para la extracción de Artistas por que el array es genérico
    /// y devuelve objetos de tipo id
    cell.textLabel.text = [self.artistas[indexPath.row] nombre];
    cell.detailTextLabel.text = [self.artistas[indexPath.row] nacionalidad];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        Artista *artista = self.artistas[indexPath.row];
        [[[BaseDatos instancia] moc] deleteObject:artista];
        [[[BaseDatos instancia] moc] save:nil];
        [self refrescarTabla];
        
        // Delete the row from the data source
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:@"verDiscos"])
    {
        DiscosTableViewController *escenaDiscos = segue.destinationViewController;
        NSIndexPath *celdaSeleccionada = self.tableView.indexPathForSelectedRow;
        escenaDiscos.artista = self.artistas[celdaSeleccionada.row];
    }

}

- (IBAction)botonAnnadirPulsado:(id)sender {
    
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Nuevo Artista" message:@"introduce el nombre del artista" preferredStyle:UIAlertControllerStyleAlert];
    
    [alerta addTextFieldWithConfigurationHandler:nil];
    [alerta addTextFieldWithConfigurationHandler:nil];
    [alerta addAction:[UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /// Aquí va codigo, señores.
        
        Artista *nuevoArtista = [NSEntityDescription insertNewObjectForEntityForName:@"Artista" inManagedObjectContext:[[BaseDatos instancia] moc]];
        
        nuevoArtista.nombre = alerta.textFields.firstObject.text;
        nuevoArtista.nacionalidad = alerta.textFields.lastObject.text;
        [[[BaseDatos instancia] moc] save:nil];
        [self refrescarTabla];
    }]];
    
    [alerta addAction:[UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alerta animated:true completion:nil];
}

-(void)refrescarTabla
{
    NSFetchRequest *consultaArtistas = [Artista fetchRequest];
    
    NSManagedObjectContext *moc = [[BaseDatos instancia] moc];
    
    self.artistas = [moc executeFetchRequest:consultaArtistas error:nil];
    
    [self.tableView reloadData];
}

@end
