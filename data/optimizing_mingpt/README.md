# Optimizing minGPT from 495ms to 102ms

Source: [twitter](https://twitter.com/karpathy/status/1607791537978748929) (access January 2023)

having fun optimizing minGPT today

- base: 495ms
- `zero_grad(set_to_none=True)`: 492
- `torch.jit.script` `gelu`: 463
- `OMP_PROC_BIND=CLOSE`: 453
- `torch.backends.cuda.matmul.allow_tf32`: 143
- `torch.autocast(torch.bfloat16)`: 121
- FlashAttention: 102

now: more fused kernels more better
