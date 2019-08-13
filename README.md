# pFaces

pFaces is a generic Cloud-ready, multi-compute-platform, tool for accelerating parallel algorithms. 
Although it is highly modular, the current functionality of pFaces targets the research area of the design and implementation of cyber-pysical systems. 
pFaces is an acceleration enigne that works with kernels representing different use-cases. 
The main features of engine of pFaces are:

  - A task-independent engine allowing for extensible usage and  automated acceleration of any compue-intensive algorithm.
  - Implemnts a hybrid MPI/OpenCL model targeting non-uniform clusters of heterogenous parallel compute devices, including: CPUs, GPUs and HW-accelerators.
  - Automated identification and utilization of node-level computation power and memory matching the case under acceleration.
  - Supports for automated online compilation of source kernels to match and utilize the features of underlying processing power of executing devices.
  - Customizable logging engine.
  - Native support for Linux, Windows and MacOS operating systems.

pFaces is intended to be a commertial acceleration ecosystem.
We provide here a demo version of pFaces with the following limited functionalities:
  - Running within a single compute-node. This means: you cannot use this demo version of pFaces within a cluster of multiple interconnected machines.
  - Running pFaces with one CPU, one GPU, or one HWA. Thios means: you cannot combine multiple devices to increase the number of processing elements. The targeted device can not have more than 20 compute units (e.g., 20 processor cores in an Intel CPU).
  - We provide only binaries that are compatibale Ubuntu 16.04, Ubuntu 18.04, Windows 10, and Mac Mojave.
  - Kernel auto-tuning is disabled.

Interessted users/developers can request exclusive non-redistributable EULA-covered access to a 
fully functional version after contacting [Mahmoud Khaled](www.mahmoud-khaled.com) personally.


# Kernels in pFaces
Kernels in pFaces are developed in an extensible version of OpenCL using some inline pFaces-related extensions and C++ interfaces. 
Any legacy OpenCL-kernel can be reimplemented to work with pFaces. 
Kernels in pFaces can be injected with some special markup languages that can be controlled by a kernel driver. 
A kernel driver is responsible for rendering the kernel to match the devices and the task under consideration and should be developed in C++. 
Kernel files migh contain several OpenCL-functions and the kernel driver coordinates the exections as desired. 
Afterwards, pFaces takes care of running the kernel using all targeted devices. 

  
# Installation


## Windows

1- Make sure you install the required drivers or OpenCL runtimes for the targeted devices.
1- Make sure you have [latest MS Visual C++ libraries](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads).


## Linux/MacOs

1- Install the OpenCL drivers. You may consider the helper scripts in **pfaces-sdk/build-utils**.
2- Run the [install script (install.sh)](./install.sh) in from a terminal using your preferred sh, bash or dash.


# Example Kernels

The following are open-source software tools that use pFaces for acceleration. Users can benifit from those tools to have an idea how pFaces work:
- [AMYTISS](https://github.com/mkhaled87/pFaces-AMYTISS): A pFaces's kernel on for parallel automated controller synthesis for large-scale stochastic systems.
- [PIRK](https://github.com/alexdevonport/pfaces-pirk): A utility for parallel computation of interval overapproximations to reachable sets of nonlinear control systems.
 
We will be contiously priding examples on using pFaces in this repo.

# Kickstart Examples
The following list of commands show kickstart examples that makes you familiar with pFaces.
We assue you already installed pFaces.
We assume you can start a terminal session ond change the directory to the one built kernel like the ones in the previous section.
For example, we assume you also downloaded and installed the kernel [AMYTISS](https://github.com/mkhaled87/pFaces-AMYTISS).

### Show the help menu:
```
./pfaces -h
```

### List all availble CPU/GPU/HW-Accelerator devices:
```
./pfaces -CGH -l
```

### Run and profile the (gpu) version of the kernel (AMYTISS) with an example config file in device from the list all GPUs:
```
./pfaces -G -k amytiss.gpu -cfg path/to/config.cfg -p -d 1
```

### Run and profile the kernel (AMYTISS) with an example config file in devices #1 and #2 from all CPU/GPU devices, use host-side memory, and tune the kernel on-the-fly before execution:
```
./pfaces -CG -t -k amytiss -cfg path/to/config.cfg -p -d 1,2 -hm
```

### Run and profile the (cpu) version of the kernel (AMYTISS) with two devices #1 and #2 from all CPU devices using a static job distribution 78% to 22%:
```
./pfaces -C -k amytiss.cpu -cfg path/to/config.cfg -p -d 1,2 -f 0.78,0.22
```
