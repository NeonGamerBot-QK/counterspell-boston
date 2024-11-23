from svgpathtools import svg2paths


# Load SVG paths
svg_file = "./ASSETS/Trans-Dark.svg"
paths, attributes = svg2paths(svg_file)

# Function to sample points along a path
def sample_points(path, num_points=100):
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
    points = sample_points(path)
    print(", ".join(f"{p[0]-158}, {p[1]-457.5}" for p in points))