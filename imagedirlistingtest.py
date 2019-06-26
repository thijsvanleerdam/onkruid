import os
for file in os.listdir("images/train"):
    if file.endswith(".jpg"):
        print(os.path.join("images/train", file))