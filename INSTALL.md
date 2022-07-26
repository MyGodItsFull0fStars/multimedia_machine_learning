# Installation

## Keras - Intel Silicone

1. `conda create -n multimedia_ml python=3.10`
2. `conda activate multimedia_ml`
3. `conda install -c conda-forge tensorflow keras`
4. `conda install -c anaconda ipykernel matplotlib`
5. `conda install --name multimedia_ml autopep8 -y`


## Keras - Apple M1 Silicone

1. `conda create -n multimedia_ml python=3.10`
2. `conda activate multimedia_ml`
3. `conda install -c apple tensorflow-deps`
4. `python -m pip install tensorflow-macos`
5. `python -m pip install tensorflow-metal`
6. `conda install jupyterlab`
7. `conda install -c anaconda ipykernel matplotlib`
