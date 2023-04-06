# PyTorch, Gradient Accumulation, and the dreaded drop in speed

"What follows below is an exploratory analysis I performed using Hugging Face Accelerate, PyTorch Distributed, and three machines to test what and by how much is the optimal and correct setup for gradient accumulation on multiple GPUs."

Source: [Zach Mueller blog](https://muellerzr.github.io/blog/gradient_accumulation.html) (access March 2023)

Comparing Hugging Face Accelerate, PyTorch Distributed and gradient accumulation.
