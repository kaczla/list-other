# Vocab Size as a Multiple of 64

Source: [twitter](https://twitter.com/karpathy/status/1621578354024677377) (access March 2023)

The most dramatic optimization to nanoGPT so far (~25% speedup) is to simply increase vocab size from 50257 to 50304
(nearest multiple of 64). This calculates added useless dimensions but goes down a different kernel path with much
higher occupancy. Careful with your Powers of 2.
