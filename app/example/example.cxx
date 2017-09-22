#include <iostream>
#include <vector>

// LArCV
#include "DataFormat/IOManager.h"
#include "DataFormat/ImageMeta.h"
#include "DataFormat/Image2D.h"
#include "DataFormat/EventImage2D.h"


int main(int nargs, char** argv ) {

  std::cout << "Example program" << std::endl;

  larcv::IOManager io( larcv::IOManager::kWRITE );
  io.set_out_file("out_example.root");
  io.initialize();

  int nevents = 5;

  for (int iev=0; iev<nevents; iev++) {
    // for each event:

    // get the image event container
    larcv::EventImage2D* ev_img_container = (larcv::EventImage2D*)io.get_data( larcv::kProductImage2D, "example" );

    // define an image
    // first, we define the meta
    larcv::ImageMeta meta( 100, 100, 100, 100, 0, 100, 0 ); // (width, height, row_count, col_count, origin_x, origin_y, planeid)
    // now we make an image object
    larcv::Image2D img( meta );
    // initialize it to all zero
    img.paint(0.0);

    // we do something... in this example, we draw a circle with radius 20 and origin in the middle (50,50)

    for (int irad=0; irad<1000; irad++) {
      float phi = (2*3.141519/1000.0)*float(irad);
      float x = cos(phi)*20.0+50;
      float y = sin(phi)*20.0+50;

      // convert coordinate to row,col
      int row = meta.row( y );
      int col = meta.col( x );

      img.set_pixel( row, col, 10.0 );
      
    }// end of circle loop

    // done with image
    // store it in the event container
    ev_img_container->Emplace( std::move(img) ); // we use the move operator to avoid a copy

    // set the event id for this event
    io.set_id( 0, 0, iev); // (run, subrun, event)

    // send the event data to disk
    io.save_entry();
    
  }

  // finalize output
  io.finalize();

  return 0;
}
