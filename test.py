from PIL import Image
import os

def cut_image_into_9(image_path: str, output_folder: str):
    # Load the image
    img = Image.open(image_path)
    width, height = img.size

    # First crop it into a square (centered)
    side_length = min(width, height)
    left = (width - side_length) // 2
    top = (height - side_length) // 2
    right = left + side_length
    bottom = top + side_length
    img = img.crop((left, top, right, bottom))

    # Now img is a square!

    # Calculate width and height of each piece
    piece_width = side_length // 3
    piece_height = side_length // 3

    # Ensure output folder exists
    os.makedirs(output_folder, exist_ok=True)

    # Cut the image into 9 parts
    for row in range(3):
        for col in range(3):
            left = col * piece_width
            upper = row * piece_height
            right = (col + 1) * piece_width
            lower = (row + 1) * piece_height

            piece = img.crop((left, upper, right, lower))
            piece.save(os.path.join(output_folder, f"{image_path.strip(r'.png') }_{row}_{col}.png"))


# Example usage
dest_path = r"frontend/src/assets"
resource_paths = [
    r"0.png",
    r"1.png",
    r"2.png",
    r"3.png",
    r"4.png",
    r"5.png"
]

for path in resource_paths:
    cut_image_into_9(path, dest_path)