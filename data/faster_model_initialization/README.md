# Making model initialization faster in PyTorch

Source [Lernapparat blog](https://lernapparat.de/faster-model-init) (access March 2023)

## Standard model initialization

A typical first step is:

```python
import nanogpt.model as nanogpt
model = nanogpt.GPT.from_pretrained("gpt2-xl", {}).to("cuda")
```

but this is kind of slow. How slow?

```python
%timeit model = nanogpt.GPT.from_pretrained("gpt2-xl", {}).to("cuda")
```

gives

```log
13.8 s ± 130 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```

## Faster model initialization

```python
import torch.utils._device

class EmptyInitOnDevice(torch.overrides.TorchFunctionMode):
    def __init__(self, device=None):
        self.device = device

    def __torch_function__(self, func, types, args=(), kwargs=None):
        kwargs = kwargs or {}
        if getattr(func, '__module__', None) == 'torch.nn.init':
            if 'tensor' in kwargs:
                return kwargs['tensor']
            else:
                return args[0]
        if self.device is not None and func in torch.utils._device._device_constructors() and kwargs.get('device') is None:
            kwargs['device'] = self.device
        return func(*args, **kwargs)
```

And then we can call

```python
with EmptyInitOnDevice("cuda"):
   model = nanogpt.GPT.from_pretrained("gpt2-xl", {})
```

feels much faster. But my motto is it's not optimization until we measure, so:

```python
with EmptyInitOnDevice("cuda"):
    %timeit model = nanogpt.GPT.from_pretrained("gpt2-xl", {})
```

gives

```log
2.26 s ± 10.9 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```