# JupyterLab environment w/ torch and [CUDA](https://www.youtube.com/watch?v=PeMvMNpvB5M)

## Getting started

### Pull from ghcr

```
docker pull ghcr.io/nonsignificantp/torch-cuda-jupyter-environ:main
```

```
docker run -it --rm -p 8888:8888 ghcr.io/nonsignificantp/torch-cuda-jupyter-environ:main
```

### Build from source

Clonar el repositorio

```
git clone git@github.com:nonsignificantp/torch-cuda-jupyter-environ.git
```

#### Con docker

Crear la imagen

```
docker build -t app/pytorch-cuda-jupyter:latest .
```

Arrancar un container

```
docker run -it --rm -p 8888:8888 app/pytorch-cuda-jupyter
```

Se levantara una instancia de jupyter lab accesible desde el navegador ([http://localhost:8888/lab/](http://localhost:8888/lab/)).

#### Con make

```
make jupyter
```

### Setting up a workdir

El mapeo de un directorio de trabajo debe apuntar a la carpeta `/workspace` dentro del container. A modo de ejemplo:

```
docker run -it --rm \
    -p 8888:8888 \
    -v /path/to/my/workspace:/workspace
    app/pytorch-cuda-jupyter
```
