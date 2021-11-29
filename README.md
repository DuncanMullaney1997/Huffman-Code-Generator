# Huffman-Code-Generator
The included "huffman.m" file is a fully functioning MATLAB implementation of a Huffman code generator.
It takes in a label vector (the signal values) and a probability vector (the frequency distribution of each signal value).
The script returns the Huffman coding of these signal values.

In the context of digital image/video compression, we could be asked to compress an image.
Such a case presents an application for Huffman coding.
If we had the pixel intensity frequency distribution we could apply a Huffman method.

Huffman coding, in a nutshell, takes advantage of the fact that certain signal values appear _more frequently_ than others.
Less frequently occurring values can be encoded with _more_ bits, where more frequently occuring values are encoded with _less bits_.
See "output.png" file for a sample output.

Extra reading: https://www.geeksforgeeks.org/huffman-coding-greedy-algo-3/
