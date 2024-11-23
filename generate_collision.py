import numpy as np
from svgpathtools import svg2paths


# Load SVG paths
svg_file = "./ASSETS/Trans-Dark.svg"
paths, attributes = svg2paths(svg_file)


# Function to sample points along a path
def sample_points(path, num_points=200):
    total_length = path.length()
    sampled_points = []
    for i in range(num_points):
        distance = (i / (num_points - 1)) * total_length
        point = path.point(distance / total_length)
        sampled_points.append((point.real, point.imag))
    return sampled_points


# Extract points from all paths
all_points = []
for path in paths:
    points = sample_points(path, num_points=50)  # Sample from each path
    all_points.extend(points)

# If more points are needed, adjust accordingly
num_coordinates = 200
if len(all_points) > num_coordinates:
    sampled_coordinates = all_points[:num_coordinates]
else:
    sampled_coordinates = all_points

sampled_coordinates = sampled_coordinates[0:50]
print("")
print("")
print("")

all_coords = []
for i in sampled_coordinates:
    all_coords.append(i[0])
    all_coords.append(i[1])

print(all_coords)
