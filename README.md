# CUDA Accelerated Ray Tracer

## Overview
The CUDA Accelerated Ray Tracer is a high-performance graphics rendering engine that leverages CUDA to accelerate the ray tracing process. This project features a variety of primitive shapes including spheres, cylinders, cones, planes, and triangles, making it highly versatile for scene composition.

## Features
- **Basic Illumination Model**: Simple yet powerful lighting with adjustable specular values.
- **Shape Variety**: Spheres, cylinders, cones, planes, and triangles are all supported.
- **Texture Support**: Checkerboard texturing available for all shapes.
- **Color Customization**: Full RGB spectrum support for object and scene coloring.
- **In Progress**: Mirror reflection support for enhanced realism.

## Tech Stack
- C/C++
- CUDA

## Installation and Usage
1. Clone the repository:
    ```
    git clone https://github.com/yourusername/CudaAcceleratedRayTracer.git
    ```
2. Navigate to the project directory:
    ```
    cd CudaAcceleratedRayTracer
    ```
3. Compile the project:
    ```
    make
    ```
4. Run the executable:
    ```
    ./raytracer
    ```

## Sample Output Gallery
<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/ionorb/CudaAcceleratedRayTracer/main/examples/mirror_balls.png" alt="Image 1" width="200"/></td>
    <td><img src="https://raw.githubusercontent.com/ionorb/CudaAcceleratedRayTracer/main/examples/multi_color.png" alt="Image 2" width="200"/></td>
<!--     <td><img src="https://raw.githubusercontent.com/ionorb/CudaAcceleratedRayTracer/main/examples/mirror_balls.png" alt="Image 3" width="200"/></td> -->
  </tr>
<!--   <tr>
    <td><img src="https://raw.githubusercontent.com/ionorb/CudaAcceleratedRayTracer/main/examples/mirror_balls.png" alt="Image 4" width="200"/></td>
    <td><img src="https://raw.githubusercontent.com/ionorb/CudaAcceleratedRayTracer/main/examples/mirror_balls.png" alt="Image 5" width="200"/></td>
    <td><img src="https://raw.githubusercontent.com/ionorb/CudaAcceleratedRayTracer/main/examples/mirror_balls.png" alt="Image 6" width="200"/></td>
  </tr> -->
</table>

## Future Plans
- Implement mirror reflection support on the GPU by converting recursive function into a loop.
- Add more texture options and material types.

## Contributions
Feel free to fork this project, open a pull request, or submit issues to contribute!

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
