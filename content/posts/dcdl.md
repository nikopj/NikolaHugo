---
title: "Deep Convolutional Dictionary Learning for Image Restoration"
date: 2021-01-17
draft: false
katex: false
toc: false
comments: false
---

<img src="/dcdl/cdlnet_blockdiagram.png" alt="CDLNet Block Diagram" width="1500" align="middle"> 
{{< center >}}
CDLNet Block Diagram.
{{< /center >}}

## Project Overview
Sparse representation is a proven and powerful prior for natural images and
restoration tasks (such as denoising, deblurring, in-painting, etc.) involving
them. More than simply finding these representations, learning an over-complete
dictionary for sparse signal representation from degraded signals have been
shown to be effective models. Furthermore, the convolutional dictionary learning
(CDL) model seeks to represent the global signal via a translated local
dictionary. This offers a more holistic approach for natural image
representation compared to inherently suboptimal patch-processing methods. The
dictionary learning problem is traditionally solved by iteratively compute
spare-codes (representations) for a fixed dictionary, and subsequently updating
the dictionary accordingly. 

In this project, **we explore an interpretable Deep
Learning architecture for image restoration based on an unrolled CDL model**. More
specifically, we leverage the LISTA framework to obtain approximate
convolutional sparse codes, followed by a synthesis from a convolutional
dictionary. We call this architecture **CDLNet**. The network is trained in a
task-driven fashion, amenable to any linear inverse-problem. Interpretability of
such networks allow us to further extend the framework for the specific signal
class and generalization requirements at hand.

## Participants
- Yao Wang, Advising Professor, [Lab Page](https://wp.nyu.edu/videolab/)
- [Nikola Janjušević](https://nikopj.github.io), Ph.D. student
- [Amir Khalilian](https://amirhkhalilian.github.io/), Ph.D. student

## Recent Progress
- *In January 2021*, we will be presenting updated results regarding truly
  competitive denoising performance against state-of-the-art deep-learning
  models and leveraging the interpretability of CDLNet to improve generalization in
  blind denoising. Our poster will be available
  [here](/dcdl/CDLNetPosterWireless21.pdf).
- *In April 2020*, we presented some preliminary results at the NYU Wireless
Industrial Affiliates Board Meeting. Check out our poster
[here](/dcdl/CDLNetPosterWireless20.pdf).

