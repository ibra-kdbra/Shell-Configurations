#version 3.5;

#include "colors.inc"
#include "shapes.inc"

#declare CD = 130;
#declare MX = 144;
#declare MY = 86;

global_settings { assumed_gamma 2.0 }

camera {
  location <1.3 * MX, MY, -CD>
  look_at <MX, MY, 0>
}

light_source {
  <0, 0, -CD>
  color rgb 0.5
  parallel
  point_at <0, 0, 0>
}

light_source {
  <0, MY, -CD>
  color rgb 0.3
}

light_source {
  <2 * MX, MY, -CD>
  color rgb 0.3
}

light_source {
  <MX, 2 * MY, -CD>
  color rgb 0.4
}

background {
  color rgb 0.9
}

#declare vfplot_arrow_texture =
  texture {
    pigment {
      image_map {png "scalar.png" once}
      scale <288, 173, 1>
    }
    finish {
      phong 0.5
    }
  };

#declare vfplot_ellipse_texture =
  texture {
    pigment {
      color Green
      transmit 0.8
    }
    finish {
      phong 0.5
    }
  };

#declare vfplot_network_texture =
  texture {
    pigment {
      color Red
      transmit 0.8
    }
    finish {
      phong 0.5
    }
  };

#include "vfplot.inc"

object {
  intersection {
    Round_Cone_Merge(<85, 85, -10>, 35, <85, 85, 10>, 35, 1)
    plane { x, 85 }
  }
  pigment { color rgb 0.8 transmit 0.45 }
  finish {
    phong 0.5
  }
}
