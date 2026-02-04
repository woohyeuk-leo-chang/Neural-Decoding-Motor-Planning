# Neural Decoding of Motor Planning and Barrier Interference

This repository contains a computational neuroscience pipeline implemented in **MATLAB** to investigate the neural and behavioral aftermath of barrier presentation during motor planning. Using primate electrophysiology data (M1 and PMd), the project employs **Machine Learning classification**, **Signal Detection Theory**, and **Dimensionality Reduction** to decode how obstacles alter neural population dynamics.

A detailed computational walkthrough of this analysis, including all data visualizations (histograms, loss curves, and neural trajectories), is available in the **Project.pdf**.

## 🧠 Project Overview

The study explores whether neural firing patterns can distinguish between trials with and without physical barriers during a reaching task. Key research questions include:

* **Decoding Accuracy:** Can we classify trial types (barrier vs. no-barrier) based on neural firing rates? 
* **Regional Specialization:** Does the Premotor Cortex (PMd) show a decoding advantage over the Primary Motor Cortex (M1) during the planning phase? 
* **Neural Variability:** How does motor planning affect neural variability (Fano Factor) over time? 

## 💻 Technical Implementation

* **Classification & Decoding:** Implemented machine learning classifiers to detect significant neural differences, finding that **PMd neurons** outperformed M1 neurons in classifying barrier presence.
* **Dimensionality Reduction:** Utilized **Principal Component Analysis (PCA)** to analyze neural population trajectories.
* **Data Normalization:** Evaluated multiple normalization schemes (Raw, Z-score, and Soft Normalization), identifying **Soft Normalization** as the most effective method for capturing variance across PCs.
* **Temporal Dynamics:** Analyzed the temporal evolution of motor planning, observing a decrease in neural variability in the PMd as the subject plans hand movements toward a target.

## 📈 Key Findings

* **PMd Superiority:** PMd activity provides a more robust signal for decoding environmental constraints (barriers) compared to M1.
* **Optimization Tradeoffs:** Demonstrated that normalization significantly impacts the "utilization" of Principal Components, where soft-normalized data required ~22 PCs to reach the information bottleneck compared to only ~8 for raw data.
* **Planning Variability:** Confirmed the "quenching" of neural variability during the delay period, a hallmark of motor preparation.

## 🛠️ Tools Used

* **Language:** MATLAB (including Live Scripts for computational narratives) 
* **Methods:** PCA, Machine Learning Classification, Fano Factor Analysis, Signal Processing 

## 📊 Data Availability

The electrophysiology and behavioral data analyzed in this repository were provided as part of the **"Methods in Computational Neuroscience"** curriculum at the University of Chicago.

Per the educational data-sharing agreement and to respect the proprietary nature of the original experimental maze dataset, the raw data files (`mazeJ0918Simple3.mat`) are **not publicly available** for redistribution. This ensures compliance with the original laboratory's data management policies.

For those interested in the foundational study or the primary dataset, please refer to the original research:

* Churchland et al. (2012). Neural population dynamics during reaching. Nature.
* See also: Kaufman et al. (2014). Cortical activity in the null space: permitting preparation without movement. Nature Neuroscience.

